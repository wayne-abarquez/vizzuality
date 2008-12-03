from google.appengine.ext import db
import datetime

class Name(db.Model):
    name = db.StringProperty()
    taxonomicRankLevel = db.IntegerProperty()
    numRankings = db.IntegerProperty()
    preferedImageURL = db.StringProperty()

class RankedImage(db.Model):
    url = db.StringProperty()
    votes = db.IntegerProperty()
    name = db.ReferenceProperty(Name, required=True, collection_name='ranked_images')


class TaxonName(db.Model):
    name = db.StringProperty()
    source = db.IntegerProperty()

class User(db.Model):
    name = db.StringProperty()
    email = db.StringProperty()
    password = db.StringProperty()
    createdWhen = db.DateTimeProperty(auto_now_add=True)

class Comment(db.Model):
    author = db.ReferenceProperty(User)
    content = db.StringProperty(multiline=True)
    createdWhen = db.DateTimeProperty(auto_now_add=True)

class Source(db.Model):
    author = db.ReferenceProperty(User)
    createdWhen = db.DateTimeProperty(auto_now_add=True)
    reference = db.StringProperty()

class Polygon(db.Model):
    kmlPolygon=db.StringProperty()
    bbox=db.StringProperty()


class Distribution(db.Model):
    taxonName = db.StringProperty()
    taxonGuid = db.IntegerProperty()
    sourceId = db.IntegerProperty()
    sourceName = db.StringProperty()
    description = db.StringProperty()
        
class Layer(db.Model):
    type = db.StringProperty(choices=set(["MASK","DISTRIBUTION"]))
    areaDistributionCompletness = db.StringProperty(choices=set(["DISTRIBUTION_COMPLETE",
                                                                 "DISTRIBUTION_INCOMPLETE",
                                                                 "NOT_KNOWN"]))
    worldDistributionCompletness = db.StringProperty(choices=set(["DISTRIBUTION_COMPLETE",
                                                                 "DISTRIBUTION_INCOMPLETE",
                                                                 "NOT_KNOWN"]))
    oneCellsStatus = db.ListProperty(db.Key)
    ceroFiveCellsStatus = db.ListProperty(db.Key)
    ceroOneCellsStatus = db.ListProperty(db.Key)
    polygon = db.ReferenceProperty(Polygon)
    source = db.ReferenceProperty(Source)
    taxonName = db.StringProperty()
    
    
class CellStatus(db.Model):
    cellId=db.IntegerProperty()
    occurrenceStatus = db.StringProperty(choices=set(
                                                     ["PRESENT",
                                                      "ASSUMED_PRESENT",
                                                      "DOUBT_ABOUT_PRESENCE",
                                                      "EXTINCT",
                                                      "RECORDED_AS_PRESENT_IN_ERROR",
                                                      "ABSENT"]))
    statusInfo = db.StringProperty(choices=set(
                                               ["NATIVE",
                                                "ASSUMED_TO_BE_NATIVE",
                                                "DOUBTFULLY_NATIVE",
                                                "EXTINCT",
                                                "NOT_NATIVE",
                                                "RECORDED_AS_NATIVE_IN_ERROR",
                                                "NONE_OF_THE_ABOVE",
                                                "NOT_APPLICABLE"]))

    
#DTO To talk with Flex
class UserDTO():
    id = int()
    name = str()
    email = str()
    password = str()
    createdWhen = str()

class SourceDTO():
    id = int()
    reference = str()    
    
class LayerDTO():
    id = int()
    type = str()
    areaDistributionCompletness = str()
    worldDistributionCompletness = str()
    polygon = str()
    source = SourceDTO()
    taxonName = str()
    
class PolygonDTO():
    kmlPolygon=str()
    bbox=str()    
    
    
    
    
