from extensions import db

class Tienda(db.Base):
    __tablename__ = 'tiendas'
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)
    direccion = db.Column(db.Text, nullable=False)
    fecha_creacion = db.Column(db.DateTime)

    usuarios = db.relationship("Usuario", backref="tienda")
    productos = db.relationship("Producto", backref="tienda")
