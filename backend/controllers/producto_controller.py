from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required, get_jwt
from services.producto_service import (listar_productos, obtener_producto_por_id, crear_producto, actualizar_producto, aumentar_stock, eliminar_producto)
from schemas.producto_schema import ProductoSchema

producto_bp = Blueprint('productos', __name__)

@producto_bp.route('/', methods=['GET'])
def get_productos():
    prods = listar_productos()
    return jsonify(ProductoSchema(many=True).dump(prods)), 200

@producto_bp.route('/<int:id>', methods=['GET'])
def get_producto(id):
    prod = obtener_producto_por_id(id)
    if not prod:
        return jsonify({'msg': 'Producto no encontrado'}), 404
    return jsonify(ProductoSchema().dump(prod)), 200

@producto_bp.route('/', methods=['POST'])
@jwt_required()
def post_producto():
    claims = get_jwt()
    if claims['rol'] not in ['admin', 'empleado']:
        return jsonify({'msg': 'Acceso denegado'}), 403
    data = ProductoSchema().load(request.json)
    nuevo = crear_producto(data)
    return jsonify(ProductoSchema().dump(nuevo)), 201

@producto_bp.route('/<int:id>', methods=['PUT'])
@jwt_required()
def put_producto(id):
    claims = get_jwt()
    if claims['rol'] not in ['admin', 'empleado']:
        return jsonify({'msg': 'Acceso denegado'}), 403
    
    prod = obtener_producto_por_id(id)
    if not prod:
        return jsonify({'msg': 'Producto no encontrado'}), 404
    
    data = ProductoSchema(partial=True).load(request.json)
    actualizado = actualizar_producto(prod, data)
    return jsonify(ProductoSchema().dump(actualizado)), 200

@producto_bp.route('/<int:id>', methods=['DELETE'])
@jwt_required()
def delete_producto(id):
    claims = get_jwt()
    if claims['rol'] not in ['admin', 'empleado']:
        return jsonify({'msg': 'Acceso denegado'}), 403
    
    prod = obtener_producto_por_id(id)
    if not prod:
        return jsonify({'msg': 'Producto no encontrado'}), 404
    
    eliminado = eliminar_producto(prod)
    return jsonify(ProductoSchema().dump(eliminado)), 200

@producto_bp.route("/<int:id>/stock", methods=["PATCH"])
@jwt_required()
def patch_stock(id):
    claims = get_jwt()
    if claims["rol"] not in ["admin", "empleado"]:
        return jsonify({"msg": "No autorizado"}), 403

    producto = obtener_producto_por_id(id)
    if not producto:
        return jsonify({"msg": "Producto no encontrado"}), 404

    cantidad = request.json.get("cantidad")
    if cantidad is None:
        return jsonify({"msg": "Cantidad requerida"}), 400

    actualizado = aumentar_stock(producto, cantidad)
    return ProductoSchema().jsonify(actualizado), 200