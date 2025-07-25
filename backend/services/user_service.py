import os
import uuid
from flask import current_app, jsonify, request
from backend.extensions import db
from backend.models.user import User
from backend.models.user import Client 
from werkzeug.security import generate_password_hash
from werkzeug.utils import secure_filename

ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg'}

def register_user(data):
    hashed_password = generate_password_hash(data["password"])

    user = User(
        name=data["name"],
        email=data["email"],
        password=hashed_password,
        role=data["role"],
        store_id=data.get("store_id")
    )
    db.session.add(user)
    db.session.commit()  # Necesario para que user.id esté disponible

    # Si el usuario es cliente, crear entrada en Client
    if data["role"] == "client":
        client = Client(
            user_id=user.id,
        )
        db.session.add(client)
        db.session.commit()

    return user

def get_user_by_email(email):
    return User.query.filter_by(email=email).first()

def get_user_by_id(user_id):
    return User.query.get(user_id)

def update_user_photo(user_id, photo_filename):
    user = get_user_by_id(user_id)
    if not user:
        return None
    user.photo = photo_filename
    db.session.commit()
    return user


def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


def upload_profile_photo(user_id, request):
    user = get_user_by_id(user_id)
    if not user:
        return jsonify({"msg": "User not found"}), 404

    if 'photo' not in request.files:
        return jsonify({"msg": "No file uploaded"}), 400

    file = request.files['photo']
    if file.filename == '':
        return jsonify({"msg": "Empty filename"}), 400

    if file and allowed_file(file.filename):
        extension = file.filename.rsplit('.', 1)[1].lower()
        filename = f"{uuid.uuid4().hex}.{extension}"
        filename = secure_filename(filename)

        upload_folder = os.path.join(current_app.root_path, 'static', 'uploads')
        os.makedirs(upload_folder, exist_ok=True)

        # Delete previous photo
        if user.photo:
            old_path = os.path.join(upload_folder, user.photo)
            if os.path.exists(old_path):
                os.remove(old_path)

        file.save(os.path.join(upload_folder, filename))
        update_user_photo(user_id, filename)

        photo_url = f"{request.host_url}static/uploads/{filename}"
        return jsonify({
            "msg": "Profile photo updated successfully",
            "photo": filename,
            "photo_url": photo_url
        }), 200

    return jsonify({"msg": "Invalid file type. Only png, jpg, jpeg allowed."}), 400

def update_user_profile(user_id, data):
    user = User.query.get(user_id)
    if not user:
        return None

    if "name" in data:
        user.name = data["name"]
    if "gender" in data:
        user.gender = data["gender"]
    if "birth_date" in data:
        user.birth_date = data["birth_date"]
    if "photo" in data:
        user.photo = data["photo"]

    db.session.commit()
    return user