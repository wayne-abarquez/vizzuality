var longitude;
var latitude;
var altitude;
var accuracy;
var timestamp;
var address;

var w= Titanium.UI.currentWindow;

var l1 = Titanium.UI.createLabel({
    text:'Buscando en el GPS...',
	top:20,
	right:10,
	left:10,    	
	width:262,
    height:'auto',
    width:'auto',
    color:'#FFF',
    font:{fontFamily:'Arial',fontSize:15,fontWeight:'bold'},
    textAlign:'left'
});
w.add(l1);

//Trying to get the best location...
/*
var loadingGps = Titanium.UI.createActivityIndicator({
	top:50,
	height:50,
	width:10,
	style:Titanium.UI.iPhone.ActivityIndicatorStyle.BIG
});
w.add(loadingGps);
loadingGps.show();
*/


// VERTEX
var vertex = Titanium.UI.createImageView({
	backgroundImage:'images/vertex_confirm.png',
	width:32,
	height:15,
	top:70,
	left:17,
	zIndex:100
	
});

w.add(vertex);

//MAP
var map = Titanium.Map.createView({
    top:70,
    bottom:100,
	mapType: Titanium.Map.STANDARD_TYPE,
	region: {latitude:47.84265762816538, longitude:-18.9404296875, latitudeDelta:12.2032166, longitudeDelta:30.7177734},
	animate:true,
	regionFit:true,
	userLocation:true
});

w.add(map);

var b = Ti.UI.createButton({
	backgroundImage:'images/bttn_ok_out.png',
	backgroundSelectedImage:'images/bttn_ok_selected.png',
	bottom:30,
	width:280,
	height:53});
b.addEventListener('click',function()
{
	w.close({transition:Ti.UI.iPhone.AnimationStyle.CURL_UP});
});
w.add(b);


var cancelButton = Ti.UI.createButton({
	backgroundImage:'images/bttn_cancel_out.png',
	backgroundSelectedImage:'images/bttn_cancel_selected.png',	
	bottom:10,
	width:55,
	height:14});

cancelButton.addEventListener('click',function()
{
	w.close({transition:Ti.UI.iPhone.AnimationStyle.CURL_UP});
});
w.add(cancelButton);



if (Titanium.Geolocation.locationServicesEnabled==false)
{
	Titanium.UI.createAlertDialog({title:'OtroBache.com', message:'Debes tener los servicios de Geolocalización activados.'}).show();
}
else
{
    Titanium.Geolocation.accuracy = Titanium.Geolocation.ACCURACY_BEST;
    Titanium.Geolocation.distanceFilter = 10;
    
	Titanium.Geolocation.addEventListener('location',function(e) {
		if (e.error)
		{
			return;
		}
		longitude = e.coords.longitude;
		latitude = e.coords.latitude;
		altitude = e.coords.altitude;
		accuracy = e.coords.accuracy;
		timestamp = new Date(e.coords.timestamp);
		Titanium.Geolocation.reverseGeocoder(latitude,longitude,function(evt)
		{
			var places = evt.places;
			address = places[0].address;
			l1.text = address;
			
            var location = Titanium.Map.createAnnotation({
            	latitude:latitude,
            	longitude:longitude,
            	title:address,
            	subtitle:'',
            	pincolor:Titanium.Map.ANNOTATION_RED,
            	animate:true,

            	myid:1 // CUSTOM ATTRIBUTE THAT IS PASSED INTO EVENT OBJECTS
            });			
    		map.addAnnotation(location);
    		annotationAdded=true;            
			
		});      
    });
}




