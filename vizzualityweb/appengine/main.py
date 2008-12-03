import wsgiref.handlers
from google.appengine.ext import webapp
from google.appengine.ext.webapp import template

from urlparse import urlparse

import logging
import os

class IndexHandler(webapp.RequestHandler):

	def get(self):
		# Write out index file.
		# Thanks to Javier for pointing out the static_dir does _not_ work for templates.  
		# (see http://aralbalkan.com/1307#comment-135454)
		path = os.path.join(os.path.dirname(__file__), 'templates/index.html')
		self.response.out.write(template.render(path, None, debug=True))

class ContactHandler(webapp.RequestHandler):

	def get(self):
		# Write out contact file.
		path = os.path.join(os.path.dirname(__file__), 'templates/contact.html')
		self.response.out.write(template.render(path, None, debug=True))		

class PyAMFBrowser(webapp.RequestHandler):
	def get(self):
		path = os.path.join(os.path.dirname(__file__), 'templates/serviceBrowser.html')
		self.response.out.write(template.render(path, None,debug=True))    

class NotFoundHandler(webapp.RequestHandler):
	
	def get(self):
		# Not found
		template_vars = {
		'title': 'Error 404.',
		'content': 'Error 404'
		}
		path = os.path.join(os.path.dirname(__file__), 'templates/simple.html')
		self.response.out.write(template.render(path, template_vars, debug=True))

def main():
	application = webapp.WSGIApplication([
		('/', IndexHandler),
		('/contact/', ContactHandler),
		('/amf/*', PyAMFBrowser),
		('/.*', IndexHandler)
	], debug=True)
	wsgiref.handlers.CGIHandler().run(application)

if __name__ == '__main__':
  main()
