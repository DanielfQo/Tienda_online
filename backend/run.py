from flask import Flask
from extensions import db, migrate, jwt, cors
from controllers.producto_controller import producto_bp
# from controllers.usuario_controller import auth_bp

def create_app():
    app = Flask(__name__)
    app.config.from_envvar('FLASK_CONFIG')

    db.init_app(app)
    migrate.init_app(app, db)
    jwt.init_app(app)
    cors.init_app(app)

    app.register_blueprint(producto_bp, url_prefix='/api/productos')
    #app.register_blueprint(auth_bp, url_prefix='/api/auth')
    return app

if __name__ == "__main__":
    create_app().run(debug=True)