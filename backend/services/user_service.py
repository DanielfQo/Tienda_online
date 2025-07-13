from backend.extensions import db
from backend.models.user import User
from werkzeug.security import generate_password_hash

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
    db.session.commit()
    return user

def get_user_by_email(email):
    return User.query.filter_by(email=email).first()

def get_user_by_id(user_id):
    return User.query.get(user_id)