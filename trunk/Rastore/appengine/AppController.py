import cgi
from google.appengine.api import users
from google.appengine.ext import webapp
from google.appengine.ext.webapp.util import run_wsgi_app
from google.appengine.ext import db
from google.appengine.api import memcache, urlfetch

import os, sys, string, Cookie, sha, time, random, cgi, urllib,urllib2
import datetime, StringIO, pickle, base64
import uuid, zipfile
import xml.etree.cElementTree as ET

import wsgiref.handlers
from google.appengine.ext.webapp import template
from django.utils import feedgenerator, simplejson
from django.template import Context, Template
import logging


#project module storing all the db table models
from DataStore import *
from HelpControllers import *
from GenericMethods import *

EXAMPLE_KEY = '1-0-5bc4cee7-cdc7-4601-8c81-a0dd58a25765'


class MainPage(webapp.RequestHandler): #landing page
  def get(self): 
    user,url,url_linktext,email = GetCurrentUser(self) #generic method to get logged in user data
  
    template_values = {
            'user':user,
            'url': url,
            'url_linktext': url_linktext
            }
    path = os.path.join(os.path.dirname(__file__), 'templates/home.html')
    self.response.out.write(template.render(path, template_values))
      
      
class Upload(webapp.RequestHandler):
  def get(self): 
    k = self.request.params.get('k', str(uuid.uuid4()))
    template_values = {
        'k': k
    }
    path = os.path.join(os.path.dirname(__file__), 'templates/upload.html')
    self.response.out.write(template.render(path, template_values))

class Bounce(webapp.RequestHandler):
  def get(self): 
    self.redirect("http://mol.colorado.edu/birdrep/tiling/upload")


class RasterStatus(webapp.RequestHandler): #lookup the status of the raster processing
  def get(self): 
    user,url,url_linktext,email = GetCurrentUser(self)
    
    k = str(self.request.params.get('k', ''))
    
    #get the raster
    layers = Raster.gql("WHERE objId = :objId",
                        objId=k).fetch(1)
    out = {}
    for layer in layers:
        out['status'] = str(layer.objStatus)
        out['estimate'] = int(layer.objTimeEstimate)
        
    self.response.out.write(out)
    

class RasterUpdate(webapp.RequestHandler): #update the status of the raster processing
  def post(self): 
    k = self.request.params.get('k', None)
    
    status = self.request.params.get('status', 'working')
    estimate = int(self.request.params.get('estimate', 300))
    
    layer = Raster.gql("WHERE objId = :objId",
                        objId=k).fetch(1)
    if len(layer)==0:
        raster = Raster(
                    objId = k,
                    status = status,
                 )
        raster.put()
    else:
        layer[0].status = status
        layer[0].put()
        
    return 200
    

class RasterCreate(webapp.RequestHandler): #create a new raster object in the datastore. meant to recieve a post from the private remote server
  def post(self): 
    #k is always the raster unique key. From the R version, k is defined on the remote server, on the browser version, k is set prior to upload
    k = self.request.params.get('k', None)
    
    layer = Raster.gql("WHERE objId = :objId",
                        objId=k).fetch(1)
    
    #if authors param is set, we need to split by comma into a list
    authors = self.request.params.get('authors', None)
    if authors is not None:
        authors = str(authors).split(',')
    else:
        authors = []
        
    #if tags param is set, we need to split by comma into a list
    tags = self.request.params.get('tags', None)
    if tags is not None:
        tags = str(tags).split(',')
    else:
        tags = []
        
    
    if len(layer)==0:
        #create a new Raster object
        raster = Raster(
                    objId = k,
                    authors = authors,
                    tags = tags,
                    description = self.request.params.get('description', None),
                    program = self.request.params.get('program', None),
                    details = self.request.params.get('details', None),
                    year = self.request.params.get('year', None),
                    taxon = self.request.params.get('taxon', None)
                 )
        raster.put()
    else: #else update info about an existing raster object
        layer = layer[0]
        
        #this is rather unsophisticated. but we only want to be able to update information
        #about the raster if it is blank. this is a very basic way to ensure that once a raster is written it is not overwritten by anyone posting to the same k maliciously
        if layer.taxon is None:
            layer.authors = authors
            layer.tags = tags
            layer.description = self.request.params.get('description', None)
            layer.program = self.request.params.get('program', None)
            layer.details = self.request.params.get('details', None)
            layer.taxon = self.request.params.get('taxon', None)
            yr = self.request.params.get('year', None)
            if yr is not None:
                layer.year = int(yr)
        layer.put()
    self.redirect("/viewer?k=%s" % k)
     
class RasterViewer(webapp.RequestHandler):
  def get(self): 
  
    user,url,url_linktext,email = GetCurrentUser(self)
        
    k = self.request.params.get('k', None)
    if k is None:
        k = EXAMPLE_KEY
    
    layer = Raster.gql("WHERE objId = :objId",
                        objId=k).fetch(1)
                        
    if len(layer) == 0:
        path = os.path.join(os.path.dirname(__file__), 'templates/model.html')
        self.response.out.write(template.render(path, {}))
    else:
        layer = layer[0]
        authors = ''
        if layer.authors is not None: #create an author string
            authors = ', '.join(list(layer.authors))
        
        tags = ''
        if layer.tags is not None: #create a tag string
            tags = ', '.join(list(layer.tags))
            
        template_values = {
            'authors': authors,
            'taxon': layer.taxon,
            'year': layer.year,
            'tags': layer.tags,
            'program': layer.program,
            'description': layer.description,
            'details': layer.details,
            'key': k
            }
        path = os.path.join(os.path.dirname(__file__), 'templates/model.html')
        self.response.out.write(template.render(path, template_values))
    
class DailyCron(webapp.RequestHandler):
  def get(self):   
    #seven_days_ago = datetime.datetime.now() - datetime.timedelta(days=7)
    pass

application = webapp.WSGIApplication(
                 [('/', MainPage),
                  ('/upload', Upload),
                  ('/bounce', Bounce),
                  ('/viewer', RasterViewer),
                  ('/status', RasterStatus),
                  ('/raster/update', RasterUpdate),
                  ('/raster/create', RasterCreate),
                  ('/dailycron', DailyCron)],      
                 debug=False)

def main():
  run_wsgi_app(application)

if __name__ == "__main__":
  main()

