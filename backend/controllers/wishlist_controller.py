from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required, get_jwt_identity
from backend.services.wishlist_servicie import (
    add_to_wishlist,
    remove_from_wishlist,
    get_wishlist_items
)

from backend.schemas.wishlist_schema import WishlistSchema, WishlistItemSchema

wishlist_bp = Blueprint('wishlist', __name__, url_prefix="/api/wishlist")

@wishlist_bp.route("/products/<int:product_id>", methods=["POST"])
@jwt_required()
def add_product_to_wishlist(product_id):
    user_id = get_jwt_identity()
    
    try:
        item = add_to_wishlist(user_id, product_id)
        return jsonify({
            "message": "Producto añadido a tu wishlist",
            "item": WishlistItemSchema().dump(item)
        }), 201
    except ValueError as e:
        return jsonify({"error": str(e)}), 400

@wishlist_bp.route("/items", methods=["POST"])
@jwt_required()
def add_item():
    user_id = get_jwt_identity()
    product_id = request.json.get("product_id")
    
    if not product_id:
        return jsonify({"error": "Se requiere product_id"}), 400
    
    try:
        item = add_to_wishlist(user_id, product_id)
        return jsonify(WishlistItemSchema().dump(item)), 201
    except ValueError as e:
        return jsonify({"error": str(e)}), 400

@wishlist_bp.route("/items/<int:product_id>", methods=["DELETE"])
@jwt_required()
def remove_item(product_id):
    user_id = get_jwt_identity()
    
    try:
        remove_from_wishlist(user_id, product_id)
        return jsonify({"msg": "Producto removido"}), 200
    except ValueError as e:
        return jsonify({"error": str(e)}), 404

@wishlist_bp.route("/items", methods=["GET"])
@jwt_required()
def get_items():
    user_id = get_jwt_identity()
    items = get_wishlist_items(user_id)
    
    return jsonify(WishlistItemSchema(many=True).dump(items)), 200