from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField,TextAreaField,PasswordField
from wtforms.validators import DataRequired, Email, Length, EqualTo
from flask_wtf.file import FileField,FileAllowed,FileRequired


class SignupForm(FlaskForm):
    firstname = StringField("Firstname",validators=[DataRequired(message="hello, first name required")])
    lastname = StringField("Lastname",validators=[DataRequired(message="hello, last name required")])
    email = StringField("Your Email",validators=[Email()])
    mobile=StringField("Phone Number",validators=[DataRequired()])
    password=PasswordField("Password",validators=[DataRequired()])
    confirm_password=PasswordField("Confirm Password",validators=[EqualTo("password",message="Must match with password")])
    
    btn = SubmitField("Sign Up!")

class AdminForm(FlaskForm):
    username= StringField("Fullname",validators=[DataRequired(message="username required")])
    password=PasswordField("Password",validators=[DataRequired()])
    confirm_password=PasswordField("Confirm Password",validators=[EqualTo("password",message="Must match with password")])
    btn = SubmitField("Sign Up!")



class ProfileForm(FlaskForm):
    firstname = StringField("Firstname",validators=[DataRequired(message="hello, first name required")])
    lastname = StringField("Lastname",validators=[DataRequired(message="hello, last name required")])
    pix= FileField("Display Picture",validators=[FileRequired(),FileAllowed(['jpg','png'],'Images only!')])
    btn = SubmitField("Update Profile!")
  
    
    
    
    
    
     
    

