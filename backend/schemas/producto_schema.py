from marshmallow_sqlalchemy import SQLAlchemyAutoSchema
from models.producto import Producto

class ProductoSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Producto
        load_instance = True
        include_fk = True