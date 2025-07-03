from extensions import db

class Reporte(db.Model):
    __tablename__ = 'reportes'
    id = db.Column(db.Integer, primary_key=True)
    tipo = db.Column(db.String(100), nullable=False)
    fecha_inicio = db.Column(db.Date, nullable=False)
    fecha_fin = db.Column(db.Date, nullable=False)
    generado_por = db.Column(db.Integer, db.ForeignKey('admins.usuario_id'))
    formato = db.Column(db.Enum('PDF', 'CSV', 'XLSX', name='formato_enum'), nullable=False)
    generado_en = db.Column(db.DateTime, nullable=False)

    admin = db.relationship("Admin", backref="reportes")