package com.vizzuality.services
{
	import com.adobe.serialization.json.JSON;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.vizzuality.utils.MapUtils;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;
	
	[Event(name="picturesLoaded", type="com.vizzuality.services.DataServiceEvent")]
	[Event(name="wikipediasLoaded", type="com.vizzuality.services.DataServiceEvent")]
	[Event(name="picturesLoaded", type="com.vizzuality.services.DataServiceEvent")]
	public final class MediaServices extends EventDispatcher
	{
		
		private static var instance:MediaServices = new MediaServices();
		
		private var wikiGeonamesSrv:HTTPService = new HTTPService();
		private var panoramioServ:HTTPService = new HTTPService();
		private var flickrServ:HTTPService = new HTTPService();
		private var youtubeServ:HTTPService = new HTTPService();
		
		
		[Bindable] public var pictures:ArrayCollection = new ArrayCollection();
		[Bindable] public var wikipedias:ArrayCollection = new ArrayCollection();
		[Bindable] public var youtubes:ArrayCollection = new ArrayCollection();
		
		private var numPicturesRequest:Number=0;
		private var numVideosRequest:Number=0;
		private var numWikipediasRequest:Number=0;
		
		public function MediaServices()
		{
			if( instance ) throw new Error( "Singleton and can only be accessed through Singleton.getInstance()" ); 
		}
		
		public static function gi():MediaServices {
			return instance;
			
			panoramioServ.url="http://www.panoramio.com/map/get_panoramas.php?order=popularity&set=public&from=0&to=10&size=mini_square";
			flickrServ.url="http://api.flickr.com/services/rest/?method=flickr.photos.search&format=json" + 
					"&api_key=35479722da32ce91e47ae1147c41cfd9&content_type=1&nojsoncallback=1" + 
					"&extras=icon_server,geo,owner_name"+
					"&per_page=10&min_taken_date=2000-1-1";					
			wikiGeonamesSrv.url = "http://ws.geonames.org/wikipediaBoundingBoxJSON?&maxRows=10";		
			panoramioServ.resultFormat = "text";
			wikiGeonamesSrv.resultFormat = "text";
			flickrServ.resultFormat = "text";
			
			
			wikiGeonamesSrv.addEventListener(ResultEvent.RESULT,onWikiGeonamesResult);
			flickrServ.addEventListener(ResultEvent.RESULT,onImageServiceResult);
			panoramioServ.addEventListener(ResultEvent.RESULT,onImageServiceResult);
			
		}		
		
		
		public function getAllMedia2(bbox:LatLngBounds):void {
			getPictures(bbox);
			getVideos(bbox);
			getWikipedia(bbox);
		}

		
		
		public function getPictures(bbox:LatLngBounds):void {
			
			//divide the boundig box into 4 little boundig boxes
			var firstBBox:LatLngBounds = new LatLngBounds(bbox.getSouthWest(),bbox.getCenter());
			var secondBBox:LatLngBounds = new LatLngBounds(bbox.getCenter(),bbox.getNorthEast());
			var thirdBBox:LatLngBounds = new LatLngBounds(firstBBox.getNorthWest(),new LatLng(secondBBox.getNorth(),bbox.getCenter().lng()));
			var fourthBBox:LatLngBounds = new LatLngBounds(firstBBox.getSouthEast(),secondBBox.getNorthEast());
			flickrServ.send({bbox:firstBBox.getWest()+","+firstBBox.getSouth()+","+firstBBox.getEast()+","+firstBBox.getNorth()});			
			flickrServ.send({bbox:secondBBox.getWest()+","+secondBBox.getSouth()+","+secondBBox.getEast()+","+secondBBox.getNorth()});			
			flickrServ.send({bbox:thirdBBox.getWest()+","+thirdBBox.getSouth()+","+thirdBBox.getEast()+","+thirdBBox.getNorth()});			
			flickrServ.send({bbox:fourthBBox.getWest()+","+fourthBBox.getSouth()+","+fourthBBox.getEast()+","+fourthBBox.getNorth()});
			panoramioServ.send({minx:firstBBox.getWest(),miny:firstBBox.getSouth(),maxx:firstBBox.getEast(),maxy:firstBBox.getNorth()});
			panoramioServ.send({minx:secondBBox.getWest(),miny:secondBBox.getSouth(),maxx:secondBBox.getEast(),maxy:secondBBox.getNorth()});
			panoramioServ.send({minx:thirdBBox.getWest(),miny:thirdBBox.getSouth(),maxx:thirdBBox.getEast(),maxy:thirdBBox.getNorth()});
			panoramioServ.send({minx:fourthBBox.getWest(),miny:fourthBBox.getSouth(),maxx:fourthBBox.getEast(),maxy:fourthBBox.getNorth()});			
			
			numPicturesRequest=numPicturesRequest+8;
		}
		
		public function getVideos(bbox:LatLngBounds):void {
			
			numVideosRequest++;
		}
		
		public function getWikipedia(bbox:LatLngBounds):void {
			wikiGeonamesSrv.send({north:bbox.getNorth(),east:bbox.getEast(),west:bbox.getWest(),south:bbox.getSouth()});
			
			numWikipediasRequest++;
		}		
		
		private function onWikiGeonamesResult(event:ResultEvent):void {
			
			var jsonObj:Object = JSON.decode(String(event.result))
			for each(var w:Object in jsonObj.geonames as Array) {
				if (MapUtils.pointInPolygon(new LatLng(w.lat, w.lng),DataServices.gi().activePA.geometry)) {
					wikipedias.addItem(w);  				
				}
			}		
			
			
			numWikipediasRequest--;			
			if (numWikipediasRequest==0) {
				dispatchEvent(new DataServiceEvent(DataServiceEvent.WIKIPEDIAS_LOADED));
			}
		} 		
		private function onImageServiceResult(event:ResultEvent):void {
			
			if (numPicturesRequest==0) {
				dispatchEvent(new DataServiceEvent(DataServiceEvent.PICTURES_LOADED));
			}
		} 		
		private function onYoutubeResult(event:ResultEvent):void {
			
			if (numVideosRequest==0) {
				dispatchEvent(new DataServiceEvent(DataServiceEvent.YOUTUBES_LOADED));
			}
		} 	
		
		private function removeAllMedia():void {
			//First cancel all pending requests.
			//TODO
			
			
			pictures=new ArrayCollection();
			wikipedias=new ArrayCollection();
			youtubes=new ArrayCollection();
		}	
		

	}
}