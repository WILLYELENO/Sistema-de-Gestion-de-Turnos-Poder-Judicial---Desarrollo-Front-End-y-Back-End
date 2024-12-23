import os

from flask import Flask, render_template, request, redirect, url_for,session,flash
from flask_login import LoginManager,current_user, login_user, logout_user,login_required
from werkzeug.urls import url_parse
from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

#from .forms import SignupForm, LoginForm
from forms import *
from models import *

app = Flask(__name__)

#CONFIGURACION APP
app.config['SECRET_KEY'] = '7110c8ae51a4b5af97be6534caef90e4bb9bdcb3380af008f90b23a5d1616bf319bc298105da20fe'
app.config["SQLALCHEMY_DATABASE_URI"] = 'mysql+pymysql://root:root@localhost:3307/PoderJudicial'
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False


login_manager = LoginManager(app)
login_manager.login_view = "login"
db = SQLAlchemy(app)




#Ruta Raiz
@app.route('/')
@app.route('/base_template')
@app.route('/base_template/index')
def index():
    return render_template('index.html')

#Ruta Registroo
@app.route("/signup_form/", methods=["GET", "POST"])
def show_signup_form():
    if current_user.is_authenticated:
        return redirect(url_for('professional'))
    form = SignupForm()
    error = None
    if form.validate_on_submit():
        name = form.name.data
        email = form.email.data
        password = form.password.data
        # Comprobamos que no hay ya un usuario con ese email
        user = User.get_by_email(email)
        if user is not None:
            error = f'El email "{email}" ya está siendo utilizado por otro usuario'
        else:
            # Creamos el usuario y lo guardamos
            user = User(name=name, email=email)
            user.set_password(password)
            user.save()
            # Dejamos al usuario logueado
            login_user(user, remember=True)
            next_page = request.args.get('next', None)
            if not next_page or url_parse(next_page).netloc != '':
                next_page = url_for('login')
            return redirect(next_page)
    return render_template("signup_form.html", form=form, error=error)

#Ruta Login
@app.route('/login', methods=['GET', 'POST'])
def login():
    # PRIMERO COMPROBAMOS SI EL USUARIO ESTÁ AUTENTICADO
    if current_user.is_authenticated:
        return redirect(url_for('professional'))
    form = LoginForm()
    if form.validate_on_submit():
        user = User.get_by_email(form.email.data.upper())
        if user is None:
            return render_template('login_form.html', form=form)
        # SI EXISTE UN USUARIO CON ESE EMAIL Y LA CLAVE ES CORRECTA, 
        # AUTENTICAMOS EL USUARIO USANDO EL METODO login_user
        else:    
            if user is not None and user.check_password(form.password.data.upper()):
                login_user(user, remember=form.remember_me.data)
                next_page = request.args.get('next')
                # COMPROBAMOS SI RECIBIMOS EL PARAMETRO NEXT. 
                # ESTO PASA CUANDO SE INTENTA INGRESAR A UNA PAGINA PROTEGIDA SIN ESTAR AUTENTICADO.
                # SI NO SE RECIBE EL NEXT, REDIRIGIMOS EL USUARIO A LA PAGINA DE INICIO
                if not next_page or url_parse(next_page).netloc != '':
                    next_page = url_for('professional')
                return redirect(next_page)
    return render_template('login_form.html', form=form)


#Ruta Logout
@app.route('/logout')
def logout():
    logout_user()
    #session.clear()
    return redirect(url_for('login'))


@login_manager.user_loader
def load_user(user_id):
    return User.get_by_id(int(user_id))


#Ruta del Turnero
@app.route('/formturnero')
def formturnero():
    return render_template('formturnero.html')


#Index del Usuario que Inicio Sesion
@app.route('/professional')
@login_required
def professional():
    #Registros de reservas
    record = Reservation.query.all()
    return render_template("professional.html",record=record)
    


@app.route("/reservation", methods = ['GET','POST'])
def reservation():
    if  request.method == 'POST' :
        condicion = request.form.get('condicion')
        first_name = request.form.get('fname')
        last_name = request.form.get('lname')
        email = request.form.get('email')
        nationality = request.form.get('nation')
        phone = request.form.get('phone')

        block = request.form.get('block')
        sac= request.form.get('sac')
        day = request.form.get('day')
        schedule = request.form.get('hora')
        affair = request.form.get('asunto')
        entry = Reservation(
                            condicion = condicion,
                            first_name = first_name ,
                            last_name= last_name,
                            email=email ,
                            nationality=nationality ,
                            phone= phone ,
                            block = block, 
                            sac = sac, 
                            day = day , 
                            schedule = schedule,
                            affair = affair 
                            )
        db.session.add(entry)
        db.session.commit()
        return redirect("/op_exitosa")
    return render_template ("/op_exitosa.html")

@app.route("/op_exitosa")
def op_exitosa():
    return render_template("op_exitosa.html")

#Tabla de turnos aceptados
@app.route("/Accept/<int:id>")
@login_required
def accept(id):
    #apt = Reservation.query.get(id)
    apt= db.session.query(Reservation).get(id)
    #apt = Reservation.query.filter_by(id = id).first()
    add = Accpted(name=apt.first_name ,
                 email= apt.email ,
                 country=apt.nationality,
                 block=apt.block,
                 sac=apt.sac,
                 day=apt.day,
                 schedule=apt.schedule,
                 affair=apt.affair)
    db.session.add(add)
    db.session.delete(apt)
    db.session.commit()
    return redirect("/professional")

#Tabla de turnos rechazados
@app.route("/reject/<int:id>")
@login_required
def reject(id):
    apt= db.session.query(Reservation).get(id)
    add = Reject(name=apt.first_name ,
                 email= apt.email ,
                 country=apt.nationality,
                 block=apt.block,
                 sac=apt.sac,
                 day=apt.day,
                 schedule=apt.schedule,
                 affair=apt.affair)
    db.session.add(add)
    db.session.delete(apt)
    db.session.commit()
    return redirect("/professional")


@app.route("/accepted")
@login_required
def accepted():
    msg=("Login First")
    #if session.get('username'):
    record = Accpted.query.all()
    
    return render_template("accept.html",record=record)

@app.route("/rejected")
@login_required
def rejected(): 
    msg=("Login First")
    #if session.get('username'):
    record = Reject.query.all()
    return render_template ("reject.html",record=record)
    #return render_template("login_form.html",msg=msg)

@app.route("/Delete/<int:id>")
@login_required
def delete_accept(id):
    d= db.session.query(Accpted).get(id)
    #d = Accpted.query.get(id)
    db.session.delete(d)
    db.session.commit()
    return redirect("/accepted")

@app.route("/reject_delete/<int:id>")
@login_required
def delete_reject(id):
    d= db.session.query(Reject).get(id)
    #d = Reject.query.get(id)
    db.session.delete(d)    
    db.session.commit()
    return redirect("/rejected")

if __name__ == '__main__':
    app.run(debug=True)