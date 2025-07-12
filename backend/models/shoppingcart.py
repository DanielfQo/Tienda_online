from extensions import db

class ShoppingCart(db.Model):
    __tablename__ = 'shopping_carts'
    id = db.Column(db.Integer, primary_key=True)
    client_id = db.Column(db.Integer, db.ForeignKey('clients.user_id'), nullable=False)
    created_at = db.Column(db.DateTime, nullable=False)

    client = db.relationship("Client", backref="shopping_carts")


class Wishlist(db.Model):
    __tablename__ = 'wishlists'
    id = db.Column(db.Integer, primary_key=True)
    client_id = db.Column(db.Integer, db.ForeignKey('clients.user_id'), nullable=False)
    name = db.Column(db.String(100), nullable=False)
    created_at = db.Column(db.DateTime, nullable=False)

    client = db.relationship("Client", backref="wishlists")