import cgi
import wsgiref.handlers
import urllib
from google.appengine.ext import webapp
from google.appengine.api import urlfetch
from google.appengine.api import mail
from google.appengine.ext import db
from datetime import datetime
from models import Inscripcion
 
class GoogleSpreadsheetsController(webapp.RequestHandler):
    """Proxy for Vizzuality"""
    def post(self):
        url = 'http://spreadsheets.google.com/formResponse'
        
        insc_id=1
        q = db.GqlQuery("SELECT * FROM Inscripcion ORDER BY created_when DESC")
        inscripcion = q.get()
        if (inscripcion != None):
            insc_id = inscripcion.id_inscripcion+1
        
        newinsc = Inscripcion()
        newinsc.id_inscripcion = insc_id
        newinsc.put()

        params = self.request.POST
        
        #Add the generated ID
        params['entry.10.single'] = str(insc_id)
        
        paramsCoded = urllib.urlencode(dict([k, v.encode('utf-8')] for k, v in params.items()))
        #paramsCoded = urllib.urlencode(params)

        result = urlfetch.fetch(url=url,payload=paramsCoded, method=urlfetch.POST)
        if params.get("emailToEmail")!="":
            subjectLine = params.get("emailSubject") + ".Inscripcion num: " + str(insc_id)
            message = mail.EmailMessage(sender=params.get("emailSender"),
                                    subject=subjectLine)

            message.to = params.get("emailToName") +" <"+params.get("emailToEmail")+">"
            message.body = params.get("emailBody").replace("||NUM_INSCRIPCION||",str(insc_id))

            message.send()   
        
        self.response.out.write(params)

def main():
    application = webapp.WSGIApplication([('/gpreadsheets/', GoogleSpreadsheetsController)],debug=True)
    wsgiref.handlers.CGIHandler().run(application)

if __name__ == "__main__":
    main()