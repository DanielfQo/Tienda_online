from marshmallow import fields
from marshmallow_sqlalchemy import SQLAlchemyAutoSchema
from backend.models.shoppingcart import Wishlist, WishlistItem
from backend.schemas.product_schema import ProductSchema

class WishlistItemSchema(SQLAlchemyAutoSchema):
    product = fields.Nested(ProductSchema)
    
    class Meta:
        model = WishlistItem
        include_fk = True
        load_instance = True

class WishlistSchema(SQLAlchemyAutoSchema):
    items = fields.Nested(WishlistItemSchema, many=True)
    
    class Meta:
        model = Wishlist
        include_fk = True