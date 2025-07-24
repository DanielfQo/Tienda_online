from backend.extensions import db
from backend.models.product import Product, ProductDiscount
from datetime import datetime

def list_products():
    out_of_stock = Product.query.filter(Product.stock == 0).all()
    in_stock = Product.query.filter(Product.stock > 0).all()
    return out_of_stock + in_stock

def list_products(only_published=True):
    q = Product.query
    if only_published and hasattr(Product, 'published'):
        q = q.filter_by(published=True)
    return q.all()


def get_product_by_id(product_id):
    return Product.query.get(product_id)

def create_product(data):
    prod = Product(**data)
    db.session.add(prod)
    db.session.commit()
    return prod

def adjust_stock(product, new_stock):
    product.stock = max(0, new_stock)
    db.session.commit()
    return product

def increase_stock(product, amount):
    if amount <= 0:
        raise ValueError("Cantidad debe de ser mayor que cero.")
    product.stock += amount
    db.session.commit()
    return product

def update_product(product, data):
    for key, value in data.items():
        setattr(product, key, value)
    db.session.commit()
    return product

def delete_product(product):
    product.stock = 0
    db.session.commit()
    return product

def get_product_with_discount(product_id):
    product = get_product_by_id(product_id)

    if not product:
        return None

    active_discount = None
    for discount in product.discounts:
        if discount.is_currently_active():
            active_discount = discount
            break

    price = product.price

    if active_discount:
        discount_amount = (active_discount.percentage / 100) * price
        price -= discount_amount

    return {
        "id": product.id, "name": product.name,
        "description": product.description,
        "original_price": float(product.price),
        "discounted_price": float(price),
        "discount_percentage": active_discount.percentage if active_discount else None,
        "stock": product.stock
    }