import cgi
from google.appengine.api import users
from google.appengine.ext import webapp
from google.appengine.ext.webapp.util import run_wsgi_app
from google.appengine.ext import db
from google.appengine.api import memcache

import os, sys, string, Cookie, sha, time, random, cgi, urllib,urllib2
import datetime, StringIO, pickle, urllib2
import uuid, zipfile

import wsgiref.handlers
from google.appengine.api import memcache, urlfetch
from google.appengine.ext.webapp import template
from django.utils import feedgenerator, simplejson
from django.template import Context, Template
import logging


class HelpDirectory(webapp.RequestHandler):
  def get(self):
    #template_values = GenericHelpTemplate(self)  
    #path = os.path.join(os.path.dirname(__file__), 'templates/helppages/helpDirectory.html')
    #self.response.out.write(template.render(path, template_values))     
    self.response.out.write("help")     
    
