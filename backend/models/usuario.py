from extensions import db

class Usuario(db.Model):
    __tablename__ = 'usuarios'
    
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)
    correo = db.Column(db.String(120), unique=True, nullable=False)
    contrasena_hash = db.Column(db.String(255), nullable=False)  # Aquí se guarda el hash de la contraseña
    rol = db.Column(db.Enum('cliente', 'admin', 'empleado', name='rol_enum'), nullable=False)
    verificado = db.Column(db.Boolean, default=False)
    tienda_id = db.Column(db.Integer, db.ForeignKey('tiendas.id'))
    creado_en = db.Column(db.DateTime)

    cliente = db.relationship("Cliente", uselist=False, back_populates="usuario")
    admin = db.relationship("Admin", uselist=False, back_populates="usuario")
    empleado = db.relationship("Empleado", uselist=False, back_populates="usuario")

class Cliente(db.Model):
    __tablename__ = 'clientes'
    usuario_id = db.Column(db.Integer, db.ForeignKey('usuarios.id'), primary_key=True)
    direccion_envio = db.Column(db.String(255))
    telefono = db.Column(db.String(20))

    usuario = db.relationship("Usuario", back_populates="cliente")

class Admin(db.Model):
    __tablename__ = 'admins'
    usuario_id = db.Column(db.Integer, db.ForeignKey('usuarios.id'), primary_key=True)
    nivel_acceso = db.Column(db.Integer)

    usuario = db.relationship("Usuario", back_populates="admin")

class Empleado(db.Model):
    __tablename__ = 'empleados'
    usuario_id = db.Column(db.Integer, db.ForeignKey('usuarios.id'), primary_key=True)
    puesto = db.Column(db.String(30))
    fecha_contratacion = db.Column(db.DateTime)

    usuario = db.relationship("Usuario", back_populates="empleado")
