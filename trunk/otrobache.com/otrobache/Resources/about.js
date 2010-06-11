var w= Titanium.UI.currentWindow;

var l1 = Titanium.UI.createLabel({
    text:'SOBRE OTROBACHE.COM',
	top:30,
	left:20,
    height:'auto',
    width:'auto',
    color:'#CCC',
    font:{fontFamily:'Arial',fontSize:13,fontWeight:'bold'},
    textAlign:'left'
});
w.add(l1);

var l2 = Titanium.UI.createLabel({
    text:'¿Qué es otrobache.com?',
	top:66,
	left:20,
    height:'auto',
    width:'auto',
    color:'#FFCC00',
    font:{fontFamily:'Arial',fontSize:21,fontWeight:'bold'},
    textAlign:'left'
});
w.add(l2);    

var l3 = Titanium.UI.createLabel({
    text:'Un artículo de El País nos impulsó a hacer esto. En Madrid se realizan mas de 90 denuncias al día, sobre los socavones de la capital. Por desgracia estos datos no son públicos, y por eso queremos saber dónde y cuantos realmente hay.',
	top:96,
	right:20,
	left:20,    	
	width:242,
    height:'auto',
    width:'auto',
    color:'#CCC',
    font:{fontFamily:'Arial',fontSize:15},
    textAlign:'left'
});
w.add(l3);     

var l4 = Titanium.UI.createLabel({
    text:'¿Puedo ver un mapa de baches?',
	top:230,
	left:20,
	width:272,
    height:'auto',
    width:'auto',
    color:'#FFCC00',
    font:{fontFamily:'Arial',fontSize:21,fontWeight:'bold'},
    textAlign:'left'
});
w.add(l4);    



var l5 = Titanium.UI.createLabel({
    text:'Si, en www.otrobache.com hay disponible un mapa interactivo para analizar y visualizar toda la información que la gente nos reporta.',
	top:284,
	right:20,
	left:20,    	
	width:242,
    height:'auto',
    width:'auto',
    color:'#CCC',
    font:{fontFamily:'Arial',fontSize:15},
    textAlign:'left'
});
w.add(l5);    


// create close button for our window
var b = Ti.UI.createButton({
	backgroundImage:'images/bttn_back_out.png',
	backgroundSelectedImage:'images/bttn_back_selected.png',
	bottom:15,
	width:280,
	height:53});
	
b.addEventListener('click',function()
{
	w.close({transition:Ti.UI.iPhone.AnimationStyle.CURL_UP});
});
w.add(b);