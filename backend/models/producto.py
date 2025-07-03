from extensions import db
from models.venta import DetalleVenta
from datetime import datetime

class Categoria(db.Model):
    __tablename__ = 'categorias'
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)
    descripcion = db.Column(db.Text)

    productos = db.relationship("Producto", backref="categoria")


class ImagenProducto(db.Model):
    __tablename__ = "imagenes_producto"
    id = db.Column(db.Integer, primary_key=True)
    producto_id = db.Column(db.Integer, db.ForeignKey("productos.id"), nullable=False)
    url = db.Column(db.String(255), nullable=False)

class Producto(db.Model):
    __tablename__ = "productos"
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)
    descripcion = db.Column(db.Text)
    precio = db.Column(db.DECIMAL(10, 2), nullable=False)
    stock = db.Column(db.Integer, nullable=False)
    categoria_id = db.Column(db.Integer, db.ForeignKey("categorias.id"))
    tienda_id = db.Column(db.Integer, db.ForeignKey("tiendas.id"))
    fecha_registro = db.Column(
        db.DateTime,
        default=db.func.now(),
        onupdate=db.func.now()
    )

    imagenes = db.relationship("ImagenProducto", backref="producto", cascade="all, delete-orphan")

    def is_disponible(self):
        return self.stock > 0

    def aumentar_stock(self, new_stock):
        self.stock = self.stock + new_stock


class Atributo(db.Model):
    __tablename__ = 'atributos'
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)

    valores = db.relationship("ValorProducto", backref="atributo")


class ValorProducto(db.Model):
    __tablename__ = 'valores_producto'
    id = db.Column(db.Integer, primary_key=True)
    producto_id = db.Column(db.Integer, db.ForeignKey('productos.id'))
    atributo_id = db.Column(db.Integer, db.ForeignKey('atributos.id'))
    valor = db.Column(db.String(100), nullable=False)
