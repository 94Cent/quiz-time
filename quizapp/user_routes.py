import json
from functools import wraps
import re,random,os,requests
from flask import render_template, request, redirect, flash,make_response,session,url_for,jsonify
from sqlalchemy.sql import text
from werkzeug.security import generate_password_hash,check_password_hash

from quizapp import app, csrf
from quizapp.models import *
from quizapp.forms import SignupForm,ProfileForm


def login_required(f):
    @wraps(f)
    def login_decorator(*args,**kwargs):
        if session.get('userid') and session.get('user_loggedin'):
            return f(*args,**kwargs)
        else:
            flash("Access Denied, Please Login")
            return redirect('/login')
    return login_decorator


@app.route("/")
def layout():
    useronline=session.get('userid')
    userdeets=db.session.query(Users).get(useronline)
    return render_template("user/layout.html",userdeets=userdeets)

@app.route("/home")
@login_required
def home():
    useronline=session.get('userid')
    userdeets=db.session.query(Users).get(useronline)
    return render_template("user/home.html",userdeets=userdeets)


# @app.route('/takequiz/<int:quiz_id>', methods=['GET', 'POST'])
# @login_required
# def display_quiz(quiz_id):
#     useronline = session.get('userid')
    
#     # Retrieve the list of question IDs for the quiz
#     quiz_questions = Quiz_question.query.filter_by(quiz_question_quiz_id=quiz_id).all()

#     if request.method == 'POST':
#         # Retrieve the selected answer from the form data
#         selected_answer = request.form.get('user_answer')
#         question_id = int(request.form.get('question_id'))

#         # Check if the user has already answered this question
#         existing_answer = User_quiz_answer.query.filter_by(
#             user_answer_user_id=useronline,
#             user_answer_quiz_id=quiz_id,
#             user_answer_question_id=question_id
#         ).first()

#         # If the user has not answered this question, save the answer to the database
#         if not existing_answer:
#             # Retrieve the correct answer for the question
#             correct_answer = Question.query.get(question_id).correct_answer

#             # Create a new instance of User_quiz_answer and save it to the database
#             user_quiz_answer = User_quiz_answer(
#                 correct_answer=correct_answer,
#                 user_answer=selected_answer,
#                 user_answer_quiz_id=quiz_id,
#                 user_answer_question_id=question_id,
#                 user_answer_user_id=useronline
#             )
#             db.session.add(user_quiz_answer)
#             db.session.commit()

#         # Increment the current_question_index to progress to the next question
#         next_question_index = int(request.args.get('question', 0)) + 1
#         if next_question_index == len(quiz_questions):
#             return redirect(url_for('total_score', quiz_id=quiz_id))
#         else:
#             return redirect(url_for('display_quiz', quiz_id=quiz_id, question=next_question_index))

#     # Retrieve the current question index from the query parameter
#     current_question_index = int(request.args.get('question', 0))

#     # Check if the quiz is completed
#     if current_question_index == len(quiz_questions):
#         total_score = User_quiz_answer.query.filter_by(
#             user_answer_user_id=useronline,
#             user_answer_quiz_id=quiz_id,
#             user_answer=Question.correct_answer
#         ).count()

#         return redirect(url_for('total_score', quiz_id=quiz_id, total_score=total_score))

#     # Retrieve the current question
#     current_question = quiz_questions[current_question_index]

#     return render_template('user/takequiz.html', quiz_questions=quiz_questions, current_question=current_question, quiz_id=quiz_id, current_question_index=current_question_index)

# @app.route('/total_score/<int:quiz_id>')
# def total_score(quiz_id):
#     useronline = session.get('userid')
    
#     # Get the total number of questions for this quiz
#     total_questions = Quiz_question.query.filter_by(quiz_question_quiz_id=quiz_id).count()

#     # Get all user's quiz answers for the current quiz
#     user_quiz_answers = User_quiz_answer.query \
#         .filter_by(user_answer_user_id=useronline) \
#         .filter_by(user_answer_quiz_id=quiz_id) \
#         .all()

#     # Calculate the total score for the user
#     total_score = sum(answer.user_answer == answer.correct_answer for answer in user_quiz_answers)

#     # Calculate the percentage, but handle the case when there are no questions in the quiz
#     percentage_score = (total_score / total_questions) * 100 if total_questions > 0 else 0
#     percentage_score = min(percentage_score, 100)  # Limit percentage score to 100

#     return render_template('user/total_score.html', total_score=total_score, total_questions=total_questions, percentage_score=percentage_score)


@app.route('/takequiz/<int:quiz_id>', methods=['GET', 'POST'])
def display_quiz(quiz_id):
    if request.method == 'GET':
        # Fetch the quiz details from the database
        quiz = Quiz.query.get(quiz_id)
        if not quiz:
            return jsonify({'error': 'Quiz not found'}), 404

        # Fetch all questions associated with this quiz
        questions = Question.query.join(Quiz_question).filter(Quiz_question.quiz_question_quiz_id == quiz_id).all()

        # Create a JSON representation of the quiz and questions
        quiz_data = {
            'quiz_id': quiz.quiz_id,
            'quiz_name': quiz.quiz_name,
            'quiz_status': quiz.quiz_status,
            'date': quiz.date.strftime('%Y-%m-%d %H:%M:%S'),
            'time_started': quiz.time_started.strftime('%Y-%m-%d %H:%M:%S'),
            'time_ended': quiz.time_ended.strftime('%Y-%m-%d %H:%M:%S'),
            'questions': []
        }

        for question in questions:
            question_data = {
                'question_id': question.question_id,
                'question': question.question,
                'options': [question.option_1, question.option_2, question.option_3, question.option_4]
            }
            quiz_data['questions'].append(question_data)
            # Store the current question index in the session
        session['current_question'] = 1

        return render_template('user/takequiz.html', quiz_data=quiz_data)
    
@app.route('/submitquiz/<int:quiz_id>', methods=['POST'])
def submit_quiz(quiz_id):
    # Get the submitted form data
    user_answers = request.form
    # Fetch the quiz from the database
    quiz = Quiz.query.get(quiz_id)
    if not quiz:
        return jsonify({'error': 'Quiz not found'}), 404

    # Fetch all questions associated with this quiz
    questions = Question.query.join(Quiz_question).filter(Quiz_question.quiz_question_quiz_id == quiz_id).all()

    # Update the current question index in the session after submitting each question
    current_question = session.get('current_question', 1)
    session['current_question'] = current_question + 1

    # Calculate the user's score
    total_questions = len(questions)
    correct_answers = 0

    for question in questions:
        question_id = str(question.question_id)
        user_answer = user_answers.get(f'question_{question_id}')
        correct_answer = question.correct_answer

        print(question_id, user_answer, correct_answer)
        # Assuming both user_answer and correct_answer are strings without leading/trailing spaces
        if user_answer is not None and user_answer == correct_answer:
            correct_answers += 1

    # Save the user's answers and score in the User_quiz_answer table (optional)
    # Assuming you have a 'User_quiz_answer' model for storing user quiz answers

    # Return the total score to the user
    return render_template('user/total_score.html', score=correct_answers, total_questions=total_questions, quiz_data=quiz)

   

@app.route("/dashboard")
@login_required
def dashboard():
    useronline=session.get('userid')
    userdeets=db.session.query(Users).get(useronline)
    return render_template("user/dashboard.html",userdeets=userdeets)

@app.route("/login",methods=["POST","GET"])
def login():
    if request.method=="GET":
        return render_template("user/loginpage.html")
    else:
        user=request.form.get('email')
        password=request.form.get('password')
        deets=db.session.query(Users).filter(Users.user_email==user).first()
        if deets:
            hashedpwd=deets.user_password
            chk=check_password_hash(hashedpwd,password)
            if chk:
                session['user_loggedin']=True
                session['userid']=deets.user_id
                return redirect("/dashboard")
            else:
                flash("invalid password")
                return redirect('/login')
        else:
            flash("invalid username")
            return redirect('/login')

        
    

@app.route("/register",methods=["POST","GET"])
def register():
    signupform=SignupForm()
    if request.method=="GET":
        return render_template("user/signup.html",signupform=signupform)
    else:
        if signupform.validate_on_submit():
            #retrieve form data and save in database
            userpass=request.form.get("password")
            u=Users(firstname=request.form.get('firstname'),
                    lastname=request.form.get('lastname'),
                   user_email=request.form.get('email'),
                   user_mobile=request.form.get('mobile'),
                   user_password=generate_password_hash(userpass))
            db.session.add(u)
            db.session.commit()
            #log the user in and redirect to dashboard
            session['userid']=u.user_id
            session["user_loggedin"]=True
            flash("Account created successfully",)
            return redirect("/dashboard")
        else:
            return render_template("user/signup.html",signupform=signupform)
        
@app.route("/profile",methods=["POST","GET"])
@login_required
def profile():
    pform = ProfileForm()
    useronline=session.get('userid')
    userdeets=db.session.query(Users).get(useronline)
    if request.method=="GET":
        return render_template("user/profile.html",pform=pform,userdeets=userdeets)
    else:
        if pform.validate_on_submit():
            firstname=request.form.get('firstname') #pform.fullname.data
            lastname=request.form.get('lastname')
            picture= request.files.get('pix') #pform.pix.data.filename
            filename=pform.pix.data.filename
            picture.save("quizapp/static/images/profile/"+filename)
            userdeets.firstname=firstname
            userdeets.lastname=lastname
            userdeets.pix=filename
            db.session.commit()
            flash("Profile Updated")
            return redirect('/dashboard')
        else:
            return render_template("user/profile.html",pform=pform,userdeets=userdeets)

@app.route("/signout")
def signout():
    
    if session.get('userid') or session.get('user_loggedin'):
        session.pop('userid',None)
        session.pop('user_loggedin',None)
    return redirect('/') 

@app.route("/about")
def about():
    return render_template("user/about.html")

@app.route("/contact")
def contact():
    return render_template("user/contact.html")

@app.route("/feedback")
def feedback():
    return render_template("user/feedback.html")

@app.route("/quiz")
def quiz():
    quizes=db.session.query(Quiz).filter(Quiz.quiz_status=="1").all()
    quizdiff=db.session.query(Difficulty).all()
    return render_template('user/quiz.html',quizes=quizes,quizdiff=quizdiff)

@app.route("/search/quiz")
@login_required
def search_quiz():
    qui=request.args.get('difficulty')
    name=request.args.get('name')
    search_name="%"+name+"%" # or use %{}%.format(title)
    #run query
    result=db.session.query(Quiz).filter(Quiz.quiz_difficulty_id==qui).filter(Quiz.quiz_name.ilike(search_name)).all()
    toreturn=""
    for r in result:
       toreturn=toreturn+ f"<div class='col'><div class='deets'><h6><a href='/takequiz/{r.quiz_id}'>{r.quiz_name}</a></h6><p><i>{r.quizdiff.description}</i></p></div></div"
    return toreturn



@app.route("/donate", methods=['POST','GET'])
def donation():
    useronline=session.get('userid')
    userdeets=db.session.query(Users).get(useronline)
    if request.method=="GET":
        return render_template("user/donations.html",userdeets=userdeets)
    else:
        #retrieve form data
        fullname=request.form.get('fullname')
        email=request.form.get('email')
        amount=request.form.get('amount')
        if request.form.get('userid')=="":
            userid=None
        else:
            userid=request.form.get('userid')

        
        refno=int(random.random()*100000000)
        #create a new donation instance
        don=Donation(don_amt=amount,don_userid=userid,don_fullname=fullname,don_email=email,don_refno=refno,don_status='pending')
        db.session.add(don)
        db.session.commit()
        #we want to save refno in a session we can retrieve the details
        session['ref']=refno
        return redirect("/payment")
    
@app.route("/payment")
def make_payment():
    userdeets=db.session.query(Users).get(session.get('userid'))
    if session.get('ref')!=None:
        ref=session['ref']
        trxdeets=db.session.query(Donation).filter(Donation.don_refno==ref).first()
        return render_template("user/payment.html",trxdeets=trxdeets,userdeets=userdeets)
    else:
        return redirect("/donate")

@app.route("/paystack", methods=["POST"])
def paystack():
    if session.get('ref')!=None:
        ref=session['ref']
        trx=db.session.query(Donation).filter(Donation.don_refno==ref).first()
        email=trx.don_email
        amount=trx.don_amt
        #we want to connect to paystack api
        url="https://api.paystack.co/transaction/initialize"
        headers={"Content-Type": "application/json","Authorization":"Bearer sk_test_d6175e85d581031b31b5f4846bc5d01728e27e95"}
        data={"email": email, "amount": amount*100, "reference":ref}
        response=requests.post(url, headers=headers, data=json.dumps(data))
        rspjson=response.json()
        if rspjson['status'] == True:
            paygateway=rspjson['data']['authorization_url']
            return redirect(paygateway)
        else:
            return rspjson
    else:
        return redirect("/donate")
    
@app.route("/landing")
def paystack_landing():
    ref=session.get('ref')
    if ref==None:
        return redirect('/donate')
    else: #connect to paystack verify
        headers={"Content-Type": "application/json","Authorization":"Bearer sk_test_d6175e85d581031b31b5f4846bc5d01728e27e95"}
        verifyurl="https://api.paystack.co/transaction/verify/"+str(ref)
        response=requests.get(verifyurl,headers=headers)
        rspjson=json.loads(response.text)
        if rspjson['status'] == True: #payment is successful
            return rspjson
        else: #payment was not successful
            return "payment was not successful"