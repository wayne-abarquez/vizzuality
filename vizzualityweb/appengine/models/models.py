from google.appengine.ext import db
import datetime

class Feed(db.Model):
    content =  db.TextProperty()
    lastRetrieved = db.DateTimeProperty(None,True)
