from marshmallow import Schema, fields, validate

class ProductSearchSchema(Schema):
    search_text = fields.String(required=False, allow_none=True)
    price_min = fields.Decimal(required=False, allow_none=True, as_string=True)
    price_max = fields.Decimal(required=False, allow_none=True, as_string=True)
    in_stock = fields.Boolean(required=False, load_default=False)

    order_by = fields.String(
        required=False,
        validate=validate.OneOf(["price_asc", "price_desc", "name_asc", "name_desc", "relevance"]),
        load_default="price_asc"
    )
    attribute_filters = fields.Dict(keys=fields.String(), values=fields.List(fields.String()), required=False, allow_none=True)
    category_id = fields.Integer(required=False, allow_none=True)
