from marshmallow import fields
from marshmallow_sqlalchemy import SQLAlchemyAutoSchema, auto_field
from models.usuario import Usuario, Cliente, Admin, Empleado

class UserRegisterSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Usuario
        load_instance = True
        include_fk = True

    nombre = auto_field(required=True)
    correo = fields.Email(required=True)
    contrasena = fields.String(load_only=True, required=True)
    rol = auto_field(required=True)
    tienda_id = auto_field()

class LoginSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Usuario
        fields = ("correo", "contrasena")

    correo = fields.Email(required=True)
    contrasena = fields.String(load_only=True, required=True)

class UsuarioSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Usuario
        load_instance = True
        exclude = ("contrasena",)

    id = auto_field(dump_only=True)
    nombre = auto_field()
    correo = auto_field()
    rol = auto_field()
    verificado = auto_field()
    tienda_id = auto_field()
    creado_en = auto_field(dump_only=True)


class ClienteSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Cliente
        load_instance = True
        include_fk = True

    usuario_id = auto_field()
    direccion_envio = auto_field()
    telefono = auto_field()

class AdminSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Admin
        load_instance = True
        include_fk = True

    usuario_id = auto_field()
    nivel_acceso = auto_field()

class EmpleadoSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Empleado
        load_instance = True
        include_fk = True

    usuario_id = auto_field()
    puesto = auto_field()
    fecha_contratacion = auto_field()
