from backend.extensions import db
from datetime import datetime

class Category(db.Model):
    __tablename__ = 'categories'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    description = db.Column(db.Text)

    products = db.relationship("Product", backref="category")


class Attribute(db.Model):
    __tablename__ = 'attributes'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)

    values = db.relationship("ProductAttributeValue", backref="attribute")


class Product(db.Model):
    __tablename__ = "products"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    description = db.Column(db.Text)
    sale_price = db.Column(db.DECIMAL(10, 2), nullable=False)
    purchase_price = db.Column(db.DECIMAL(10, 2), nullable=False)
    stock = db.Column(db.Integer, nullable=False)
    category_id = db.Column(db.Integer, db.ForeignKey("categories.id"))
    store_id = db.Column(db.Integer, db.ForeignKey("stores.id"))
    created_at = db.Column(
        db.DateTime,
        default=db.func.now(),
        onupdate=db.func.now()
    )
    images = db.relationship(
        "ProductImage",
        backref="product",
        cascade="all, delete-orphan"
    )
    values = db.relationship("ProductAttributeValue", backref="product")

    __table_args__  = (db.Index('ix_prod_store_name', 'store_id','name', unique=True),)

    def is_available(self):
        return self.stock > 0

    def increase_stock(self, amount):
        self.stock += amount


class ProductImage(db.Model):
    __tablename__ = "product_images"
    id = db.Column(db.Integer, primary_key=True)
    product_id = db.Column(db.Integer, db.ForeignKey("products.id"), nullable=False)
    url = db.Column(db.String(255), nullable=False)


class ProductAttributeValue(db.Model):
    __tablename__ = "product_attribute_values"
    id = db.Column(db.Integer, primary_key=True)
    product_id = db.Column(db.Integer, db.ForeignKey("products.id"))
    attribute_id = db.Column(db.Integer, db.ForeignKey("attributes.id"))
    value = db.Column(db.String(100), nullable=False)

class ProductDiscount(db.Model):
    __tablename__ = "product_discounts"
    id = db.Column(db.Integer, primary_key=True)
    product_id = db.Column(db.Integer, db.ForeignKey("products.id"), nullable=False)
    percentage = db.Column(db.Numeric(5,2), nullable=False)
    start_date = db.Column(db.DateTime, nullable=False)
    end_date = db.Column(db.DateTime, nullable=True)
    active = db.Column(db.Boolean, default=True)

    product = db.relationship("Product", backref="discounts")