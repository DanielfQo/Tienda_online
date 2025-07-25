from flask import Blueprint, request, jsonify
from backend.schemas.search_schema import ProductSearchSchema
from backend.models import Product
from backend.services.search_service import advanced_search 
from backend.schemas.product_schema import ProductSchema

search_bp = Blueprint("search_bp", __name__, url_prefix="/api/search")

@search_bp.route("/advanced", methods=["GET"])
def search_products():
    schema = ProductSearchSchema()
    errors = schema.validate(request.args)
    if errors:
        return jsonify({"errors": errors}), 400

    filters = schema.load(request.args)

    products = advanced_search(
        search_text=filters.get("search_text"),
        price_min=filters.get("price_min"),
        price_max=filters.get("price_max"),
        in_stock=filters.get("in_stock"),
        order_by=filters.get("order_by"),
        attribute_filters=filters.get("attribute_filters"),
        category_id=filters.get("category_id"),
    )

    product_schema = ProductSchema(many=True)
    return jsonify(product_schema.dump(products))
