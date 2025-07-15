from backend.extensions import db

class User(db.Model):
    __tablename__ = 'users'
    
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password = db.Column(db.String(255), nullable=False)  # Password hash
    role = db.Column(db.Enum('client', 'admin', 'employee', name='role_enum'), nullable=False)
    verified = db.Column(db.Boolean, default=False)
    store_id = db.Column(db.Integer, db.ForeignKey('stores.id'))
    created_at = db.Column(db.DateTime)
    photo = db.Column(db.String(255), nullable=True)
    
    client = db.relationship("Client", uselist=False, back_populates="user")
    admin = db.relationship("Admin", uselist=False, back_populates="user")
    employee = db.relationship("Employee", uselist=False, back_populates="user")
    

class Client(db.Model):
    __tablename__ = 'clients'
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), primary_key=True)
    shipping_address = db.Column(db.String(255))
    phone = db.Column(db.String(20))

    user = db.relationship("User", back_populates="client")

class Admin(db.Model):
    __tablename__ = 'admins'
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), primary_key=True)
    access_level = db.Column(db.Integer)

    user = db.relationship("User", back_populates="admin")

class Employee(db.Model):
    __tablename__ = 'employees'
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), primary_key=True)
    position = db.Column(db.String(30))
    hired_at = db.Column(db.DateTime)

    user = db.relationship("User", back_populates="employee")

class Address(db.Model):
    __tablename__ = "addresses"
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
    line = db.Column(db.String(255), nullable=False)
    city = db.Column(db.String(100), nullable=False)
    state = db.Column(db.String(100))
    postal_code = db.Column(db.String(20))
    country = db.Column(db.String(100), nullable=False)

    user = db.relationship("User", backref="addresses")
