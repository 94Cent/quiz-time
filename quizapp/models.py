from datetime import datetime
from flask_sqlalchemy import SQLAlchemy

db=SQLAlchemy()


class Admin(db.Model):
    admin_id=db.Column(db.Integer, autoincrement=True,primary_key=True)
    admin_username=db.Column(db.String(45),nullable=False)
    admin_password=db.Column(db.String(45),nullable=False)


class Users(db.Model):  
    user_id = db.Column(db.Integer, autoincrement=True,primary_key=True)
    firstname = db.Column(db.String(45),nullable=False)
    lastname = db.Column(db.String(45),nullable=False)
    user_email = db.Column(db.String(45),nullable=False) 
    user_password=db.Column(db.String(120),nullable=False)
    user_mobile=db.Column(db.String(15),nullable=False) 
    pix=db.Column(db.String(120),nullable=True)
    datereg=db.Column(db.DateTime(), default=datetime.utcnow)#default
   
    
class Category(db.Model):
    category_id= db.Column(db.Integer, autoincrement=True,primary_key=True)
    category_name = db.Column(db.String(45),nullable=False)

class Difficulty(db.Model):
    difficulty_id= db.Column(db.Integer, autoincrement=True,primary_key=True)
    description = db.Column(db.String(45),nullable=False)


class Question(db.Model):
    question_id= db.Column(db.Integer, autoincrement=True,primary_key=True)
    question = db.Column(db.String(450),nullable=False)
    question_category_id = db.Column(db.Integer,db.ForeignKey("category.category_id"),nullable=False)
    question_difficulty_id = db.Column(db.Integer,db.ForeignKey("difficulty.difficulty_id"),nullable=False)
    option_1 = db.Column(db.String(120),nullable=False)
    option_2 = db.Column(db.String(120),nullable=False)
    option_3 = db.Column(db.String(120),nullable=False)
    option_4 = db.Column(db.String(120),nullable=False)
    correct_answer = db.Column(db.String(120),nullable=False)
    #set relationship
    quizcat= db.relationship('Category', backref="quizcategory")
    questiondiff= db.relationship('Difficulty', backref="questiondifficulty")

class Quiz(db.Model):
    quiz_id= db.Column(db.Integer, autoincrement=True,primary_key=True)
    quiz_name= db.Column(db.String(45),nullable=False)
    quiz_status =db.Column(db.Enum('1','0'),nullable=False, server_default=("0"))  
    quiz_difficulty_id = db.Column(db.Integer,db.ForeignKey("difficulty.difficulty_id"),nullable=False)
    date= db.Column(db.DateTime(), default=datetime.utcnow) 
    time_started= db.Column(db.DateTime(), default=datetime.utcnow) 
    time_ended= db.Column(db.DateTime(), default=datetime.utcnow) 
    #set relationship
    quizdiff= db.relationship('Difficulty', backref="quizdifficulty")

class Quiz_question(db.Model):
    quiz_question_id= db.Column(db.Integer, autoincrement=True,primary_key=True)
    quiz_question_quiz_id= db.Column(db.Integer,db.ForeignKey("quiz.quiz_id"),nullable=True)
    quiz_question_question_id= db.Column(db.Integer,db.ForeignKey("question.question_id"),nullable=True)
    #set relationship
    quizqueid= db.relationship('Quiz', backref="quizquestionid")
    quizque=db.relationship('Question', backref="quizquestions")

class User_quiz_answer(db.Model):
    user_quiz_answer_id=db.Column(db.Integer, autoincrement=True,primary_key=True)
    correct_answer = db.Column(db.String(45),nullable=False)
    user_answer=db.Column(db.String(45),nullable=False)
    user_answer_quiz_id= db.Column(db.Integer,db.ForeignKey("quiz.quiz_id"),nullable=True)
    user_answer_question_id= db.Column(db.Integer,db.ForeignKey("question.question_id"),nullable=False)
    user_answer_user_id= db.Column(db.Integer,db.ForeignKey("users.user_id"),nullable=False)
    #set relationship
    userans= db.relationship('Quiz', backref="myanswer")
    userqueans=db.relationship('Question', backref="myquestions")
    ansuserid=db.relationship('Users',backref='myanswerid')
 
class Donation(db.Model):
    don_id = db.Column(db.Integer, autoincrement=True,primary_key=True)
    don_amt = db.Column(db.Float, nullable=False)  
    don_userid = db.Column(db.Integer,db.ForeignKey("users.user_id"),nullable=True)
    don_fullname= db.Column(db.String(100),nullable=True)
    don_email=db.Column(db.String(100),nullable=True)

    don_refno=db.Column(db.String(20),nullable=False)
    don_paygate_response=db.Column(db.Text())

    don_date = db.Column(db.DateTime(), default=datetime.utcnow)
    don_status =db.Column(db.Enum('pending','failed','paid'),nullable=False, server_default=("pending"))  
    #set relationship
    donor = db.relationship('Users',backref='mydonations')

