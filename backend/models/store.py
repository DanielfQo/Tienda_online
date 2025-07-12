from extensions import db

class Store(db.Model):
    __tablename__ = 'stores'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    address = db.Column(db.Text, nullable=False)
    created_at = db.Column(db.DateTime)

    users = db.relationship("User", backref="store")
    products = db.relationship("Product", backref="store")
