from extensions import db  

class Prestamo(db.Model):
    __tablename__ = 'prestamos'
    id = db.Column(db.Integer, primary_key=True)
    monto = db.Column(db.DECIMAL(10, 2), nullable=False)
    fecha = db.Column(db.Date, nullable=False)
    plazo = db.Column(db.Integer, nullable=False)
    estado = db.Column(db.Enum('pendiente', 'aprobado', 'rechazado', 'pagado', name='estado_prestamo_enum'), nullable=False)
    cliente_id = db.Column(db.Integer, db.ForeignKey('clientes.usuario_id'), nullable=False)

    cliente = db.relationship("Cliente", backref="prestamos")
