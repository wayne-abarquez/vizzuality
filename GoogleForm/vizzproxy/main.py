import cgi
import wsgiref.handlers
import urllib
from google.appengine.ext import webapp
from google.appengine.api import urlfetch
from google.appengine.api import mail
 
class GoogleSpreadsheetsController(webapp.RequestHandler):
    """Proxy for Vizzuality"""
    def post(self):
        url = 'http://spreadsheets.google.com/formResponse'

        params = self.request.POST
        paramsCoded = urllib.urlencode(dict([k, v.encode('utf-8')] for k, v in params.items()))
        #paramsCoded = urllib.urlencode(params)

        result = urlfetch.fetch(url=url,payload=paramsCoded, method=urlfetch.POST)
        if params.get("emailToEmail")!="":
            message = mail.EmailMessage(sender=params.get("emailSender"),
                                    subject=params.get("emailSubject"))

            message.to = params.get("emailToName") +" <"+params.get("emailToEmail")+">"
            message.body = params.get("emailBody")

            message.send()   
        
        self.response.out.write(params)

def main():
    application = webapp.WSGIApplication([('/gpreadsheets/', GoogleSpreadsheetsController)],debug=True)
    wsgiref.handlers.CGIHandler().run(application)

if __name__ == "__main__":
    main()