import wsgiref.handlers
from google.appengine.ext import webapp
from google.appengine.ext.webapp import template
from google.appengine.api import urlfetch
from xml.dom import minidom 
from google.appengine.ext import db
from datetime import datetime
from models.models import Feed

from urlparse import urlparse

import logging
import os, glob

class IndexHandler(webapp.RequestHandler):

	def get(self):
		
		q = db.GqlQuery("SELECT * FROM Feed")
		
		feed = q.get()
		if (feed == None or feed.lastRetrieved.day != datetime.now().day):
			content = self.retrieveFeed()
			if (content == None):
				content = """<div class="blogPost"><p class="postDate">Sorry, the blog feed is temporarily unavailable.</p></div>"""
			else:				
				if feed== None:
					feed = Feed()
				feed.content=content
				feed.put()
			
		else:
			content=feed.content;		
		
		
		template_values = {
			'feed': content,
			'section':'home'
		}		
		
		path = os.path.join(os.path.dirname(__file__), 'templates/home.html')
		self.response.out.write(template.render(path, template_values, debug=True))
	
	def retrieveFeed(self):
		try:
			FEEDBURNER_NS = 'http://rssnamespace.org/feedburner/ext/1.0' 
			resultHTML=""
			result = urlfetch.fetch("http://biodivertido.blogspot.com/feeds/posts/default")
			if result.status_code == 200:
				dom = minidom.parseString(result.content) 
				#Here we have to parse the data into HTML
				content=""
				i=0
				for node in dom.getElementsByTagName('entry'):
					i=i+1
					if (i==5):
						break
					content=content+"""
					          <div id="post">
					            <p class="postTitle"><a href='"""+node.getElementsByTagNameNS(FEEDBURNER_NS,'origLink')[0].firstChild.nodeValue+"""'> """+node.getElementsByTagName('title')[0].firstChild.nodeValue+"""</a></p>
					            <p class="postMetadata">"""+node.getElementsByTagName('published')[0].firstChild.nodeValue[0:10]+""" by """+node.getElementsByTagName('author')[0].getElementsByTagName('name')[0].firstChild.nodeValue+"""</p>
					          </div>"""
				return content
			else:
				return None
		except:
			return  None

class CompanyHandler(webapp.RequestHandler):

	def get(self):
		# Write out contact file.
		path = os.path.join(os.path.dirname(__file__), 'templates/company.html')
		self.response.out.write(template.render(path, {'section':'contact'}, debug=True))	
		
class WorksHandler(webapp.RequestHandler):

	def get(self):
		# Write out contact file.
		path = os.path.join(os.path.dirname(__file__), 'templates/works.html')
		self.response.out.write(template.render(path, {'section':'works'}, debug=True))		


class EmployeeHandler(webapp.RequestHandler):

			def get(self,p):
				path = os.path.join(os.path.dirname(__file__), 'templates/employees/'+p+'.html')
		#		logging.error("value of my p is %s", str(path))		
				if not os.path.exists(path):
					self.error(404)
					path = os.path.join(os.path.dirname(__file__), 'templates/404.html')
					self.response.out.write(template.render(path, {'title': 'Error 404: Page not found'}, debug=True))

				self.response.out.write(template.render(path, {'section':'works'},debug=True))

class DetailHandler(webapp.RequestHandler):

	def get(self,p):
		path = os.path.join(os.path.dirname(__file__), 'templates/projects/'+p+'.html')
#		logging.error("value of my p is %s", str(path))		
		if not os.path.exists(path):
			self.error(404)
			path = os.path.join(os.path.dirname(__file__), 'templates/404.html')
			self.response.out.write(template.render(path, {'title': 'Error 404: Page not found'}, debug=True))

		self.response.out.write(template.render(path, {'section':'works'},debug=True))   

class PyAMFBrowser(webapp.RequestHandler):
	def get(self):
		path = os.path.join(os.path.dirname(__file__), 'templates/serviceBrowser.html')
		self.response.out.write(template.render(path, None,debug=True))    

class NotFoundHandler(webapp.RequestHandler):
	
	def get(self):
		# Not found
		template_vars = {
		'title': 'Error 404: Page not found'
		}
		self.error(404)
		path = os.path.join(os.path.dirname(__file__), 'templates/404.html')
		self.response.out.write(template.render(path, template_vars, debug=True))

def main():
	application = webapp.WSGIApplication([
		('/', IndexHandler),
		('/company', CompanyHandler),
		(r'/company/(.*)', EmployeeHandler),
		('/contact', CompanyHandler),
		('/works', WorksHandler),
		(r'/project/(.*)', DetailHandler),
		('/amf/*', PyAMFBrowser),
		('/.*', NotFoundHandler)
	], debug=True)
	wsgiref.handlers.CGIHandler().run(application)

if __name__ == '__main__':
  main()
