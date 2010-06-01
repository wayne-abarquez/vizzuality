from google.appengine.ext import db
import datetime

class Inscripcion(db.Model):
    id_inscripcion = db.IntegerProperty()
    updated_when = db.DateTimeProperty(None,True)
    created_when = db.DateTimeProperty(None,False,True)
