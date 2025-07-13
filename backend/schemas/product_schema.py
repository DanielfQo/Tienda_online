from marshmallow import fields
from marshmallow_sqlalchemy import SQLAlchemyAutoSchema, auto_field
from backend.models.product import Product, ProductAttributeValue, ProductImage
from backend.models.sale import SaleDetail

class ProductAttributeValueSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = ProductAttributeValue
        load_instance = True
        include_fk = True

    id = auto_field(dump_only=True)
    product_id = auto_field(required=True)
    attribute_id = auto_field(required=True)
    value = auto_field(required=True)

class SaleDetailSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = SaleDetail
        load_instance = True
        include_fk = True

    id = auto_field(dump_only=True)
    sale_id = auto_field(required=True)
    product_id = auto_field(required=True)
    quantity = auto_field(required=True)
    unit_price = auto_field(required=True)

class ProductImageSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = ProductImage
        load_instance = True
        include_fk = True

    id = auto_field(dump_only=True)
    product_id = auto_field()
    url = auto_field()

class ProductCreateSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Product
        load_instance = True
        include_fk = True

    name = auto_field(required=True)
    price = auto_field(required=True)
    stock = auto_field(required=True)
    category_id = auto_field(required=True)
    store_id = auto_field(required=True)
    description = auto_field()

class ProductSchema(ProductCreateSchema):
    id = auto_field(dump_only=True)
    created_at = auto_field(dump_only=True)

    images = fields.Nested(ProductImageSchema, many=True, dump_only=True)
    values = fields.Nested(ProductAttributeValueSchema, many=True, dump_only=True)
    sale_details = fields.Nested(SaleDetailSchema, many=True, dump_only=True)
