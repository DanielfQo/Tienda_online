from flask import Blueprint, request, jsonify
from flask_jwt_extended import (create_access_token, jwt_required, get_jwt_identity)
from datetime import timedelta
from backend.services.user_service import (register_user, get_user_by_email, get_user_by_id, update_user_profile, upload_profile_photo)
from backend.schemas.user_schema import (UserRegisterSchema, LoginSchema, UserSchema, UserUpdateSchema)
from werkzeug.security import check_password_hash

user_bp = Blueprint("users", __name__, url_prefix="/api/users")

@user_bp.route("/register", methods=["POST"])
def register():
    print("Datos recibidos del frontend:")
    print(request.json)
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
    identity=str(user.id),
    additional_claims={"role": user.role},
    expires_delta=timedelta(hours=4)
)


    return jsonify(access_token=access_token), 200

@user_bp.route("/profile", methods=["GET"])
@jwt_required()
def get_profile():
    user_id = get_jwt_identity()
    user = get_user_by_id(user_id)

    if not user:
        return jsonify({"error": "User not found"}), 404

    return jsonify({"user": UserSchema().dump(user)}), 200


@user_bp.route("/profile/photo", methods=["POST"])
@jwt_required()
def change_profile_photo():
    user_id = get_jwt_identity()
    return upload_profile_photo(user_id, request)


@user_bp.route("/profile/update", methods=["PUT"])
@jwt_required()
def update_profile():
    user_id = get_jwt_identity()
    data = UserUpdateSchema().load(request.get_json())

    updated_user = update_user_profile(user_id, data)
    if not updated_user:
        return jsonify({"error": "User not found"}), 404

    return jsonify({"user": UserSchema().dump(updated_user)}), 200

