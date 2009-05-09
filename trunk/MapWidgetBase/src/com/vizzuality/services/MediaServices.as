package com.vizzuality.services
{
	import com.adobe.serialization.json.JSON;
	import com.google.maps.InfoWindowOptions;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	import com.google.maps.styles.StrokeStyle;
	import com.vizzuality.data.ImageData;
	import com.vizzuality.data.PA;
	import com.vizzuality.utils.MapUtils;
	import com.vizzuality.view.map.MapController;
	import com.vizzuality.view.map.markers.ImageInfoWindow;
	import com.vizzuality.view.map.markers.WikipediaInfoWindow;
	import com.vizzuality.view.map.markers.WikipediaMarker;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
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
		
		private var existingPoints:Array = new Array();	
		
		private var flickrDict:Dictionary = new Dictionary();	
		
		
		[Bindable] public var pictures:ArrayCollection = new ArrayCollection();
		[Bindable] public var wikipedias:ArrayCollection = new ArrayCollection();
		[Bindable] public var youtubes:ArrayCollection = new ArrayCollection();
		
		public var wikipediaMarkers:Dictionary = new Dictionary();
		public var picturesMarkers:Dictionary = new Dictionary();
		
		
		private var numPicturesRequest:Number=0;
		private var numVideosRequest:Number=0;
		private var numWikipediasRequest:Number=0;
		
		public function MediaServices()
		{
			if( instance ) throw new Error( "Singleton and can only be accessed through Singleton.getInstance()" ); 
			
			panoramioServ.url="http://www.panoramio.com/map/get_panoramas.php?order=popularity&set=public&from=0&to=10&size=mini_square";
			flickrServ.url="http://api.flickr.com/services/rest/?method=flickr.photos.search&format=json" + 
					"&api_key=35479722da32ce91e47ae1147c41cfd9&content_type=1&nojsoncallback=1" + 
					"&extras=icon_server,geo,owner_name"+
					"&per_page=20&min_taken_date=2000-1-1";					
			wikiGeonamesSrv.url = "http://ws.geonames.org/wikipediaBoundingBoxJSON?&maxRows=10";		
			panoramioServ.resultFormat = "text";
			wikiGeonamesSrv.resultFormat = "text";
			flickrServ.resultFormat = "text";
			
			
			wikiGeonamesSrv.addEventListener(ResultEvent.RESULT,onWikiGeonamesResult);
			flickrServ.addEventListener(ResultEvent.RESULT,onImageServiceResult);
			panoramioServ.addEventListener(ResultEvent.RESULT,onImageServiceResult);
		}
		
		public static function gi():MediaServices {
			return instance;
			
			
		}		
		
		
		public function getAllMedia(bbox:LatLngBounds):void {
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
	/* 		panoramioServ.send({minx:firstBBox.getWest(),miny:firstBBox.getSouth(),maxx:firstBBox.getEast(),maxy:firstBBox.getNorth()});
			panoramioServ.send({minx:secondBBox.getWest(),miny:secondBBox.getSouth(),maxx:secondBBox.getEast(),maxy:secondBBox.getNorth()});
			panoramioServ.send({minx:thirdBBox.getWest(),miny:thirdBBox.getSouth(),maxx:thirdBBox.getEast(),maxy:thirdBBox.getNorth()});
			panoramioServ.send({minx:fourthBBox.getWest(),miny:fourthBBox.getSouth(),maxx:fourthBBox.getEast(),maxy:fourthBBox.getNorth()});			 */
			
			numPicturesRequest=numPicturesRequest+4;
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
			var pa:PA = DataServices.gi().activePA;
			for each(var w:Object in jsonObj.geonames as Array) {
				if (MapUtils.pointInPolygon(new LatLng(w.lat, w.lng),pa.geometry)) {
					wikipedias.addItem(w);  
					var marker:Marker = createWikipediaMarker(w);
					wikipediaMarkers[w]=marker;				
				}
			}		
			numWikipediasRequest--;			
			if (numWikipediasRequest==0) {
				dispatchEvent(new DataServiceEvent(DataServiceEvent.WIKIPEDIAS_LOADED));
			}
		} 		
		
		private function onImageServiceResult(event:ResultEvent):void {
			var jsonObj:Object = JSON.decode(String(event.result));		
			var pa:PA = DataServices.gi().activePA;
			
			for each(var photo:Object in jsonObj.photos.photo) {
				if (MapUtils.pointInPolygon(new LatLng(photo.latitude, photo.longitude),pa.geometry) && (!existingPoints.indexOf(photo.latitude+photo.longitude)>=0)) {
					existingPoints.push(photo.latitude+photo.longitude);
					
					var img:ImageData=new ImageData();
					img.latlng = new LatLng(photo.latitude,photo.longitude);
					img.source="Flickr";
					img.owner = photo.ownername;
					img.sourceUrl = "http://www.flickr.com/photos/"+photo.owner+"/"+photo.id;
					img.title = photo.title;
					img.imageUrl = "http://farm"+photo.farm+".static.flickr.com/"+photo.server+"/"+photo.id+"_"+photo.secret+"_m.jpg";
					img.thumbnail = "http://farm"+photo.farm+".static.flickr.com/"+photo.server+"/"+photo.id+"_"+photo.secret+"_s.jpg";
					img.id=photo.id;
					
					
					pictures.addItem(img);
					var loader:Loader = new Loader();
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, createFlickrMarker);
					flickrDict[loader]=img;
					loader.load(new URLRequest(img.thumbnail));				
					
				}
			}
			
			numPicturesRequest--;	
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
		
		
		private function createWikipediaMarker(w:Object):Marker {
			
			var latlng:LatLng = new LatLng(w.lat, w.lng);		      	
	        var marker:Marker = new Marker(latlng, new MarkerOptions(
			       	{tooltip: w.title,
			       	 draggable:false,
			       	 icon: new WikipediaMarker()}));	
			
			var infowindow:WikipediaInfoWindow= new WikipediaInfoWindow();	        
				infowindow.title=w.title;
				infowindow.wikipediaUrl=w.wikipediaUrl;
				infowindow.thumbnailImg=w.thumbnailImg;
				
			var html:String = "";
			if (w.thumbnailImg!=null) {html+='<img src="'+w.thumbnailImg+'" />';}
			html+=w.summary; 
				
			infowindow.html=html;					
			var options2:InfoWindowOptions = new InfoWindowOptions({
                customContent: infowindow,
                strokeStyle: new StrokeStyle({thickness: 0}),
                customOffset: new Point(0, 10),
                cornerRadius:0,
                width: 397,
                drawDefaultFrame: true					
			});
			marker.addEventListener(MapMouseEvent.CLICK, function(e:MapMouseEvent):void {
				//marker.openInfoWindow(options2);
				MapController.gi().map.openInfoWindow(e.latLng,options2);
				
			});
			
			return marker;
		}		
		
		private function createFlickrMarker(ev:Event):void {
			
			var photo:ImageData=flickrDict[ev.target.loader];
			var bmd:BitmapData = Bitmap(ev.currentTarget.content).bitmapData;
			var bmd2:BitmapData = new BitmapData(32,32)
			var m:Matrix = new Matrix();
			m.scale(0.43,0.43);
			bmd2.draw(bmd,m);		
			var sp:Sprite= new Sprite();
            sp.graphics.lineStyle(3,0xFF0071);
            sp.graphics.beginFill(0xFFFFFF,0);
            sp.graphics.drawRect(0,0,31,31);
            sp.graphics.endFill();
            bmd2.draw(sp);
			var iconBitmap:Bitmap= new Bitmap(bmd2);
			
			var latlng:LatLng = photo.latlng;
	      	var photoUrl:String = photo.imageUrl;
	      	
	       var marker:Marker = new Marker(latlng, new MarkerOptions(
	       	{tooltip: photo.title,
	       	 draggable:false,
	       	 icon: iconBitmap}));		        
                
	    	var infowindow:ImageInfoWindow= new ImageInfoWindow();
        	infowindow.ownerName=photo.owner;
        	infowindow.ownerURL=photo.sourceUrl;
        	infowindow.title=photo.title;
        	infowindow.photoFileURL=photo.imageUrl;
        	infowindow.photoURL=photo.sourceUrl;
        	infowindow.source="flickr";
        	infowindow.photoId="flickr"+photo.id;
	       	
	   		var optionsMark:InfoWindowOptions = new InfoWindowOptions({
                customContent: infowindow,
                strokeStyle: new StrokeStyle({thickness: 0}),
                customOffset: new Point(0, 10),
                cornerRadius:0,
                width: 215,
                drawDefaultFrame: true					
			});  	 
	        marker.addEventListener(MapMouseEvent.CLICK, function(e:MapMouseEvent):void {
	      		marker.openInfoWindow(optionsMark);     
	        });      
	        
	        picturesMarkers[photo]=marker;
		} 		
		

	}
}