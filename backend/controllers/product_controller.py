from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required, get_jwt
from backend.services.product_service import (
    list_products,
    get_product_by_id,
    create_product,
    update_product,
    increase_stock,
    delete_product
)
from backend.schemas.product_schema import ProductSchema

product_bp = Blueprint('products', __name__, url_prefix="/api/products")

@product_bp.route("/", methods=["GET"])
def get_products():
    prods = list_products()
    return jsonify(ProductSchema(many=True).dump(prods)), 200

@product_bp.route("/<int:id>", methods=["GET"])
def get_product(id):
    prod = get_product_by_id(id)
    if not prod:
        return jsonify({"msg": "Product not found"}), 404
    return jsonify(ProductSchema().dump(prod)), 200

@product_bp.route("/", methods=["POST"])
@jwt_required()
def post_product():
    claims = get_jwt()
    if claims["role"] not in ["admin", "employee"]:
        return jsonify({"msg": "Access denied"}), 403

    data = ProductSchema().load(request.json)
    new = create_product(data)
    return jsonify(ProductSchema().dump(new)), 201

@product_bp.route("/<int:id>", methods=["PUT"])
@jwt_required()
def put_product(id):
    claims = get_jwt()
    if claims["role"] not in ["admin", "employee"]:
        return jsonify({"msg": "Access denied"}), 403

    prod = get_product_by_id(id)
    if not prod:
        return jsonify({"msg": "Product not found"}), 404

    data = ProductSchema(partial=True).load(request.json)
    updated = update_product(prod, data)
    return jsonify(ProductSchema().dump(updated)), 200

@product_bp.route("/<int:id>", methods=["DELETE"])
@jwt_required()
def delete_product(id):
    claims = get_jwt()
    if claims["role"] not in ["admin", "employee"]:
        return jsonify({"msg": "Access denied"}), 403

    prod = get_product_by_id(id)
    if not prod:
        return jsonify({"msg": "Product not found"}), 404

    deleted = delete_product(prod)
    return jsonify(ProductSchema().dump(deleted)), 200

@product_bp.route("/<int:id>/stock", methods=["PATCH"])
@jwt_required()
def patch_stock(id):
    claims = get_jwt()
    if claims["role"] not in ["admin", "employee"]:
        return jsonify({"msg": "Access denied"}), 403

    prod = get_product_by_id(id)
    if not prod:
        return jsonify({"msg": "Product not found"}), 404

    amount = request.json.get("amount")
    if amount is None:
        return jsonify({"msg": "Amount is required"}), 400

    updated = increase_stock(prod, amount)
    return jsonify(ProductSchema().dump(updated)), 200
