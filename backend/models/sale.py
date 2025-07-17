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
    payment_method_id = db.Column(db.Integer, db.ForeignKey("payment_methods.id"))

    client = db.relationship("Client", backref="sales")
    details = db.relationship("SaleDetail", backref="sale")
    payment_method = db.relationship("PaymentMethod")


class SaleDetail(db.Model):
    __tablename__ = 'sale_details'
    id = db.Column(db.Integer, primary_key=True)
    sale_id = db.Column(db.Integer, db.ForeignKey('sales.id'), nullable=False)
    product_id = db.Column(db.Integer, db.ForeignKey('products.id'), nullable=False)
    quantity = db.Column(db.Integer, nullable=False)
    unit_price = db.Column(db.DECIMAL(10, 2), nullable=False)
    purchase_price = db.Numeric(10,2)

class PaymentMethod(db.Model):
    __tablename__ = "payment_methods"
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
    type = db.Column(db.Enum("credit_card", "debit_card", "cash", "bank_transfer", name="payment_type_enum"), nullable=False)
    provider = db.Column(db.String(100))
    account_number = db.Column(db.String(50))
    expiration_date = db.Column(db.Date)

    user = db.relationship("User", backref="payment_methods")
