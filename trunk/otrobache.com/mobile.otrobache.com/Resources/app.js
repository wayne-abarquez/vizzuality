var longitude;
var latitude;
var altitude;
var accuracy;
var timestamp;
var address;


// this sets the background color of the master UIView (when there are no windows/tab groups on it)
Titanium.UI.setBackgroundColor('#E5BA19');

//This is the deafult window
var home = Titanium.UI.createWindow({  
    backgroundImage:'images/homeBackground.png'
});

//NUMBER OF BACHES
var loadingNumBaches = Titanium.UI.createActivityIndicator({
	top:50,
	height:50,
	width:10,
	style:Titanium.UI.iPhone.ActivityIndicatorStyle.PLAIN
});

var sendingBache = Titanium.UI.createActivityIndicator({
	top:350,
	height:50,
	width:10,
	style:Titanium.UI.iPhone.ActivityIndicatorStyle.PLAIN
});

var numBachesLabel = Titanium.UI.createLabel({
    text:'',
	top:50,
    height:'auto',
    width:'auto',
    shadowColor:'#524301',
    shadowOffset:{x:0,y:-1},
    color:'#A18302',
    font:{fontFamily:'Arial',fontSize:71,fontWeight:'bold'},
    textAlign:'center'
});

var subtextNumBachesLabel = Titanium.UI.createLabel({
    text:'cargando datos...',
	top:120,
    height:'auto',
    width:'auto',
    color:'#A18302',
    font:{fontFamily:'Arial',fontSize:15,fontWeight:'bold'},
    textAlign:'center'
});
home.add(subtextNumBachesLabel);

//INFO BUTTON
var infoButton = Titanium.UI.createButton({
	title:'i',
	top:10,
	right:10,
	height:19,
	width:19
});
infoButton.addEventListener('click', function()
{
	var w = Ti.UI.createWindow({
		backgroundColor:'#474747'
	});

	// create close button for our window
	var b = Ti.UI.createButton({title:'Close',width:200,height:40});
	b.addEventListener('click',function()
	{
		w.close({transition:Ti.UI.iPhone.AnimationStyle.CURL_UP});
	})
	w.add(b);
	// open window and transiton with tab group
	w.open({transition:Ti.UI.iPhone.AnimationStyle.CURL_DOWN});		
});
home.add(infoButton);


//CAPTURE BUTTON
var captureButton = Titanium.UI.createButton({
	title:'',
	top:235,
	height:170,
	width:170,
	backgroundColor:'#333333',
	color:'#FFD015',
	selectedColor:'#FFD015',
	borderColor:'#333333',
    font:{fontFamily:'Arial',fontSize:140,fontColor:'#FFD015'},	
	borderRadius:85
});
home.add(captureButton);

//under the capture button text
var statusLabel = Titanium.UI.createLabel({
    text:'pulsa para reportar un bache aqui',
	bottom:25,
    height:'auto',
    width:'auto',
    color:'#A18302',
    font:{fontFamily:'Arial',fontSize:15,fontWeight:'bold'},
    textAlign:'center'
});



//retrieve the number of baches
var xhr = Titanium.Network.createHTTPClient();
xhr.onload = function()
{
    loadingNumBaches.hide();
    home.add(statusLabel);
    
    var resp =  eval('('+this.responseText+')');
    numBachesLabel.text=resp[0]['count()'];
    home.add(numBachesLabel);
    subtextNumBachesLabel.text="baches ya reportados";
    captureButton.text="+";
    home.add(statusLabel);
    captureButton.addEventListener('click', addCaptureEvent);
    
    
};
xhr.onerror = function()
{
    loadingNumBaches.hide();
	numBachesLabel.text="Desconocido";
	home.add(numBachesLabel);
};
xhr.open("GET","http://www.otrobache.com.check.geekisp.com/amfphp/json.php/OtroBache.getNumBaches");
xhr.send();

//open the app
home.open();
loadingNumBaches.show();





function addCaptureEvent() {
    statusLabel.text="enviando bache...";
    var req = Titanium.Network.createHTTPClient();
    req.onload = function()
    {
        captureButton.text="+";
        sendingBache.hide();        
        statusLabel.text="gracias! Si quieres puedes enviar mas.";
        numBachesLabel.text = (parseInt(numBachesLabel.text) + 1);
        captureButton.addEventListener('click', addCaptureEvent);
    };
    req.onerror = function()
    {
        statusLabel.text="disculpa,ha ocurrido un error.";
        captureButton.text="+";
        sendingBache.hide();        
        captureButton.addEventListener('click', addCaptureEvent);        
        
    };    
    var url="http://www.otrobache.com.check.geekisp.com/amfphp/json.php/OtroBache.reportBache/"+latitude+"/"+longitude+"/iphone/1/0/null";
    req.open("GET",url); 
    req.send();
    captureButton.text="";
    sendingBache.show();
    captureButton.removeEventListener('click', addCaptureEvent);
}








//init the Geocoding...
if (Titanium.Geolocation.locationServicesEnabled==false)
{
	Titanium.UI.createAlertDialog({title:'OtroBache.com', message:'Debes tener el GPS activado.'}).show();
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
		});      
    });
}




