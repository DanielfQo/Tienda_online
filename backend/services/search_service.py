from sqlalchemy import text
from backend.extensions import db
from backend.models import Product, ProductAttributeValue, Attribute

# Filtro de texto completo
def apply_text_search(query, search_text):
    if search_text:
        relevance = text("MATCH(name, description) AGAINST(:text IN NATURAL LANGUAGE MODE)")
        query = query.add_columns(relevance.label("relevance")) \
                     .filter(relevance) \
                     .params(text=search_text) \
                     .order_by(text("relevance DESC"))
    return query

# Filtro por atributos dinámicos
def apply_attribute_filters(query, attribute_filters):
    if attribute_filters:
        for attr_name, attr_value in attribute_filters.items():
            subq = db.session.query(ProductAttributeValue.product_id) \
                .join(Attribute) \
                .filter(
                    Attribute.name == attr_name,
                    ProductAttributeValue.value == attr_value
                ).subquery()
            query = query.filter(Product.id.in_(subq))
    return query

# Filtro por categoría
def apply_category_filter(query, category_id):
    if category_id:
        query = query.filter(Product.category_id == category_id)
    return query

# Filtro por rango de precio
def apply_price_filters(query, price_min, price_max):
    if price_min is not None:
        query = query.filter(Product.sale_price >= price_min)
    if price_max is not None:
        query = query.filter(Product.sale_price <= price_max)
    return query

# Filtro por stock
def apply_stock_filter(query, in_stock):
    if in_stock:
        query = query.filter(Product.stock > 0)
    return query

# Ordenamiento si no hay búsqueda por texto
def apply_ordering(query, order_by, search_text):
    if not search_text:
        if order_by == "price_asc":
            query = query.order_by(Product.sale_price.asc())
        elif order_by == "price_desc":
            query = query.order_by(Product.sale_price.desc())
        elif order_by == "date_desc":
            query = query.order_by(Product.created_at.desc())
        elif order_by == "name_asc":
            query = query.order_by(Product.name.asc())
    return query



def advanced_search(
    search_text=None,
    price_min=None,
    price_max=None,
    in_stock=False,
    order_by=None,
    attribute_filters=None,
    category_id=None
):
    query = Product.query

    query = apply_text_search(query, search_text)
    query = apply_category_filter(query, category_id)
    query = apply_price_filters(query, price_min, price_max)
    query = apply_stock_filter(query, in_stock)
    query = apply_attribute_filters(query, attribute_filters)
    query = apply_ordering(query, order_by, search_text)

    if search_text:
        result = query.all()
        return [row[0] for row in result]  # Solo devolver el Product
    else:
        return query.all()
