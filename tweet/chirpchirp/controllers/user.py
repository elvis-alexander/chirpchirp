from .. utils import responses
from .. utils import auth
from .. db.tweetdb import tweetdb
from .. models.usermodel import usermodel
from django.views.decorators.csrf import csrf_exempt
from django.shortcuts import get_object_or_404, render

# /adduser {username, email, password}
# no bad result maybe if username already exists
@csrf_exempt
def adduser(request):
    u = usermodel(request)
    db = tweetdb(user=u)
    # actually add user here
    success = db.insertdisable()
    db.close()
    if(success):
        return responses.ok_response()
    else:
        return responses.err_response("username or email already exists")


# /verify {email, key}
# no check to see if a user with this email
@csrf_exempt
def verify(request):
    u = usermodel(request)
    db = tweetdb(user=u)
    db.verifyuser()
    db.close()
    return responses.ok_response()

# login resource (username, password)
@csrf_exempt
def login(request):
    # used to login
    u = usermodel(request)
    db = tweetdb(user=u)
    # verify user and account details
    if db.isverified() == False:
        db.close()
        return responses.err_response("Not Verified")
    # store cookie/session
    request.session["uid"] = db.getuid()
    request.session["uname"] = u.username
    db.close()
    return responses.redirect_ok_response("/homepage")

# logout {}
@csrf_exempt
def logout(request):
    try:
        del request.session['uname']
        del request.session['uid']
        return responses.redirect_ok_response('/')
    except KeyError:
        return responses.err_response("Please login, before logging out")