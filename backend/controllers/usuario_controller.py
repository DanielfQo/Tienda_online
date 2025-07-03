from flask import Blueprint, request, jsonify
from flask_jwt_extended import (
    create_access_token,
    jwt_required,
    get_jwt_identity
)
from datetime import timedelta
from services.usuario_service import (registrar_usuario, obtener_usuario_por_email, obtener_usuario_por_id )
from schemas.usuario_schema import (UserRegisterSchema, LoginSchema, UsuarioSchema)
from werkzeug.security import check_password_hash

usuario_bp = Blueprint("usuarios", __name__, url_prefix="/api/usuarios")

# 
@usuario_bp.route("/registro", methods=["POST"])
def registro():
    data = UserRegisterSchema().load(request.json)
    nuevo = registrar_usuario(data)
    return UsuarioSchema().jsonify(nuevo), 201


@usuario_bp.route("/login", methods=["POST"])
def login():
    data = LoginSchema().load(request.json)
    
    usuario = obtener_usuario_por_email(data["correo"])
    if not usuario:
        return jsonify({"msg": "Correo no registrado"}), 404
    
    if not check_password_hash(usuario.contrasena, data["contrasena"]):
        return jsonify({"msg": "Contraseña incorrecta"}), 401
    
    access_token = create_access_token(
        identity=usuario.id,
        additional_claims={"rol": usuario.rol},
        expires_delta=timedelta(hours=4)
    )
    
    return jsonify(access_token=access_token), 200


@usuario_bp.route("/perfil", methods=["GET"])
@jwt_required()
def perfil():
    usuario_id = get_jwt_identity()
    usuario = obtener_usuario_por_id(usuario_id)
    if not usuario:
        return jsonify({"msg": "Usuario no encontrado"}), 404

    return UsuarioSchema().jsonify(usuario), 200
