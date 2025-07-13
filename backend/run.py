from flask import Flask
from backend.extensions import db, migrate, jwt, cors
from backend.config import Config
from backend.controllers.product_controller import product_bp
from backend.controllers.user_controller import user_bp 
import backend.models 

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    db.init_app(app)
    migrate.init_app(app, db)
    jwt.init_app(app)
    cors.init_app(app)

    app.register_blueprint(product_bp, url_prefix='/api/product')
    app.register_blueprint(user_bp)  # Registro

    return app

app = create_app()

if __name__ == "__main__":

    app.run(debug=True)
