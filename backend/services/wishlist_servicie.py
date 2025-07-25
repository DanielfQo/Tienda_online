from backend.extensions import db
from backend.models.shoppingcart import Wishlist, WishlistItem
from backend.models.product import Product
from sqlalchemy.orm import joinedload

def get_or_create_wishlist(client_id):
    wishlist = Wishlist.query.filter_by(client_id=client_id).first()

    # si no exite se crea
    if not wishlist:
        wishlist = Wishlist(
            client_id=client_id,
            name=f"Wishlist de usuario {client_id}" #TODO: cambiar por nombre del usuario si se tiene
        )
        db.session.add(wishlist)
        db.session.commit()

    return wishlist

def add_to_wishlist(client_id, product_id):
    wishlist = get_or_create_wishlist(client_id)
    
    product = Product.query.get(product_id)
    if not product:
        raise ValueError("Producto no existe")
    
    #productos unicos
    if WishlistItem.query.filter_by(wishlist_id=wishlist.id, product_id=product_id).first():
        raise ValueError("El producto ya está en tu wishlist")
    
    item = WishlistItem(wishlist_id=wishlist.id, product_id=product_id)
    db.session.add(item)
    db.session.commit()
    
    return WishlistItem.query.options(
        joinedload(WishlistItem.product)
    ).get(item.id)

def remove_from_wishlist(client_id, product_id):
    wishlist = Wishlist.query.filter_by(client_id=client_id).first()
    if not wishlist:
        raise ValueError("No tienes una wishlist")
    
    item = WishlistItem.query.filter_by(wishlist_id=wishlist.id, product_id=product_id).first()
    if not item:
        raise ValueError("El producto no está en tu wishlist")
    
    db.session.delete(item)
    db.session.commit()
    return True

def get_wishlist_items(client_id):
    wishlist = Wishlist.query.filter_by(client_id=client_id).first()
    if not wishlist:
        return []
    
    # Carga los productos en la misma consulta
    return WishlistItem.query.options(
        joinedload(WishlistItem.product)
    ).filter_by(wishlist_id=wishlist.id).all()