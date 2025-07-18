import pytest
import json
from flask import Flask
from backend.extensions import db
from backend.controllers.user_controller import user_bp
from flask_jwt_extended import JWTManager

@pytest.fixture
def app():
    app = Flask(__name__)
    app.config["TESTING"] = True
    app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///:memory:"
    app.config["JWT_SECRET_KEY"] = "super-secret-test-key"
    db.init_app(app)
    jwt = JWTManager(app)
    app.register_blueprint(user_bp)

    with app.app_context():
        db.create_all()
        yield app
        db.drop_all()

@pytest.fixture
def client(app):
    return app.test_client()

def test_register_login_profile(client):
    # 1. Registro
    register_data = {
        "name": "Michael",
        "email": "michael@example.com",
        "password": "password123",
        "role": "client"
    }

    response = client.post(
        "/api/users/register",
        data=json.dumps(register_data),
        content_type="application/json"
    )

    assert response.status_code == 201
    response_json = response.get_json()
    assert "id" in response_json or "email" in response_json

    # 2. Login
    login_data = {
        "email": "michael@example.com",
        "password": "password123"
    }

    response = client.post(
        "/api/users/login",
        data=json.dumps(login_data),
        content_type="application/json"
    )

    assert response.status_code == 200
    login_json = response.get_json()
    assert "access_token" in login_json
    token = login_json["access_token"]

    # 3. Obtener perfil con el token
    response = client.get(
        "/api/users/profile",
        headers={"Authorization": f"Bearer {token}"}
    )

    assert response.status_code == 200
    profile_json = response.get_json()
    assert "user" in profile_json
    assert profile_json["user"]["email"] == "michael@example.com"
