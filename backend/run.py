from flask import Flask
from extensions import db, migrate, jwt, cors
from config import Config
from backend.controllers.product_controller import producto_bp
from backend.controllers.user_controller import usuario_bp 
import models 

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    db.init_app(app)
    migrate.init_app(app, db)
    jwt.init_app(app)
    cors.init_app(app)

    app.register_blueprint(producto_bp, url_prefix='/api/productos')
    app.register_blueprint(usuario_bp)  # Registro
    return app

if __name__ == "__main__":
    app = create_app()

    with app.app_context():
        db.create_all()

    app.run(debug=True)
