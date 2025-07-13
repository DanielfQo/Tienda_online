from backend.extensions import db
from backend.models.user import Client

class Sale(db.Model):
    __tablename__ = 'sales'
    id = db.Column(db.Integer, primary_key=True)
    client_id = db.Column(db.Integer, db.ForeignKey('clients.user_id'), nullable=False)
    date = db.Column(db.DateTime, nullable=False)
    total = db.Column(db.DECIMAL(10, 2), nullable=False)
    payment_method = db.Column(db.Enum('cash', 'card', 'transfer', name='payment_method_enum'), nullable=False)
    status = db.Column(db.Enum('pending', 'paid', 'cancelled', name='sale_status_enum'), nullable=False)

    client = db.relationship("Client", backref="sales")
    details = db.relationship("SaleDetail", backref="sale")


class SaleDetail(db.Model):
    __tablename__ = 'sale_details'
    id = db.Column(db.Integer, primary_key=True)
    sale_id = db.Column(db.Integer, db.ForeignKey('sales.id'), nullable=False)
    product_id = db.Column(db.Integer, db.ForeignKey('products.id'), nullable=False)
    quantity = db.Column(db.Integer, nullable=False)
    unit_price = db.Column(db.DECIMAL(10, 2), nullable=False)
