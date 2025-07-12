from extensions import db

class Loan(db.Model):
    __tablename__ = 'loans'
    id = db.Column(db.Integer, primary_key=True)
    amount = db.Column(db.DECIMAL(10, 2), nullable=False)
    date = db.Column(db.Date, nullable=False)
    term = db.Column(db.Integer, nullable=False)
    status = db.Column(db.Enum('pending', 'approved', 'rejected', 'paid', name='loan_status_enum'), nullable=False)
    client_id = db.Column(db.Integer, db.ForeignKey('clients.user_id'), nullable=False)

    client = db.relationship("Client", backref="loans")
