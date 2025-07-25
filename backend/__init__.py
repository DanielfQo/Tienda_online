from flask import Flask, jsonify
from .config import Config
from .extensions import db, migrate, jwt, cors

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)
    
    # extensions
    db.init_app(app)
    migrate.init_app(app, db)
    jwt.init_app(app)
    cors.init_app(app)
    
    # blueprints
    from backend.controllers.product_controller import product_bp
    from backend.controllers.user_controller import user_bp
    from backend.controllers.search_controller import search_bp
    
    app.register_blueprint(product_bp, url_prefix='/api/products')
    app.register_blueprint(user_bp, url_prefix='/api/users')
    app.register_blueprint(search_bp, url_prefix='/api/search')
    
    @app.route('/')
    def health_check():
        return jsonify({"status": "OK", "message": "Server is running"})
    
    return app