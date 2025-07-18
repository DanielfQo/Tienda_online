import pytest
from flask import Flask
from flask_jwt_extended import JWTManager, create_access_token, decode_token
from backend.extensions import db
from backend.models.user import User
from backend.controllers.user_controller import user_bp
from werkzeug.security import generate_password_hash
import os
import sys

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))


@pytest.fixture
def app():
    app = Flask(__name__)
    app.config["TESTING"] = True
    app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///:memory:"
    app.config["JWT_SECRET_KEY"] = "testing-secret"
    app.config["UPLOAD_FOLDER"] = "static/uploads"

    # Inicializar extensiones
    db.init_app(app)
    jwt = JWTManager(app)

    # Registrar blueprint
    app.register_blueprint(user_bp)

    with app.app_context():
        db.create_all()
        yield app
        db.session.remove()
        db.drop_all()


@pytest.fixture
def client(app):
    return app.test_client()


def test_register_user(client):
    data = {
        "name": "John Doe",
        "email": "john@example.com",
        "password": "password123",
        "role": "client"
    }

    response = client.post("/api/users/register", json=data)
    assert response.status_code == 201
    json_data = response.get_json()
    assert json_data["name"] == "John Doe"
    assert json_data["email"] == "john@example.com"


def test_login_success(client):
    password = "password123"
    user = User(
        name="Jane Doe",
        email="jane@example.com",
        password=generate_password_hash(password),
        role="admin"
    )
    db.session.add(user)
    db.session.commit()

    data = {
        "email": "jane@example.com",
        "password": password
    }
    response = client.post("/api/users/login", json=data)
    assert response.status_code == 200
    assert "access_token" in response.get_json()


def test_login_wrong_password(client):
    user = User(
        name="Test User",
        email="test@example.com",
        password=generate_password_hash("correctpass"),
        role="client"
    )
    db.session.add(user)
    db.session.commit()

    response = client.post("/api/users/login", json={
        "email": "test@example.com",
        "password": "wrongpass"
    })
    assert response.status_code == 401
    assert response.get_json()["msg"] == "Incorrect password"


def test_get_profile(client):
    user = User(
        name="Alice",
        email="alice@example.com",
        password=generate_password_hash("securepass"),
        role="client"
    )
    db.session.add(user)
    db.session.commit()

    token = create_access_token(identity=str(user.id), additional_claims={"role": user.role})

    response = client.get(
        "/api/users/profile",
        headers={"Authorization": f"Bearer {token}"}
    )

    assert response.status_code == 200
    assert response.get_json()["user"]["email"] == "alice@example.com"


def test_update_profile(client):
    user = User(
        name="Bob",
        email="bob@example.com",
        password=generate_password_hash("pass"),
        role="client"
    )
    db.session.add(user)
    db.session.commit()

    token = create_access_token(identity=str(user.id), additional_claims={"role": user.role})

    new_data = {
        "name": "Bob Updated",
        "gender": "male",
        "birth_date": "1990-01-01"
    }

    response = client.put(
        "/api/users/profile/update",
        headers={"Authorization": f"Bearer {token}"},
        json=new_data
    )

    assert response.status_code == 200
    assert response.get_json()["user"]["name"] == "Bob Updated"


def test_upload_profile_photo(client, tmp_path):
    user = User(
        name="Carol",
        email="carol@example.com",
        password=generate_password_hash("123"),
        role="client"
    )
    db.session.add(user)
    db.session.commit()

    token = create_access_token(identity=str(user.id), additional_claims={"role": user.role})

    img_path = tmp_path / "profile.jpg"
    with open(img_path, "wb") as f:
        f.write(b"fake image data")

    with open(img_path, "rb") as img_file:
        response = client.post(
            "/api/users/profile/photo",
            headers={"Authorization": f"Bearer {token}"},
            content_type='multipart/form-data',
            data={"photo": (img_file, "profile.jpg")}
        )

    assert response.status_code == 200
    assert "photo_url" in response.get_json()
