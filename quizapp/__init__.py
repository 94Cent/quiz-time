from flask import Flask
from flask_migrate import Migrate 
from flask_wtf.csrf import CSRFProtect
csrf=CSRFProtect()


def createapp():  
    """keep all imports that may cause conflict within this function so that anytime we write "from fapp.. import.. none of these import statement will be executed"""
    app=Flask(__name__,instance_relative_config=True)
    #from Quiz import config
    app.config.from_pyfile("config.py",silent=True) 
    from quizapp.models import db
    db.init_app(app) 
    csrf.init_app(app)
    migrate = Migrate(app, db) #new addition
    return app

app= createapp()
from quizapp import user_routes, admin_routes, forms, models

#Load the routes, forms, models (everything you will want to access any other place just by typing "from quizapp import...")
