#!/usr/bin/env python

# Google App Engine for Flash projects with PyAMF. 
# Copyright (c) 2008 Aral Balkan (http://aralbalkan.com)
# Released under the Open Source MIT License
#
# Blog post: http://aralbalkan.com/1307 
# Google App Engine: http://code.google.com/appengine/
# PyAMF: http://pyamf.org

import wsgiref.handlers
import inspect
from pyamf import BaseError
from pyamf.remoting.gateway.wsgi import WSGIGateway
from models.models import User, TaxonName, Distribution, Name
from google.appengine.api import urlfetch
from xml.dom import minidom

#Create the list of services registered
s={}

# ------------- START DEFINING YOUR OWN SERVICES ------------------- #


def testService(message):
    return message
#Register the service
s.update({'testService': testService})


def createNewUser(name,email,password,createdWhen):
    user = User(name="javi",
                email="jatorre@gmail.com",
                password="pass"
                )
    user.put()
    return user
    
s.update({'createNewUser': createNewUser})


def getNames():
    namesq = Name.gql("WHERE numRankings =:1",None)
    names = []
    for name in namesq:
        _name = {'name':name.name,
                'id':name.key().id()}
        names.append(_name)
    return names
s.update({'search.getNames': getNames})


def getName():
    namesq = Name.gql("WHERE numRankings =:1 LIMIT 1",None)
    for name in namesq:
        _name = {'name':name.name,
                'id':name.key().id()}
        return _name
s.update({'search.getName': getName})

def voteImage(name,url):
    q = Name.gql("WHERE name = :1",name)
    _name = q.get()
    if (_name < 1):
        raise BaseError, "Name does not exist in database!"
    
    _name.preferedImageURL=url;
    _name.numRankings=1;
    _name.put()
    return True
s.update({'search.voteImage': voteImage})

def registerName(name,taxonomicRankLevel):
    if Name.gql("WHERE name = :1",name).count() >0:
        raise BaseError, "Name is already registered"
    tn = Name()
    tn.name = name
    tn.numRankings = 0
    tn.taxonomicRankLevel = taxonomicRankLevel
    tn.put()
    return tn.key().id()
s.update({'registerName': registerName})

















def getDistributionsByTaxonName(search):
    names = []
    dists = []
    distributions = Distribution.gql("WHERE taxonName >= :1 AND taxonName < :2 ORDER BY taxonName ASC LIMIT 10",search,search+"z")
    if (distributions.count() <1):
        raise BaseError, "TaxonName does not exist in database!"
    for distribution in distributions:
        dist = {'sourceId':distribution.sourceId,
                'sourceName':distribution.sourceName,
                'description':distribution.description,
                'id':distribution.key().id()}
        dists.append(dist)
        names.append({'taxonName':distribution.taxonName,
                      'taxonGuid':distribution.taxonGuid,
                      'distributions': dists
                     })

    return names
s.update({'search.getDistributionsByTaxonName': getDistributionsByTaxonName})


def getTaxonNameGuid(name):
    q = TaxonName.gql("WHERE name = :1",name)
    result = q.get()
    if (result < 1):
        raise BaseError, "TaxonName does not exist in database!"
    return result.key().id()
s.update({'search.getTaxonNameGuid': getTaxonNameGuid})


def getGuid(taxonName):
    #Get the taxonKaye
    url="http://data.gbif.org/ws/rest/taxon/list?dataproviderkey=1&maxresults=1&scientificname="+ taxonName.replace(' ','%20')
    result = urlfetch.fetch(url)
    if result.status_code == 200:
        _s = result.content.find("TaxonConcept gbifKey=")
        _e = result.content.find('"',_s+22)
        taxonKey = result.content[_s+22:_e]
    else:
        raise BaseError, "Error connecting to GBIF" 
    return taxonKey
    
def loadGridDataByName(taxonName):
    
    taxonKey = getGuid(taxonName)
    #Find density data
    url = "http://data.gbif.org/ws/rest/density/list?taxonconceptkey="+taxonKey
    result = urlfetch.fetch(url)
    if result.status_code == 200:
        GBIF_NS = "http://portal.gbif.org/ws/response/gbif"
        dom = minidom.parseString(result.content)
        grids = []
        for node in dom.getElementsByTagNameNS(GBIF_NS,'densityRecord'):
            grids.append(int(node.getAttribute('cellid')))
        
        return grids
    else:
        raise BaseError, "Error retriving density data"
    
    

s.update({'loadGridDataByName': loadGridDataByName})    











# ------------- END DEFINING YOUR OWN SERVICES ------------------- #

def getServices():
    """Get the list of services
    
    Returns An array of array ready to be bound to a Tree"""
    services = []
    for serviceName in s.keys():
        if (serviceName != 'getServices' and serviceName != 'describeService'):
            services.append({'label':serviceName,'data':''})
    
    return services
s.update({'getServices': getServices})

def describeService(serviceName):
    """Describe a service and all its methods

    Returns An object containing 'label' and 'data' keys"""
    #myFunc.func_code.co_varnames
    if (serviceName in s.keys()):
        methodTable =  {serviceName:
                            {'description':inspect.getdoc(s[serviceName]),
                            'arguments': inspect.getargspec(s[serviceName])[0],
                            'access':'',
                            'returns':''}
                        }
    else:
        raise BaseError, "No Service with this name"
    return methodTable


s.update({'describeService': describeService})


def main():
    application = WSGIGateway(s)
    wsgiref.handlers.CGIHandler().run(application)

if __name__ == '__main__':
    main()
