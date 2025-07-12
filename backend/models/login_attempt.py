from extensions import db

class LoginAttempt(db.Model):
    __tablename__ = 'login_attempts'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'))
    success = db.Column(db.Boolean, nullable=False)
    date = db.Column(db.DateTime, nullable=False)
    ip = db.Column(db.String(45))  # Supports IPv4 and IPv6

    user = db.relationship("User", backref="login_attempts")
