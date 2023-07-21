import re,random,os
from flask import render_template, request, redirect, flash,make_response,session,url_for
from sqlalchemy.sql import text
from werkzeug.security import generate_password_hash,check_password_hash

from quizapp import app, csrf
from quizapp.models import *
from quizapp.forms import AdminForm



@app.route("/admin/register",methods=["POST","GET"])
def adminregister():
    adminform=AdminForm()
    if request.method=="GET":
        return render_template("admin/register.html",adminform=adminform)
    else:
        if adminform.validate_on_submit():
        #retrieve form data and save in database
            adminpass=request.form.get("password")
            a=Admin(admin_username=request.form.get('username'),
                    admin_password=generate_password_hash(adminpass))
            db.session.add(a)
            db.session.commit()
            #log the admin in and redirect to dashboard
            session['adminid']=a.admin_id
            session["admin_loggedin"]=True
            flash("Account created successfully",)
            return redirect("/admin/dashboard")
        else:
            return render_template("admin/register.html",adminform=adminform)
        

@app.route("/admin/login", methods=["GET","POST"])
def adminlogin():
    if request.method=="GET":
        return render_template("admin/login.html")
    else:
        #retrieve formdata
        username=request.form.get("username")
        pwd=request.form.get("password")
        chk=db.session.query(Admin).filter(Admin.admin_username==username,Admin.admin_password==pwd).all
        if chk:
            session['admin_loggedin']=True
            return redirect("/admin/dashboard")
        else:
            flash("incorrect details",category="danger")
            return redirect("/admin/login")
        

        
@app.route("/admin/logout")
def admin_logout():
    if session.get("admin_loggedin"):
        session.pop("admin_loggedin",None)
        flash("you are logged out successfully",category="success")

    return redirect("/admin/login")

@app.route("/admin/dashboard")
def admin_dashboard():
    adminonline=session.get('admin_loggedin')
    admindeets=db.session.query(Admin).get(adminonline)
    return render_template("admin/admin_dashboard.html",admindeets=admindeets)

@app.route("/admin_users")
def users():
    adminonline = session.get('admin_loggedin')
    admindeets = db.session.query(Admin).all()  # Call the `all()` method to retrieve all admin records
    return render_template("admin/table.html", admindeets=admindeets, adminonline=adminonline)


@app.route("/admin/home")
def adminhome():
    if session.get('admin_loggedin')==None:
        flash("Access Denied",category="danger")
        return redirect('/admin/login')
    
    return render_template("admin/admin_dashboard.html")



@app.route("/admin/addquestion",methods=["GET","POST"])
def add_newquiz():
    if session.get('admin_loggedin')==None:
        flash("Access Denied",category="danger")
        return redirect('/admin/login')
    
    if request.method=="GET":
        quizcat=db.session.query(Category).all()
        questiondiff=db.session.query(Difficulty).all()
        return render_template("admin/addquestion.html", quizcat=quizcat, questiondiff=questiondiff)
    else:
        #retrieve all the form data
        question=request.form.get("question")
        option_1=request.form.get("option_1")
        option_2=request.form.get("option_2")
        option_3=request.form.get("option_3")
        option_4=request.form.get("option_4")
        correct_answer=request.form.get("correct_answer")
        quecat=request.form.get("quecat")
        quediff=request.form.get("quediff")
        if question!="" and option_1!="" and option_2!="" and option_3!="" and option_4!="" and correct_answer!="":
            q=Question(question=question,option_1=option_1,option_2=option_2,option_3=option_3,option_4=option_4,correct_answer=correct_answer,question_category_id=quecat,question_difficulty_id=quediff)
            db.session.add(q)
            db.session.commit()
            flash("Question added successfully", category="success")
            return redirect("/admin/dashboard")
            
        else:
            flash("complete the required field", category="danger")
            return redirect("/admin/addquestion")
        
@app.route("/admin/allquestion")
def manage_quiz():
    if session.get('admin_loggedin')!=None:
        ques = db.session.query(Question).all()
        return render_template("admin/allquestion.html",ques=ques)
    else:
        flash("Access Denied",category="danger")
        return redirect('/admin/login')
        


@app.route("/admin/deletequestion/<id>")
def deletequestion(id):
     if session.get('admin_loggedin')==None:
        flash("Access Denied",category="danger")
        return redirect('/admin/login')
     else:
        qd=db.session.query(Question).get_or_404(id)
        db.session.delete(qd)
        db.session.commit()
        flash("Question has been deleted!", category="success" )
        return redirect("/admin/allquestion")


# @app.route("/admin/managequiz")
# def manageall_quiz():
#     if session.get('admin_loggedin')!=None:
#         quiz = db.session.query(Quiz).all()
#         return render_template("admin/managequiz.html",quiz=quiz)
#     else:
#         flash("Access Denied",category="danger")
#         return redirect('/admin/login')    

  

@app.route("/admin/addquiz", methods=["GET", "POST"])
def add_quiz():
    if session.get('admin_loggedin') is None:
        flash("Access Denied", category="danger")
        return redirect('/admin/login')

    if request.method == "GET":
        quizqueid = db.session.query(Quiz).all()
        quizque = db.session.query(Question).all()
        return render_template("admin/addquiz.html", quizqueid=quizqueid, quizque=quizque)
    else:
        # Retrieve all the form data
        quizid = request.form.get('quiz')
        quiz = db.session.query(Quiz).get(quizid)  # Retrieve the Quiz object

        if quiz is not None:
            selected = request.form.getlist("quizque")
            for question_id in selected:
                quiz_question = Quiz_question(quiz_question_quiz_id=quizid, quiz_question_question_id=question_id)
                db.session.add(quiz_question)
            
            db.session.commit()
            flash("Questions added successfully into quiz", category="success")
            return redirect("/admin/dashboard")
        else:
            flash("Invalid quiz ID", category="danger")
            return redirect("/admin/addquiz")
        



@app.route("/admin/createquiz",methods=["GET","POST"])
def create_quiz():
    if session.get('admin_loggedin')==None:
        flash("Access Denied",category="danger")
        return redirect('/admin/login')
    
    if request.method=="GET":
        quizdiff=db.session.query(Difficulty).all()
        return render_template("admin/createquiz.html", quiz_difficulty_id=quizdiff)
    else:
        #retrieve all the form data
        quiz_name=request.form.get("quiz_name")
        quiz_diff=request.form.get("quiz_diff")
        quiz_status=request.form.get("status")
        if quiz_name!="" and quiz_diff!="" and quiz_status!="":
            que=Quiz(quiz_name=quiz_name,quiz_difficulty_id=quiz_diff,quiz_status=quiz_status)
            db.session.add(que)
            db.session.commit()
            flash("Quiz created successfully", category="success")
            return redirect("/admin/dashboard")
        else:
            flash("complete the required field", category="danger")
            return redirect("/admin/createquiz")
        

@app.route('/admin/managequiz')
def manageall_quiz():
    if session.get('admin_loggedin')!=None:
        #query the database
        data=db.session.query(Quiz,Difficulty).join(Difficulty).all()
        # data=db.session.query(Quiz,Difficulty).join(Difficulty).order_by((Difficulty.description)).all()
        return render_template("admin/managequiz.html",data=data)
    else:
        flash("Access Denied",category="danger")
        return redirect('/admin/login')    

@app.route('/admin/deletequiz/<quizid>')
def delete_quiz(quizid):
    #delete quiz from orm
    d=Quiz.query.get(quizid)
    db.session.delete(d)
    db.session.commit()
    return redirect("/admin/managequiz") 

@app.route('/admin/editquiz/<quizid>',methods=['POST',"GET"])
def update_quiz(quizid):
    if request.method=="GET":
        #fetch the quiz with id
        e=Quiz.query.get(quizid)
        diff=db.session.query(Difficulty).all()
        return render_template("admin/edit_quiz.html",e=e,diff=diff)
    else:
        quizname=request.form.get('quizname')
        pp=db.session.query(Quiz).get(quizid)
        pp.quiz_name=quizname
        db.session.commit()
        flash("Quiz updated successfully")
        return redirect("/admin/managequiz")
    


       

