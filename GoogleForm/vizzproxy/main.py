import cgi
import wsgiref.handlers
import urllib
from google.appengine.ext import webapp
from google.appengine.api import urlfetch
 
class GoogleSpreadsheetsController(webapp.RequestHandler):
    """Proxy for Vizzuality"""
    def post(self):
        url = 'http://spreadsheets.google.com/formResponse'

        params = self.request.POST
        paramsCoded = urllib.urlencode(params)

        result = urlfetch.fetch(url=url,payload=paramsCoded, method=urlfetch.POST)
        self.response.out.write(params)

def main():
    application = webapp.WSGIApplication([('/gpreadsheets/', GoogleSpreadsheetsController)],debug=True)
    wsgiref.handlers.CGIHandler().run(application)

if __name__ == "__main__":
    main()