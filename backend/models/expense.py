from backend.extensions import db

class Expense(db.Model):
    __tablename__ = 'expenses'
    id = db.Column(db.Integer, primary_key=True)
    amount = db.Column(db.DECIMAL(10, 2), nullable=False)
    category = db.Column(db.String(100), nullable=False)
    reason = db.Column(db.Text)
    date = db.Column(db.Date, nullable=False)
    client_id = db.Column(db.Integer, db.ForeignKey('clients.user_id'), nullable=False)

    client = db.relationship("Client", backref="expenses")