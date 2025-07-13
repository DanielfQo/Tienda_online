from backend.extensions import db

class Report(db.Model):
    __tablename__ = 'reports'
    id = db.Column(db.Integer, primary_key=True)
    type = db.Column(db.String(100), nullable=False)
    start_date = db.Column(db.Date, nullable=False)
    end_date = db.Column(db.Date, nullable=False)
    generated_by = db.Column(db.Integer, db.ForeignKey('admins.user_id'))
    format = db.Column(db.Enum('PDF', 'CSV', 'XLSX', name='format_enum'), nullable=False)
    generated_at = db.Column(db.DateTime, nullable=False)

    admin = db.relationship("Admin", backref="reports")
