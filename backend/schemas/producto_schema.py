# backend/schemas/producto_schema.py
from marshmallow import fields
from marshmallow_sqlalchemy import SQLAlchemyAutoSchema, auto_field
from models.producto import Producto, ValorProducto
from models.venta import DetalleVenta

class ValorProductoSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = ValorProducto
        load_instance = True
        include_fk = True

    id = auto_field(dump_only=True)
    producto_id = auto_field(required=True)
    atributo_id = auto_field(required=True)
    valor = auto_field(required=True)


class DetalleVentaSchema(SQLAlchemyAutoSchema):
    
    class Meta:
        model = DetalleVenta
        load_instance = True
        include_fk = True

    id = auto_field(dump_only=True)
    venta_id = auto_field(required=True)
    producto_id = auto_field(required=True)
    cantidad = auto_field(required=True)
    precio_unitario = auto_field(required=True)

class ProductoCreateSchema(SQLAlchemyAutoSchema):

    class Meta:
        model = Producto
        load_instance = True
        include_fk = True

    nombre = auto_field(required=True)
    precio = auto_field(required=True)
    stock = auto_field(required=True)
    categoria_id = auto_field(required=True)
    tienda_id = auto_field(required=True)
    descripcion = auto_field()

class ProductoSchema(ProductoCreateSchema):
    id = auto_field(dump_only=True)
    fecha_registro = auto_field(dump_only=True)

    valores = fields.Nested(ValorProductoSchema, many=True, dump_only=True)
    detalles_venta = fields.Nested(DetalleVentaSchema, many=True, dump_only=True)
