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

//CONFIRMATION WINDOW
var confirm = Ti.UI.createWindow({
    url:'confirmation.js',
	backgroundColor:'#474747',
    tabBarHidden:true,
    navBarHidden:true	
}); 
var fakeTab = Titanium.UI.createTab({  
    title:'Foo',
    window:confirm
});
var tabFooGroup = Titanium.UI.createTabGroup();



//ABOUT WINDOW
var about = Ti.UI.createWindow({
    url:'about.js',
	backgroundColor:'#474747'
});

//INFO BUTTON
var infoButton = Titanium.UI.createButton({
	title:'i',
	top:10,
	right:10,
	height:25,
	width:25
});
infoButton.addEventListener('click', function()
{
	// open window and transiton with tab group
	about.open({transition:Ti.UI.iPhone.AnimationStyle.CURL_DOWN});		
});
home.add(infoButton);




//NUMBER OF BACHES
var loadingNumBaches = Titanium.UI.createActivityIndicator({
	top:50,
	height:50,
	width:10,
	style:Titanium.UI.iPhone.ActivityIndicatorStyle.BIG
});
home.add(loadingNumBaches);
loadingNumBaches.show();


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



//CAPTURE BUTTON
var captureButton = Titanium.UI.createButton({
	title:'+',
	backgroundImage: 'images/submitButton_off.png',
	backgroundSelectedImage: 'images/submitButton_on.png',
	backgroundDisabledImage: 'images/submitButton_disabled.png',
	top:235,
	height:170,
	width:170,
	backgroundColor:'#333333',
	color:'#FFD015',
	selectedColor:'#FFD015',
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

var startNumRequests=2;
var xhr = Titanium.Network.createHTTPClient();
function testInternetConnection() {
    if(!Titanium.Network.online) {
        var alertNoConnection = Titanium.UI.createAlertDialog({
            title:'Sin conexión',
            message: 'Necesitas tener conexión a Internet para usar esta aplicación',
            buttonNames: ['Reintentar']
        });
        alertNoConnection.addEventListener('click',function(e){
            testInternetConnection();
        });
        alertNoConnection.show();
    } else {
        xhr.open("GET","http://otrobache.com/api/OtroBache.getNumBaches");
        xhr.send();        
    }
}



//retrieve the number of baches
testInternetConnection();
xhr.onload = function()
{
    //loadingNumBaches.hide();
    home.add(statusLabel);
    
    //var resp =  eval('('+this.responseText+')');
    //if(resp.length==0) {
    //    numBachesLabel.text=0;
    //} else {
    numBachesLabel.text=this.responseText.replace(/\"/g,'');
    //}    
    home.add(numBachesLabel);
    subtextNumBachesLabel.text="baches ya reportados";
    captureButton.text="+";
    home.add(statusLabel);
    captureButton.addEventListener('click', onReportBacheClick);
    loadingNumBaches.hide();
};
xhr.onerror = function()
{
    if(startNumRequests>0) {
        xhr.open("GET","http://otrobache.com/api/OtroBache.getNumBaches");
        xhr.send();    
        startNumRequests--;    
    } else {
        testInternetConnection();        
    }

};


//open the app
home.open();
loadingNumBaches.show();



var req = Titanium.Network.createHTTPClient();
req.onload = function()
{
    captureButton.text="+";
    sendingBache.hide();        
    statusLabel.text="gracias! Si quieres puedes enviar mas.";
    numBachesLabel.text = (parseInt(numBachesLabel.text) + 1);
    captureButton.addEventListener('click', onReportBacheClick);
    //captureButton.enabled=true;
};
req.onerror = function()
{
    statusLabel.text="disculpa,ha ocurrido un error. Vuelve a intentarlo";
    statusLabel.color = "#9D2C2A";
    captureButton.text="+";
    sendingBache.hide();        
    captureButton.addEventListener('click', onReportBacheClick);        
    
};

function onReportBacheClick() {
    tabFooGroup.addTab(fakeTab);
    tabFooGroup.open({
        transition:Titanium.UI.iPhone.AnimationStyle.FLIP_FROM_LEFT
    });    
}

/*
function confirmBache() {
    Titanium.Geolocation.reverseGeocoder(latitude,longitude,function(evt) {
        
        var addr = evt.places[0].address;
        var confirmAlert = Titanium.UI.createAlertDialog({
            title:'Vas a enviar un bache para:',
            message: addr,
            buttonNames: ['OK','Cancelar']
        });        
    
        confirmAlert.addEventListener('click',function(e){
            if(e.index==0) {
                var url="http://otrobache.com/api/OtroBache.reportBache/"+latitude+"/"+longitude+"/iphone";
                req.open("GET",url);      
                req.send();                 
            } else {
                Titanium.UI.createAlertDialog({title:'OtroBache.com', message:'Pronto podrás introducir tu propia dirección manualmente, por el momento espera a que el GPS te de una dirección mas exacta.'}).show();
                statusLabel.text="Cancelado, vuelve a intentarlo.";
                statusLabel.color = "#9D2C2A";
                captureButton.addEventListener('click', addCaptureEvent);
            }
        });
        confirmAlert.show();
    });
}


*/






