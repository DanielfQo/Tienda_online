from extensions import db

class Gasto(db.Model):
    __tablename__ = 'gastos'
    id = db.Column(db.Integer, primary_key=True)
    monto = db.Column(db.DECIMAL(10, 2), nullable=False)
    categoria = db.Column(db.String(100), nullable=False)
    motivo = db.Column(db.Text)
    fecha = db.Column(db.Date, nullable=False)
    cliente_id = db.Column(db.Integer, db.ForeignKey('clientes.usuario_id'), nullable=False)

    cliente = db.relationship("Cliente", backref="gastos")
