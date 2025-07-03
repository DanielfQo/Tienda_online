from extensions import db
from models.producto import Producto

def listar_productos():
    # Traer primero productos con stock = 0 (sin disponibilidad)
    sin_stock = Producto.query.filter(Producto.stock == 0).all()
    # Luego productos con stock > 0
    con_stock = Producto.query.filter(Producto.stock > 0).all()
    # Combinar ambas listas
    return sin_stock + con_stock

def obtener_producto_por_id(producto_id):
    # aqui generar el filtro de busqueda?
    return Producto.query.get(producto_id)

def crear_producto(data):
    prod = Producto(**data)
    db.session.add(prod)
    db.session.commit()
    return prod

def ajustar_stock(producto, nuevo_stock):
    producto.stock = max(0, nuevo_stock)
    db.session.commit()
    return producto

def aumentar_stock(producto, cantidad):
    if cantidad <= 0:
        raise ValueError("La cantidad debe ser mayor que cero.")
    producto.stock += cantidad
    db.session.commit()
    return producto

def actualizar_producto(producto, data):
    #actualizar stock, depende de la db
    for key, value in data.items():
        setattr(producto, key, value)
    db.session.commit()
    return producto

def eliminar_producto(producto):
    producto.stock = 0
    db.session.commit()
    return producto
