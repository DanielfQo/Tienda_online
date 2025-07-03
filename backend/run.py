from flask import Flask
from extensions import db, migrate, jwt, cors
from config import Config
from controllers.producto_controller import producto_bp
# from controllers.usuario_controller import auth_bp
import models  # Asegura que se carguen todos los modelos

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)  # cargamos configuración desde config.py

    db.init_app(app)
    migrate.init_app(app, db)
    jwt.init_app(app)
    cors.init_app(app)

    app.register_blueprint(producto_bp, url_prefix='/api/productos')
    #app.register_blueprint(auth_bp, url_prefix='/api/auth')
    return app


if __name__ == "__main__":
    app = create_app()

    with app.app_context():
        db.create_all()
        
    app.run(debug=True)
