from backend.extensions import db

# --------------------------- SHOPPING CART ---------------------------

class CartItem(db.Model):
    __tablename__ = 'cart_items'
    id = db.Column(db.Integer, primary_key=True)
    cart_id = db.Column(db.Integer, db.ForeignKey('shopping_carts.id'), nullable=False)
    product_id = db.Column(db.Integer, db.ForeignKey('products.id'), nullable=False)
    quantity = db.Column(db.Integer, default=1)
    added_at = db.Column(db.DateTime, default=db.func.now())
    price_snapshot = db.Column(db.DECIMAL(10, 2))

class ShoppingCart(db.Model):
    __tablename__ = 'shopping_carts'
    id = db.Column(db.Integer, primary_key=True)
    client_id = db.Column(db.Integer, db.ForeignKey('clients.user_id'), nullable=False)
    created_at = db.Column(db.DateTime, default=db.func.now())
    status = db.Column(db.Enum('active', 'abandoned', 'completed', name='cart_status'), default='active')
    last_updated = db.Column(db.DateTime, default=db.func.now(), onupdate=db.func.now())
    
    items = db.relationship("CartItem", backref="cart", cascade="all, delete-orphan")
    products = db.relationship("Product", secondary="cart_items", viewonly=True)
    
# --------------------------- WISH LIST ---------------------------

class WishlistItem(db.Model):
    __tablename__ = 'wishlist_items'
    id = db.Column(db.Integer, primary_key=True)
    wishlist_id = db.Column(db.Integer, db.ForeignKey('wishlists.id'), nullable=False)
    product_id = db.Column(db.Integer, db.ForeignKey('products.id'), nullable=False)
    added_at = db.Column(db.DateTime, default=db.func.now())
    
    product = db.relationship('Product')

class Wishlist(db.Model):
    __tablename__ = 'wishlists'
    id = db.Column(db.Integer, primary_key=True)
    client_id = db.Column(db.Integer, db.ForeignKey('clients.user_id'), nullable=False)
    name = db.Column(db.String(100), nullable=False)
    created_at = db.Column(db.DateTime, default=db.func.now())
    
    items = db.relationship("WishlistItem", backref="wishlist", cascade="all, delete-orphan")
    products = db.relationship("Product", secondary="wishlist_items", viewonly=True)
