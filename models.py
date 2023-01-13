from flask_login import UserMixin
from sqlalchemy.orm import relationship
from werkzeug.security import generate_password_hash, check_password_hash
from flask import url_for
from slugify import slugify
from sqlalchemy.exc import IntegrityError
from app import db

class User(db.Model, UserMixin):
    
    __tablename__ = 'usuario'
    # DEFINIMOS LA CLAVE PRIMARIA
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    email = db.Column(db.String(256), unique=True, nullable=False)
    password = db.Column(db.String(128), nullable=False)
    is_admin = db.Column(db.Boolean, default=False)

    def __init__(self, name, email):
        self.name = name
        self.email = email

    def __repr__(self):
        return f'<User {self.email}>'

    def set_password(self, password):
        self.password = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password, password)

    def save(self):
        if not self.id:
            db.session.add(self)
        db.session.commit()

    @staticmethod
    def get_by_id(id):
        return User.query.get(id)

    @staticmethod
    # CAMBIAMOS get_user(email) POR EL METODO get_by_email(email) DE LA CLASE USER
    def get_by_email(email):
        return User.query.filter_by(email=email).first()



class Reservation(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    condicion = db.Column(db.String(100), nullable=False)
    first_name = db.Column(db.String(100), nullable=False)
    last_name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(100), nullable=False)
    nationality = db.Column(db.String(100), nullable=False)
    phone = db.Column(db.String(100), nullable=False)

    block = db.Column(db.String(100), nullable=False)
    sac = db.Column(db.String(100), nullable=False)
    day = db.Column(db.String(100), nullable=False)
    schedule = db.Column(db.String(100), nullable=False)
    affair = db.Column(db.String(100), nullable=False)
    # date_created = db.Column(db.DATE, default=datetime.now())

class Accpted(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(100), nullable=False)
    country = db.Column(db.String(100), nullable=False)
    block = db.Column(db.String(100), nullable=False)
    sac = db.Column(db.String(100), nullable=False)
    day = db.Column(db.String(100), nullable=False)
    schedule = db.Column(db.String(100), nullable=False)
    affair = db.Column(db.String(100), nullable=False)

class Reject(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(100), nullable=False)
    country = db.Column(db.String(100), nullable=False)
    block = db.Column(db.String(100), nullable=False)
    sac = db.Column(db.String(100), nullable=False)
    day= db.Column(db.String(100), nullable=False)
    schedule = db.Column(db.String(100), nullable=False)
    affair = db.Column(db.String(100), nullable=False)

class Admin(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    password = db.Column(db.String(100), nullable=False)