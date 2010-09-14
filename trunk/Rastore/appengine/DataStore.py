from google.appengine.ext import db

#stores mapping to GS raster folders
class Raster(db.Model):
  objId = db.StringProperty() #The unique key for the object, perm9c63a1c1-9d89-4562-97cf-b1a479e56460
  objPng = db.BlobProperty()
  status = db.StringProperty()
  email = db.EmailProperty() 
  taxon = db.StringProperty() 
  taxonid = db.StringProperty() 
  program = db.StringProperty() 
  description = db.StringProperty() 
  details = db.StringProperty() 
  authors = db.StringListProperty() 
  tags = db.StringListProperty() 
  year = db.IntegerProperty(default=None) 
  last_access_date = db.DateTimeProperty(auto_now_add=True)
  creation_date = db.DateTimeProperty(auto_now_add=True)
  downloadCt = db.IntegerProperty(default=1) #Track how popular the raster is
  isPublic = db.BooleanProperty(default=True) #Show raster in public listings
  inTrash = db.BooleanProperty(default=False) #Remove raster from all listings if in trash
  version = db.StringProperty(default="1-0") #The version of our app that made this tree

class Taxa(db.Model):
  name = db.StringProperty()
  uuid = db.StringProperty()
