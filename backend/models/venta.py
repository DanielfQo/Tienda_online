from extensions import db

class Venta(db.Model):
    __tablename__ = 'ventas'
    id = db.Column(db.Integer, primary_key=True)
    cliente_id = db.Column(db.Integer, db.ForeignKey('clientes.usuario_id'), nullable=False)
    fecha = db.Column(db.DateTime, nullable=False)
    total = db.Column(db.DECIMAL(10, 2), nullable=False)
    metodo_pago = db.Column(db.Enum('efectivo', 'tarjeta', 'transferencia', name='metodo_pago_enum'), nullable=False)
    estado = db.Column(db.Enum('pendiente', 'pagado', 'cancelado', name='estado_venta_enum'), nullable=False)

    cliente = db.relationship("Cliente", backref="ventas")
    detalles = db.relationship("DetalleVenta", backref="venta")


class DetalleVenta(db.Model):
    __tablename__ = 'detalles_venta'
    id = db.Column(db.Integer, primary_key=True)
    venta_id = db.Column(db.Integer, db.ForeignKey('ventas.id'), nullable=False)
    producto_id = db.Column(db.Integer, db.ForeignKey('productos.id'), nullable=False)
    cantidad = db.Column(db.Integer, nullable=False)
    
    precio_unitario = db.Column(db.DECIMAL(10, 2), nullable=False)

    producto = db.relationship("Producto", backref="detalles_venta")