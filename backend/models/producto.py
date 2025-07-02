from extensions import db
from datetime import datetime

class Producto(db.Model):
    __tablename__ = 'productos'
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)
    descripcion = db.Column(db.Text, nullable=True)
    precio = db.Column(db.Float, nullable=False)
    stock = db.Column(db.Integer, default=0)
    categoria = db.Column(db.String(50), nullable=True)
    tienda_id = db.Column(db.Integer, nullable=True)
    fecha_registro = db.Column(
        db.DateTime,
        nullable=True,
        default=datetime.utcnow,
        onupdate=datetime.utcnow
    )

    def is_disponible(self):
        return self.stock > 0
    
    def aumentar_stock(self, new_stock):
        self.stock = self.stock + new_stock
