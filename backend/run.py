from flask import Flask
from extensions import db, migrate, jwt, cors
from config import Config
from controllers.producto_controller import producto_bp
# from controllers.usuario_controller import auth_bp
import models  # Asegura que se carguen todos los modelos

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    db.init_app(app)
    migrate.init_app(app, db)
    jwt.init_app(app)
    cors.init_app(app)

    app.register_blueprint(producto_bp, url_prefix='/api/productos')

    @app.route("/uploads/imagenes/<filename>")
    def uploaded_file(filename):
        from flask import send_from_directory
        return send_from_directory("uploads/imagenes", filename)

    return app


if __name__ == "__main__":
    app = create_app()
    app.run(debug=True)
