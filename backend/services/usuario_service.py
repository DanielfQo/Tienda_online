from extensions import db
from models.usuario import Usuario
from werkzeug.security import generate_password_hash

def registrar_usuario(data):
    hashed_password = generate_password_hash(data["contrasena"])
    user = Usuario(
        nombre=data["nombre"],
        correo=data["correo"],
        contrasena=hashed_password,
        rol=data["rol"],
        tienda_id=data.get("tienda_id")
    )
    db.session.add(user)
    db.session.commit()
    return user

def obtener_usuario_por_email(correo):
    return Usuario.query.filter_by(correo=correo).first()

def obtener_usuario_por_id(usuario_id):
    return Usuario.query.get(usuario_id)
