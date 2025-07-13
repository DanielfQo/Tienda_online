from flask import Blueprint, request, jsonify
from flask_jwt_extended import (create_access_token, jwt_required, get_jwt_identity)
from datetime import timedelta
from backend.services.user_service import (register_user, get_user_by_email, get_user_by_id)
from backend.schemas.user_schema import (UserRegisterSchema, LoginSchema, UserSchema)
from werkzeug.security import check_password_hash

user_bp = Blueprint("users", __name__, url_prefix="/api/users")

@user_bp.route("/register", methods=["POST"])
def register():
    data = UserRegisterSchema().load(request.json)
    new_user = register_user(data)
    return jsonify(UserSchema().dump(new_user)), 201

@user_bp.route("/login", methods=["POST"])
def login():
    data = LoginSchema().load(request.json)
    user = get_user_by_email(data["email"])
    if not user:
        return jsonify({"msg": "Email not in db"}), 404

    if not check_password_hash(user.password, data["password"]):
        return jsonify({"msg": "Incorrect password"}), 401

    access_token = create_access_token(
        identity=user.id,
        additional_claims={"role": user.role},
        expires_delta=timedelta(hours=4)
    )

    return jsonify(access_token=access_token), 200

@user_bp.route("/profile", methods=["GET"])
@jwt_required()
def profile():
    user_id = get_jwt_identity()
    user = get_user_by_id(user_id)
    if not user:
        return jsonify({"msg": "User not found"}), 404

    return jsonify(UserSchema().dump(user)), 200
