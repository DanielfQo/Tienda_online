from marshmallow import fields
from marshmallow_sqlalchemy import SQLAlchemyAutoSchema, auto_field
from backend.models.user import User, Client, Admin, Employee

class UserRegisterSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = User
        load_instance = False
        include_fk = True

    name = auto_field(required=True)
    email = fields.Email(required=True)
    password = fields.String(load_only=True, required=True)
    role = auto_field(required=True)
    store_id = auto_field()

class LoginSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = User
        fields = ("email", "password")

    email = fields.Email(required=True)
    password = fields.String(load_only=True, required=True)

class UserSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = User
        load_instance = True
        exclude = ("password",)

    id = auto_field(dump_only=True)
    name = auto_field()
    email = auto_field()
    role = auto_field()
    verified = auto_field()
    store_id = auto_field()
    created_at = auto_field(dump_only=True)

class ClientSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Client
        load_instance = True
        include_fk = True

    user_id = auto_field()
    shipping_address = auto_field()
    phone = auto_field()

class AdminSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Admin
        load_instance = True
        include_fk = True

    user_id = auto_field()
    access_level = auto_field()

class EmployeeSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Employee
        load_instance = True
        include_fk = True

    user_id = auto_field()
    position = auto_field()
    hired_at = auto_field()