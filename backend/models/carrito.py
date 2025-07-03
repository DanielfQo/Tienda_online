from extensions import db

class Carrito(db.Model):
    __tablename__ = 'carrito'
    id = db.Column(db.Integer, primary_key=True)
    cliente_id = db.Column(db.Integer, db.ForeignKey('clientes.usuario_id'), nullable=False)
    creado_en = db.Column(db.DateTime, nullable=False)

    cliente = db.relationship("Cliente", backref="carritos")


class Wishlist(db.Model):
    __tablename__ = 'wishlist'
    id = db.Column(db.Integer, primary_key=True)
    cliente_id = db.Column(db.Integer, db.ForeignKey('clientes.usuario_id'), nullable=False)
    nombre = db.Column(db.String(100), nullable=False)
    creado_en = db.Column(db.DateTime, nullable=False)

    cliente = db.relationship("Cliente", backref="wishlists")
