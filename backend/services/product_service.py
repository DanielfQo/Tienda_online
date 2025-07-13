from extensions import db
from backend.models.product import Product

def list_products():
    out_of_stock = Product.query.filter(Product.stock == 0).all()
    in_stock = Product.query.filter(Product.stock > 0).all()
    return out_of_stock + in_stock

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
        raise ValueError("Quantity must be greater than zero.")
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
