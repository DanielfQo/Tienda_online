from extensions import db

class IntentoLogin(db.Model):
    __tablename__ = 'intentos_login'
    id = db.Column(db.Integer, primary_key=True)
    usuario_id = db.Column(db.Integer, db.ForeignKey('usuarios.id'))
    exito = db.Column(db.Boolean, nullable=False)
    fecha = db.Column(db.DateTime, nullable=False)
    ip = db.Column(db.String(45))  # Soporta IPv4 e IPv6

    usuario = db.relationship("Usuario", backref="intentos_login")
