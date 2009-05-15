package com.vizzuality.services
{
	import com.adobe.serialization.json.JSON;
	import com.google.maps.InfoWindowOptions;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.MapEvent;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	import com.google.maps.styles.StrokeStyle;
	import com.vizzuality.data.ImageData;
	import com.vizzuality.data.PA;
	import com.vizzuality.data.YoutubeVideoData;
	import com.vizzuality.view.map.MapController;
	import com.vizzuality.view.map.markers.WikipediaInfoWindow;
	import com.vizzuality.view.map.markers.WikipediaMarker;
	import com.vizzuality.view.map.markers.YoutubeSprite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
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
		
		private var flickrDict:Dictionary = new Dictionary(true);	
		private var youtubeDict:Dictionary = new Dictionary(true);	
		
		
		[Bindable] public var pictures:ArrayCollection = new ArrayCollection();
		[Bindable] public var wikipedias:ArrayCollection = new ArrayCollection();
		[Bindable] public var youtubes:ArrayCollection = new ArrayCollection();
		
		public var wikipediaMarkers:Dictionary = new Dictionary(true);
		public var picturesMarkers:Dictionary = new Dictionary(true);
		public var picturesInfoWindows:Dictionary = new Dictionary(true);
		public var youtubesMarkers:Dictionary = new Dictionary(true);
		public var youtubesInfoWindows:Dictionary = new Dictionary(true);
		
		
		[Bindable] public var numPicturesRequest:Number=0;
		[Bindable] public var numVideosRequest:Number=0;
		[Bindable] public var numWikipediasRequest:Number=0;
		
		private var youtubeSprite:YoutubeSprite = new YoutubeSprite();
		
		public function MediaServices()
		{
			if( instance ) throw new Error( "Singleton and can only be accessed through Singleton.getInstance()" ); 
			
			panoramioServ.url="http://www.panoramio.com/map/get_panoramas.php?order=popularity&set=public&from=0&to=10&size=mini_square";
			flickrServ.url="http://api.flickr.com/services/rest/?method=flickr.photos.search&format=json" + 
					"&api_key=35479722da32ce91e47ae1147c41cfd9&content_type=1&nojsoncallback=1" + 
					"&extras=icon_server,geo,owner_name"+
					"&per_page=20&min_taken_date=2000-1-1";					
			wikiGeonamesSrv.url = "http://ws.geonames.org/wikipediaBoundingBoxJSON?&maxRows=10";		
			youtubeServ.url = "http://gdata.youtube.com/feeds/api/videos?max-results=10&v=2&alt=json";
			panoramioServ.resultFormat = "text";
			wikiGeonamesSrv.resultFormat = "text";
			flickrServ.resultFormat = "text";
			youtubeServ.resultFormat = "text";
			//"http://gdata.youtube.com/feeds/api/videos?max-results=10&v=2&alt=json&location=37.42307,-122.08427&location-radius=100km"
			
			wikiGeonamesSrv.addEventListener(ResultEvent.RESULT,onWikiGeonamesResult);
			flickrServ.addEventListener(ResultEvent.RESULT,onImageServiceResult);
			panoramioServ.addEventListener(ResultEvent.RESULT,onImageServiceResult);
			youtubeServ.addEventListener(ResultEvent.RESULT,onYoutubeResult);
			
			wikiGeonamesSrv.addEventListener(FaultEvent.FAULT,onFault);
			flickrServ.addEventListener(FaultEvent.FAULT,onFault);
			panoramioServ.addEventListener(FaultEvent.FAULT,onFault);
			youtubeServ.addEventListener(FaultEvent.FAULT,onFault);
		}
		
		public static function gi():MediaServices {
			return instance;
			
			
		}	
		
		public function getAllMedia(bbox:LatLngBounds):void {
			//resete everything
			pictures = new ArrayCollection();
			wikipedias = new ArrayCollection();
			youtubes = new ArrayCollection();
			
			wikipediaMarkers = new Dictionary(true);
			picturesMarkers = new Dictionary(true);
			picturesInfoWindows = new Dictionary(true);
			youtubesMarkers = new Dictionary(true);
			youtubesInfoWindows = new Dictionary(true);
			existingPoints=[];
			MapController.gi().clearOverlays();
			
		
			getPictures(bbox);
			getVideos(bbox);
			getWikipedia(bbox);
		}

			
		private function onFault(event:FaultEvent):void {
			trace(event.message);
		}			
		
		
		public function getPictures(bbox:LatLngBounds):void {
			//divide the boundig box into 4 little boundig boxes
			var firstBBox:LatLngBounds = new LatLngBounds(bbox.getSouthWest(),bbox.getCenter());
			var secondBBox:LatLngBounds = new LatLngBounds(bbox.getCenter(),bbox.getNorthEast());
			var thirdBBox:LatLngBounds = new LatLngBounds(firstBBox.getNorthWest(),new LatLng(secondBBox.getNorth(),bbox.getCenter().lng()));
			var fourthBBox:LatLngBounds = new LatLngBounds(firstBBox.getSouthEast(),secondBBox.getSouthEast());
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
			var radius:Number = bbox.getNorthEast().distanceFrom(bbox.getSouthEast());
			var radius2:Number = bbox.getNorthEast().distanceFrom(bbox.getNorthWest());
			if(radius2>radius)
				radius=radius2;
			radius=radius/1000;
			var location:String = bbox.getCenter().lat() + ","+bbox.getCenter().lng() + "!";
			youtubeServ.send({
				location:location,
				"location-radius":radius +"km"
			});
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
				if(pa.geometry.pointInPolygon(new LatLng(w.lat, w.lng))) {
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
				if(pa.geometry.pointInPolygon(new LatLng(photo.latitude, photo.longitude)) && (!existingPoints.indexOf(photo.latitude+photo.longitude)>=0)) {
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
			var jsonObj:Object = JSON.decode(String(event.result));	
			var pa:PA = DataServices.gi().activePA;
			for each(var v:Object in (jsonObj.feed.entry as Array)) {
				var coords:Array = (v["georss$where"]["gml$Point"]["gml$pos"]["$t"] as String).split(" ");
				var coor:LatLng =new LatLng(coords[0],coords[1]);
				if (pa.geometry.pointInPolygon(coor) && (!existingPoints.indexOf(coor.lat()+coor.lng())>=0)) {
					var video:YoutubeVideoData=new YoutubeVideoData();
					video.link = v.link[0].href;
					video.title = v.title["$t"];
					video.latlng = coor;
					var idString:String = v.id["$t"];
					video.id = idString.substr(idString.lastIndexOf("video:")+6,idString.length-1);
					video.thumbnail = v["media$group"]["media$thumbnail"][0]["url"];
									
					youtubes.addItem(video);
	
					var loader:Loader = new Loader();
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, createYoutubeMarker);
					youtubeDict[loader]=video;
					loader.load(new URLRequest(video.thumbnail));		
				}			
			}		
			numVideosRequest--;	
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
              
        	var infowindow:Loader= new Loader();
        	infowindow.load(new URLRequest(photo.imageUrl));
        	infowindow.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void {
        		navigateToURL(new URLRequest(photo.sourceUrl));
        	});
        	
        	infowindow.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void {
		   	
		   		var bm:Bitmap = Bitmap(event.currentTarget.content)
		   		var bmd:BitmapData = bm.bitmapData;
		   		
		   		var s:Sprite=new Sprite();
		   		s.addChild(infowindow);
		   		s.buttonMode=true;
		   		
		   		var optionsMark:InfoWindowOptions = new InfoWindowOptions({
	                customContent: s,
	                strokeStyle: new StrokeStyle({thickness: 6, color:0xFFFFFF}),
	                customOffset: new Point(0, 10),
	                cornerRadius:0,
	                width: bmd.width,
	                height: bmd.height,
	                drawDefaultFrame: true					
				});  	 
				picturesInfoWindows[marker]=optionsMark;
				
		        marker.addEventListener(MapMouseEvent.CLICK, function(e:MapMouseEvent):void {
		      		marker.openInfoWindow(optionsMark);     
		        });      
        		
        	});
	       	
	        
	        picturesMarkers[photo]=marker;
		} 		
		
		private function createYoutubeMarker(ev:Event):void {
			
			var video:YoutubeVideoData=youtubeDict[ev.target.loader];
			var bmd:BitmapData = Bitmap(ev.currentTarget.content).bitmapData;
			var bmd2:BitmapData = new BitmapData(32,32)
			var m:Matrix = new Matrix();
			m.scale(0.43,0.43);
			bmd2.draw(bmd,m);		
			var sp:Sprite= new Sprite();
            sp.graphics.lineStyle(3,0x000000);
            sp.graphics.beginFill(0xFFFFFF,0);
            sp.graphics.drawRect(0,0,31,31);
            sp.graphics.endFill();
            bmd2.draw(sp);
			var iconBitmap:Bitmap= new Bitmap(bmd2);
			
			var latlng:LatLng = video.latlng;
	      	var photoUrl:String = video.link;
	      	
	       var marker:Marker = new Marker(latlng, new MarkerOptions(
	       	{tooltip: video.title,
	       	 draggable:false,
	       	 icon: iconBitmap}));		
	       	 
		   var optionsMark:InfoWindowOptions = new InfoWindowOptions({
	                customContent: youtubeSprite,
	                strokeStyle: new StrokeStyle({thickness: 6, color:0xFFFFFF}),
	                customOffset: new Point(0, 10),
	                cornerRadius:0,
	                width: 300,
	                height: 225,
	                drawDefaultFrame: true	   
	       });  	
	       
	       marker.addEventListener(MapMouseEvent.CLICK, function(e:MapMouseEvent):void {
		      		marker.openInfoWindow(optionsMark);  
		      		youtubeSprite.loadVideo(video.id);   
		      }); 	
		   marker.addEventListener(MapEvent.INFOWINDOW_CLOSED,function(e:MapEvent):void {
		   		youtubeSprite.unLoadVideo();
		   });
	        
	        youtubesMarkers[video]=marker;
		} 			
		

	}
}