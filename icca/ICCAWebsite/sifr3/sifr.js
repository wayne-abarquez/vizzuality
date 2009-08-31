/*=:project
    scalable Inman Flash Replacement (sIFR) version 3, revision 340

  =:file
    Copyright: 2006 Mark Wubben.
    Author: Mark Wubben, <http://novemberborn.net/>

  =:history
    * IFR: Shaun Inman
    * sIFR 1: Mike Davidson, Shaun Inman and Tomas Jogin
    * sIFR 2: Mike Davidson, Shaun Inman, Tomas Jogin and Mark Wubben

  =:license
    This software is licensed and provided under the CC-GNU LGPL.
    See <http://creativecommons.org/licenses/LGPL/2.1/>    
*/

var parseSelector=(function(){var _1=/\s*,\s*/;var _2=/\s*([\s>+~(),]|^|$)\s*/g;var _3=/([\s>+~,]|[^(]\+|^)([#.:@])/g;var _4=/^[^\s>+~]/;var _5=/[\s#.:>+~()@]|[^\s#.:>+~()@]+/g;function parseSelector(_6,_7){_7=_7||document.documentElement;var _8=_6.split(_1),_9=[];for(var i=0;i<_8.length;i++){var _b=[_7],_c=toStream(_8[i]);for(var j=0;j<_c.length;){var _e=_c[j++],_f=_c[j++],_10="";if(_c[j]=="("){while(_c[j++]!=")"&&j<_c.length){_10+=_c[j]}_10=_10.slice(0,-1)}_b=select(_b,_e,_f,_10)}_9=_9.concat(_b)}return _9}function toStream(_11){var _12=_11.replace(_2,"$1").replace(_3,"$1*$2");if(_4.test(_12)){_12=" "+_12}return _12.match(_5)||[]}function select(_13,_14,_15,_16){return (_17[_14])?_17[_14](_13,_15,_16):[]}var _18={toArray:function(_19){var a=[];for(var i=0;i<_19.length;i++){a.push(_19[i])}return a}};var dom={isTag:function(_1d,tag){return (tag=="*")||(tag.toLowerCase()==_1d.nodeName.toLowerCase())},previousSiblingElement:function(_1f){do{_1f=_1f.previousSibling}while(_1f&&_1f.nodeType!=1);return _1f},nextSiblingElement:function(_20){do{_20=_20.nextSibling}while(_20&&_20.nodeType!=1);return _20},hasClass:function(_21,_22){return (_22.className||"").match("(^|\\s)"+_21+"(\\s|$)")},getByTag:function(tag,_24){return _24.getElementsByTagName(tag)}};var _17={"#":function(_25,_26){for(var i=0;i<_25.length;i++){if(_25[i].getAttribute("id")==_26){return [_25[i]]}}return []}," ":function(_28,_29){var _2a=[];for(var i=0;i<_28.length;i++){_2a=_2a.concat(_18.toArray(dom.getByTag(_29,_28[i])))}return _2a},">":function(_2c,_2d){var _2e=[];for(var i=0,_30;i<_2c.length;i++){_30=_2c[i];for(var j=0,_32;j<_30.childNodes.length;j++){_32=_30.childNodes[j];if(_32.nodeType==1&&dom.isTag(_32,_2d)){_2e.push(_32)}}}return _2e},".":function(_33,_34){var _35=[];for(var i=0,_37;i<_33.length;i++){_37=_33[i];if(dom.hasClass([_34],_37)){_35.push(_37)}}return _35},":":function(_38,_39,_3a){return (pseudoClasses[_39])?pseudoClasses[_39](_38,_3a):[]}};parseSelector.selectors=_17;parseSelector.pseudoClasses={};parseSelector.util=_18;parseSelector.dom=dom;return parseSelector})();
var sIFR=new function(){var _3b=this;var _3c="sIFR-active";var _3d="sIFR-replaced";var _3e="sIFR-flash";var _3f="sIFR-ignore";var _40="sIFR-alternate";var _41="sIFR-class";var _42="sIFR-layout";var _43="sIFR-fixfocus";var _44="sIFR-dummy";var _45=6;var _46=126;var _47=8;var _48="SIFR-PREFETCHED";var _49=[];var _4a=5;var _4b="340";this.isActive=false;this.isEnabled=true;this.hideElements=true;this.preserveSingleWhitespace=false;this.fixWrap=true;this.fixHover=true;this.registerEvents=true;this.setPrefetchCookie=true;this.cookiePath="/";this.domains=[];this.fromLocal=false;this.forceClear=false;this.forceWidth=false;this.fitExactly=false;this.forceTextTransform=true;this.useDomLoaded=true;this.useStyleCheck=false;this.hasFlashClassSet=false;this.repaintOnResize=true;this.callbacks=[];var _4c=0;var _4d=false,_4e=false;var dom=new function(){var _50="http://www.w3.org/1999/xhtml";this.getBody=function(){var _51=document.getElementsByTagName("body");if(_51.length==1){return _51[0]}return null};this.addClass=function(_52,_53){if(_53){_53.className=((_53.className||"")==""?"":_53.className+" ")+_52}};this.removeClass=function(_54,_55){if(_55){_55.className=_55.className.replace(new RegExp("(^|\\s)"+_54+"(\\s|$)"),"").replace(/^\s+|(\s)\s+/g,"$1")}};this.hasClass=function(_56,_57){return new RegExp("(^|\\s)"+_56+"(\\s|$)").test(_57.className)};this.hasOneOfClassses=function(_58,_59){for(var i=0;i<_58.length;i++){if(this.hasClass(_58[i],_59)){return true}}return false};this.create=function(_5b){if(document.createElementNS){return document.createElementNS(_50,_5b)}return document.createElement(_5b)};this.setInnerHtml=function(_5c,_5d){if(ua.innerHtmlSupport){_5c.innerHTML=_5d}else{if(ua.xhtmlSupport){_5d=["<root xmlns=\"",_50,"\">",_5d,"</root>"].join("");var xml=(new DOMParser()).parseFromString(_5d,"text/xml");xml=document.importNode(xml.documentElement,true);while(_5c.firstChild){_5c.removeChild(_5c.firstChild)}while(xml.firstChild){_5c.appendChild(xml.firstChild)}}}};this.nodeFromHtml=function(_5f){var _60=this.create("div");_60.innerHTML=_5f;return _60.firstChild};this.getComputedStyle=function(_61,_62){var _63;if(document.defaultView&&document.defaultView.getComputedStyle){_63=document.defaultView.getComputedStyle(_61,null)[_62]}else{if(_61.currentStyle){_63=_61.currentStyle[_62]}}return _63||""};this.getStyleAsInt=function(_64,_65,_66){var _67=this.getComputedStyle(_64,_65);if(_66&&!/px$/.test(_67)){return 0}_67=parseInt(_67);return isNaN(_67)?0:_67};this.getWidthFromStyle=function(_68){var _69=this.getStyleAsInt(_68,"width",ua.ie);if(_69==0){var _6a=this.getStyleAsInt(_68,"paddingRight",true);var _6b=this.getStyleAsInt(_68,"paddingLeft",true);var _6c=this.getStyleAsInt(_68,"borderRightWidth",true);var _6d=this.getStyleAsInt(_68,"borderLeftWidth",true);_69=_68.offsetWidth-_6b-_6a-_6d-_6c}return _69};this.getZoom=function(){return _b0.zoom.getLatest()};this.blurElement=function(_6e){if(ua.gecko){_6e.blur();return}var _6f=dom.create("input");_6f.style.width="0px";_6f.style.height="0px";_6e.parentNode.appendChild(_6f);_6f.focus();_6f.blur();_6f.parentNode.removeChild(_6f)};this.getDimensions=function(_70){var _71=_70.offsetWidth;var _72=_70.offsetHeight;if(_71==0||_72==0){for(var i=0;i<_70.childNodes.length;i++){var _74=_70.childNodes[i];if(_74.nodeType!=1){continue}_71=Math.max(_71,_74.offsetWidth);_72=Math.max(_72,_74.offsetHeight)}}return {width:_71,height:_72}};this.contentIsLink=function(_75){var _76=false;for(var i=0;i<_75.childNodes.length;i++){var _78=_75.childNodes[i];if(_78.nodeType==3&&!_78.nodeValue.match(/^\s*$/)){return false}else{if(_78.nodeType!=1){continue}}var _79=_78.nodeName.toLowerCase()=="a";if(!_79){return false}else{_76=true}}return _76}};this.dom=dom;var ua=new function(){var ua=navigator.userAgent.toLowerCase();var _7c=(navigator.product||"").toLowerCase();this.macintosh=ua.indexOf("mac")>-1;this.windows=ua.indexOf("windows")>-1;this.quicktime=false;this.opera=ua.indexOf("opera")>-1;this.konqueror=_7c.indexOf("konqueror")>-1;this.ie=false/*@cc_on||true@*/;this.ieSupported=this.ie&&!/ppc|smartphone|iemobile|msie\s5\.5/.test(ua)/*@cc_on&&@_jscript_version>=5.5@*/;this.ieWin=this.ie&&this.windows/*@cc_on&&@_jscript_version>=5.1@*/;this.windows=this.windows&&(!this.ie||this.ieWin);this.ieMac=this.ie&&this.macintosh/*@cc_on&&@_jscript_version<5.1@*/;this.macintosh=this.macintosh&&(!this.ie||this.ieMac);this.safari=ua.indexOf("safari")>-1;this.webkit=ua.indexOf("applewebkit")>-1&&!this.konqueror;this.khtml=this.webkit||this.konqueror;this.gecko=!this.webkit&&_7c=="gecko";this.operaVersion=this.opera&&/.*opera(\s|\/)(\d+\.\d+)/.exec(ua)?parseFloat(RegExp.$2):0;this.webkitVersion=this.webkit&&/.*applewebkit\/(\d+).*/.exec(ua)?parseFloat(RegExp.$1):0;this.geckoBuildDate=this.gecko&&/.*gecko\/(\d{8}).*/.exec(ua)?parseFloat(RegExp.$1):0;this.konquerorMajor=this.konqueror&&/.*konqueror\/(\d).*/.exec(ua)?parseFloat(RegExp.$1):0;this.konquerorMinor=this.konqueror&&/.*khtml\/\d\.(\d).*/.exec(ua)?parseFloat(RegExp.$1):0;this.konquerorSmall=this.konqueror&&/.*khtml\/\d\.\d\.(\d).*/.exec(ua)?parseFloat(RegExp.$1):0;this.flashVersion=0;if(this.ieWin){var axo;var _7e=false;try{axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash.7")}catch(e){try{axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash.6");this.flashVersion=6;axo.AllowScriptAccess="always"}catch(e){_7e=this.flashVersion==6}if(!_7e){try{axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash")}catch(e){}}}if(!_7e&&axo){this.flashVersion=parseFloat(/([\d,?]+)/.exec(axo.GetVariable("$version"))[1].replace(/,/g,"."))}}else{if(navigator.plugins&&navigator.plugins["Shockwave Flash"]){var _7f=navigator.plugins["Shockwave Flash"];this.flashVersion=parseFloat(/(\d+\.?\d*)/.exec(_7f.description)[1]);var i=0;while(this.flashVersion>=_47&&i<navigator.mimeTypes.length){var _81=navigator.mimeTypes[i];if(_81.type=="application/x-shockwave-flash"&&_81.enabledPlugin.description.toLowerCase().indexOf("quicktime")>-1){this.flashVersion=0;this.quicktime=true}i++}}}this.flash=this.flashVersion>=_47;this.transparencySupport=this.macintosh||this.windows;this.computedStyleSupport=this.ie||document.defaultView&&document.defaultView.getComputedStyle&&(!this.gecko||this.geckoBuildDate>=20030624);this.xhtmlSupport=!!window.DOMParser&&!!document.importNode;try{var n=dom.create("span");if(!this.ieMac){n.innerHTML="x"}this.innerHtmlSupport=n.innerHTML=="x"}catch(e){this.innerHtmlSupport=false}this.zoomSupport=!!(this.opera&&document.documentElement);this.geckoXml=this.gecko&&(document.contentType||"").indexOf("xml")>-1;this.requiresPrefetch=this.ieWin||this.khtml;this.fixFocus=this.gecko&&this.windows&&this.geckoBuildDate>20061206;this.nativeDomLoaded=this.gecko||this.webkit&&this.webkitVersion>=525||this.konqueror&&this.konquerorMajor>3||this.opera;this.mustCheckStyle=this.khtml||this.opera;this.forcePageLoad=this.webkit&&this.webkit<523;this.supported=this.flash&&(!this.ie||this.ieSupported)&&(!this.opera)&&(!this.webkit||this.webkitVersion>=412)&&(!this.konqueror)&&this.computedStyleSupport&&(this.innerHtmlSupport||!this.khtml&&this.xhtmlSupport)&&(!this.gecko||this.geckoBuildDate>20040804)};this.ua=ua;var _83=new function(){var _84={leading:true,"margin-left":true,"margin-right":true,"text-indent":true};var _85=" ";function capitalize($){return $.toUpperCase()}this.normalize=function(str){if(_3b.preserveSingleWhitespace){return str.replace(/\s/g,_85)}return str.replace(/(\n|\r)+/g,_85).replace(/(\s)\s+/g,"$1").replace(/\xA0/,_85)};this.textTransform=function(_88,str){switch(_88){case "uppercase":str=str.toUpperCase();break;case "lowercase":str=str.toLowerCase();break;case "capitalize":var _8a=str;str=str.replace(/^\w|\s\w/g,capitalize);if(str.indexOf("function capitalize")!=-1){var _8b=_8a.replace(/(^|\s)(\w)/g,"$1$1$2$2").split(/^\w|\s\w/g);str="";for(var i=0;i<_8b.length;i++){str+=_8b[i].charAt(0).toUpperCase()+_8b[i].substring(1)}}break}return str};this.toHexString=function(str){if(typeof (str)!="string"||!str.charAt(0)=="#"||str.length!=4&&str.length!=7){return str}str=str.replace(/#/,"");if(str.length==3){str=str.replace(/(.)(.)(.)/,"$1$1$2$2$3$3")}return "0x"+str};this.toJson=function(obj){var _8f="";switch(typeof (obj)){case "string":_8f="\""+obj+"\"";break;case "number":case "boolean":_8f=obj.toString();break;case "object":_8f=[];for(var _90 in obj){if(obj[_90]==Object.prototype[_90]){continue}_8f.push("\""+_90+"\":"+_83.toJson(obj[_90]))}_8f="{"+_8f.join(",")+"}";break}return _8f};this.convertCssArg=function(arg){if(!arg){return {}}if(typeof (arg)=="object"){if(arg.constructor==Array){arg=arg.join("")}else{return arg}}var obj={};var _93=arg.split("}");for(var i=0;i<_93.length;i++){var $=_93[i].match(/([^\s{]+)\s*\{(.+)\s*;?\s*/);if(!$||$.length!=3){continue}if(!obj[$[1]]){obj[$[1]]={}}var _96=$[2].split(";");for(var j=0;j<_96.length;j++){var $2=_96[j].match(/\s*([^:\s]+)\s*\:\s*([^;]+)/);if(!$2||$2.length!=3){continue}obj[$[1]][$2[1]]=$2[2].replace(/\s+$/,"")}}return obj};this.extractFromCss=function(css,_9a,_9b,_9c){var _9d=null;if(css&&css[_9a]&&css[_9a][_9b]){_9d=css[_9a][_9b];if(_9c){delete css[_9a][_9b]}}return _9d};this.cssToString=function(arg){var css=[];for(var _a0 in arg){var _a1=arg[_a0];if(_a1==Object.prototype[_a0]){continue}css.push(_a0,"{");for(var _a2 in _a1){if(_a1[_a2]==Object.prototype[_a2]){continue}var _a3=_a1[_a2];if(_84[_a2]){_a3=parseInt(_a3,10)}css.push(_a2,":",_a3,";")}css.push("}")}return css.join("")};this.bind=function(_a4,_a5){return function(){_a4[_a5].apply(_a4,arguments)}};this.escape=function(str){return escape(str).replace(/\+/g,"%2B")};this.copyProperties=function(_a7,to){for(var _a9 in _a7){if(to[_a9]===undefined){to[_a9]=_a7[_a9]}}return to};this.domain=function(){var _aa="";try{_aa=document.domain}catch(e){}return _aa};this.domainMatches=function(_ab,_ac){if(_ac=="*"||_ac==_ab){return true}var _ad=_ac.lastIndexOf("*");if(_ad>-1){_ac=_ac.substr(_ad+1);var _ae=_ab.lastIndexOf(_ac);if(_ae>-1&&(_ae+_ac.length)==_ab.length){return true}}return false};this.uriEncode=function(s){return encodeURI(decodeURIComponent(s))}};this.util=_83;var _b0={};_b0.fragmentIdentifier=new function(){this.fix=true;var _b1;this.cache=function(){_b1=document.title};function doFix(){document.title=_b1}this.restore=function(){if(this.fix){setTimeout(doFix,0)}}};this.hacks=_b0;_b0.synchronizer=new function(){this.isBlocked=false;this.block=function(){this.isBlocked=true};this.unblock=function(){this.isBlocked=false;_b2.replaceAll()}};_b0.zoom=new function(){var _b3=100;this.getLatest=function(){return _b3};if(ua.zoomSupport&&ua.opera){var _b4=document.createElement("div");_b4.style.position="fixed";_b4.style.left="-65536px";_b4.style.top="0";_b4.style.height="100%";_b4.style.width="1px";_b4.style.zIndex="-32";document.documentElement.appendChild(_b4);function updateZoom(){if(!_b4){return}var _b5=window.innerHeight/_b4.offsetHeight;var _b6=Math.round(_b5*100)%10;if(_b6>5){_b5=Math.round(_b5*100)+10-_b6}else{_b5=Math.round(_b5*100)-_b6}_b3=isNaN(_b5)?100:_b5;_b0.synchronizer.unblock();document.documentElement.removeChild(_b4);_b4=null}_b0.synchronizer.block();setTimeout(updateZoom,54)}};_b0.pageLoad=new function(){var _b7=null;function pollLoad(){try{if(ua.ie||document.readyState!="loaded"&&document.readyState!="complete"){document.documentElement.doScroll("left")}}catch(e){return setTimeout(pollLoad,10)}afterDomLoad()}function afterDomLoad(){if(_3b.useStyleCheck){checkStyle()}else{if(!ua.mustCheckStyle){fire(null,true)}}}function checkStyle(){_b7=dom.create("div");_b7.className=_44;dom.getBody().appendChild(_b7);pollStyle()}function pollStyle(){if(dom.getComputedStyle(_b7,"marginLeft")=="42px"){afterStyle()}else{setTimeout(pollStyle,10)}}function afterStyle(){if(_b7&&_b7.parentNode){_b7.parentNode.removeChild(_b7)}_b7=null;fire(null,true)}function fire(evt,_b9){_3b.initialize(_b9);if(evt&&evt.type=="load"){if(document.removeEventListener){document.removeEventListener("DOMContentLoaded",fire,false)}if(window.removeEventListener){window.removeEventListener("load",fire,false)}}}this.attach=function(){if(window.addEventListener){window.addEventListener("load",fire,false)}else{window.attachEvent("onload",fire)}if(!_3b.useDomLoaded||ua.forcePageLoad){return}if(ua.nativeDomLoaded){document.addEventListener("DOMContentLoaded",afterDomLoad,false)}else{if(ua.ie||ua.khtml){pollLoad()}}}};this.errors={};var _ba={kwargs:[],replaceAll:function(_bb){for(var i=0;i<this.kwargs.length;i++){_3b.replace(this.kwargs[i])}if(!_bb){this.kwargs=[]}}};var _b2={kwargs:[],replaceAll:_ba.replaceAll};function isValidDomain(){if(_3b.domains.length==0){return true}var _bd=_83.domain();for(var i=0;i<_3b.domains.length;i++){var _bf=_3b.domains[i];if(_83.domainMatches(_bd,_bf)){return true}}return false}function isFile(){if(!_3b.fromLocal&&document.location.protocol=="file:"){if(_3b.debug){throw new Error(_3b.errors.isFile)}return true}return false}function resize(){var _c0=resize.viewport;resize.viewport={width:window.innerWidth||document.documentElement.clientWidth||dom.getBody().clientWidth,height:window.innerHeight||document.documentElement.clientHeight||dom.getBody().clientHeight};if(_c0&&resize.viewport.width==_c0.width&&resize.viewport.height==_c0.height){return}if(resize.timer){clearTimeout(resize.timer)}resize.timer=setTimeout(function(){delete resize.timer;for(var i=0;i<_3b.callbacks.length;i++){_3b.callbacks[i].resize()}},200)}this.activate=function(){if(!ua.supported||!this.isEnabled||this.isActive||!isValidDomain()||isFile()){return}if(arguments.length>0){this.prefetch.apply(this,arguments)}this.isActive=true;if(this.hideElements){this.setFlashClass()}_b0.fragmentIdentifier.fix=ua.ieWin&&_b0.fragmentIdentifier.fix&&window.location.hash!="";if(_b0.fragmentIdentifier.fix){_b0.fragmentIdentifier.cache()}if(!this.registerEvents){return}_b0.pageLoad.attach()};this.setFlashClass=function(){if(this.hasFlashClassSet){return}dom.addClass(_3c,dom.getBody()||document.documentElement);this.hasFlashClassSet=true};this.removeFlashClass=function(){if(!this.hasFlashClassSet){return}dom.removeClass(_3c,dom.getBody());dom.removeClass(_3c,document.documentElement);this.hasFlashClassSet=false};this.initialize=function(_c2){if(!this.isActive||!this.isEnabled){return}if(_4e){if(!_c2){_ba.replaceAll(false)}return}_4e=true;_ba.replaceAll(_c2);if(_3b.repaintOnResize){if(window.addEventListener){window.addEventListener("resize",resize,false)}else{window.attachEvent("onresize",resize)}}clearPrefetch()};function getSource(src){if(typeof (src)!="string"){if(src.src){src=src.src}if(typeof (src)!="string"){var _c4=[];for(var _c5 in src){if(src[_c5]!=Object.prototype[_c5]){_c4.push(_c5)}}_c4.sort().reverse();var _c6="";var i=-1;while(!_c6&&++i<_c4.length){if(parseFloat(_c4[i])<=ua.flashVersion){_c6=src[_c4[i]]}}src=_c6}}if(!src&&_3b.debug){throw new Error(_3b.errors.getSource)}if(ua.ie&&src.charAt(0)=="/"){src=window.location.toString().replace(/([^:]+)(:\/?\/?)([^\/]+).*/,"$1$2$3")+src}return src}this.prefetch=function(){if((!ua.requiresPrefetch&&!this.isActive)||!ua.supported||!this.isEnabled||!isValidDomain()){return}if(this.setPrefetchCookie&&new RegExp(";?"+_48+"=true;?").test(document.cookie)){return}try{_4d=true;if(ua.ieWin){prefetchIexplore(arguments)}else{prefetchLight(arguments)}if(this.setPrefetchCookie){document.cookie=_48+"=true;path="+this.cookiePath}}catch(e){if(_3b.debug){throw e}}};function prefetchIexplore(_c8){for(var i=0;i<_c8.length;i++){document.write("<script defer type=\"sifr/prefetch\" src=\""+getSource(_c8[i])+"\"></script>")}}function prefetchLight(_ca){for(var i=0;i<_ca.length;i++){new Image().src=getSource(_ca[i])}}function clearPrefetch(){if(!ua.ieWin||!_4d){return}try{var _cc=document.getElementsByTagName("script");for(var i=_cc.length-1;i>=0;i--){var _ce=_cc[i];if(_ce.type=="sifr/prefetch"){_ce.parentNode.removeChild(_ce)}}}catch(e){}}function getRatio(_cf,_d0){for(var i=0;i<_d0.length;i+=2){if(_cf<=_d0[i]){return _d0[i+1]}}return _d0[_d0.length-1]||1}function getFilters(obj){var _d3=[];for(var _d4 in obj){if(obj[_d4]==Object.prototype[_d4]){continue}var _d5=obj[_d4];_d4=[_d4.replace(/filter/i,"")+"Filter"];for(var _d6 in _d5){if(_d5[_d6]==Object.prototype[_d6]){continue}_d4.push(_d6+":"+_83.escape(_83.toJson(_83.toHexString(_d5[_d6]))))}_d3.push(_d4.join(","))}return _83.escape(_d3.join(";"))}function calculate(_d7){var _d8,_d9;if(!ua.ie){_d8=dom.getStyleAsInt(_d7,"lineHeight");_d9=Math.floor(dom.getStyleAsInt(_d7,"height")/_d8)}else{if(ua.ie){var _da=dom.getComputedStyle(_d7,"fontSize");if(_da.indexOf("px")>0){_d8=parseInt(_da)}else{var _db=_d7.innerHTML;_d7.style.visibility="visible";_d7.style.overflow="visible";_d7.style.position="static";_d7.style.zoom="normal";_d7.style.writingMode="lr-tb";_d7.style.width=_d7.style.height="auto";_d7.style.maxWidth=_d7.style.maxHeight=_d7.style.styleFloat="none";var _dc=_d7;var _dd=_d7.currentStyle.hasLayout;if(_dd){dom.setInnerHtml(_d7,"<div class=\""+_42+"\">X<br />X<br />X</div>");_dc=_d7.firstChild}else{dom.setInnerHtml(_d7,"X<br />X<br />X")}var _de=_dc.getClientRects();_d8=_de[1].bottom-_de[1].top;_d8=Math.ceil(_d8*0.8);if(_dd){dom.setInnerHtml(_d7,"<div class=\""+_42+"\">"+_db+"</div>");_dc=_d7.firstChild}else{dom.setInnerHtml(_d7,_db)}_de=_dc.getClientRects();_d9=_de.length;if(_dd){dom.setInnerHtml(_d7,_db)}_d7.style.visibility=_d7.style.width=_d7.style.height=_d7.style.maxWidth=_d7.style.maxHeight=_d7.style.overflow=_d7.style.styleFloat=_d7.style.position=_d7.style.zoom=_d7.style.writingMode=""}}}return {lineHeight:_d8,lines:_d9}}this.replace=function(_df,_e0){if(!ua.supported){return}if(_e0){_df=_83.copyProperties(_df,_e0)}if(!_4e){return _ba.kwargs.push(_df)}if(_b0.synchronizer.isBlocked){return _b2.kwargs.push(_df)}if(_3b.onReplacementStart){_3b.onReplacementStart(_df)}var _e1=_df.elements;if(!_e1&&parseSelector){_e1=parseSelector(_df.selector)}if(_e1.length==0){return}this.setFlashClass();var src=getSource(_df.src);var css=_83.convertCssArg(_df.css);var _e4=getFilters(_df.filters);var _e5=(_df.forceClear==null)?_3b.forceClear:_df.forceClear;var _e6=(_df.fitExactly==null)?_3b.fitExactly:_df.fitExactly;var _e7=_e6||(_df.forceWidth==null?_3b.forceWidth:_df.forceWidth);var _e8=!!(_df.preventWrap&&!_df.forceSingleLine);var _e9=parseInt(_83.extractFromCss(css,".sIFR-root","leading"))||0;var _ea=_83.extractFromCss(css,".sIFR-root","font-size",true)||0;var _eb=_83.extractFromCss(css,".sIFR-root","background-color",true)||"#FFFFFF";var _ec=_83.extractFromCss(css,".sIFR-root","kerning",true)||"";var _ed=_df.gridFitType||_83.extractFromCss(css,".sIFR-root","text-align")=="right"?"subpixel":"pixel";var _ee=_3b.forceTextTransform?_83.extractFromCss(css,".sIFR-root","text-transform",true)||"none":"none";var _ef=_83.extractFromCss(css,".sIFR-root","opacity",true)||"100";var _f0=_83.extractFromCss(css,".sIFR-root","cursor",true)||"default";var _f1=_df.pixelFont||false;var _f2=_df.ratios||_49;var _f3=parseInt(_df.tuneHeight)||0;var _f4=!!_df.onRelease||!!_df.onRollOver||!!_df.onRollOut;if(parseInt(_ea).toString()!=_ea&&_ea.indexOf("px")==-1){_ea=0}else{_ea=parseInt(_ea)}if(parseFloat(_ef)<1){_ef=100*parseFloat(_ef)}var _f5="";if(_e6){_83.extractFromCss(css,".sIFR-root","text-align",true)}if(!_df.modifyCss){_f5=_83.cssToString(css)}var _f6=_df.wmode||"";if(!_f6){if(_df.transparent){_f6="transparent"}else{if(_df.opaque){_f6="opaque"}}}if(_f6=="transparent"){if(!ua.transparencySupport){_f6="opaque"}else{_eb="transparent"}}for(var i=0;i<_e1.length;i++){var _f8=_e1[i];if(dom.hasOneOfClassses([_3d,_3f,_40],_f8)){continue}var _f9=dom.getDimensions(_f8);var _fa=_f9.height;var _fb=_f9.width;var _fc=dom.getComputedStyle(_f8,"display");if(!_fa||!_fb||_fc==null||_fc=="none"){continue}if(_e5&&ua.gecko){_f8.style.clear="both"}var _fd=null;if(_3b.fixWrap&&ua.ie&&_fc=="block"){_fd=_f8.innerHTML;dom.setInnerHtml(_f8,"X")}_fb=dom.getWidthFromStyle(_f8);if(_fd&&_3b.fixWrap&&ua.ie){dom.setInnerHtml(_f8,_fd)}var _fe,_ff;if(!_ea){var _100=calculate(_f8);_fe=Math.min(_46,Math.max(_45,_100.lineHeight));if(_f1){_fe=Math.max(8,8*Math.round(_fe/8))}_ff=_100.lines;if(isNaN(_ff)||!isFinite(_ff)||_ff==0){_ff=1}if(_ff>1&&_e9){_fa+=Math.round((_ff-1)*_e9)}}else{_fe=_ea;_ff=1}_fa=Math.round(_ff*_fe);if(_e5&&ua.gecko){_f8.style.clear=""}var _101=dom.create("span");_101.className=_40;var _102=_f8.cloneNode(true);_f8.parentNode.appendChild(_102);for(var j=0,l=_102.childNodes.length;j<l;j++){_101.appendChild(_102.childNodes[j].cloneNode(true))}if(_df.modifyContent){_df.modifyContent(_102,_df.selector)}if(_df.modifyCss){_f5=_df.modifyCss(css,_102,_df.selector)}var _105=_3b.fixHover&&dom.contentIsLink(_102);var _106=handleContent(_102,_ee,_df.uriEncode);_102.parentNode.removeChild(_102);if(_df.modifyContentString){_106.text=_df.modifyContentString(_106.text,_df.selector)}if(_106.text==""){continue}var vars=["content="+_83.escape(_106.text),"antialiastype="+(_df.antiAliasType||""),"width="+_fb,"height="+_fa,"fitexactly="+_e6,"tunewidth="+(_df.tuneWidth||0),"tuneheight="+_f3,"offsetleft="+(_df.offsetLeft||""),"offsettop="+(_df.offsetTop||""),"thickness="+(_df.thickness||""),"sharpness="+(_df.sharpness||""),"kerning="+_ec,"gridfittype="+_ed,"zoomsupport="+ua.zoomSupport,"flashfilters="+_e4,"opacity="+_ef,"blendmode="+(_df.blendMode||""),"size="+_fe,"zoom="+dom.getZoom(),"css="+_83.escape(_f5),"selectable="+(_df.selectable==null?"true":_df.selectable),"fixhover="+_105,"preventwrap="+_e8,"forcesingleline="+(_df.forceSingleLine===true),"link="+_83.escape(_106.primaryLink[0]||""),"target="+_83.escape(_106.primaryLink[1]||""),"events="+_f4,"cursor="+_f0,"version="+_4b];var _108=encodeVars(vars);var _109="sIFR_callback_"+_4c++;var _10a=new CallbackInfo(_109,vars,{onReplacement:_df.onReplacement,onRollOver:_df.onRollOver,onRollOut:_df.onRollOut,onRelease:_df.onRelease});window[_109+"_DoFSCommand"]=(function(_10b){return function(info,arg){_10b.handle(info,arg)}})(_10a);_101.setAttribute("id",_109+"_alternate");_fa=Math.round(_ff*getRatio(_fe,_f2)*_fe)+_4a+_f3;var _10e=_e7?_fb:"100%";var _10f;if(ua.ie){_10f=["<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" id=\"",_109,"\" sifr=\"true\" width=\"",_10e,"\" height=\"",_fa,"\" class=\"",_3e,"\">","<param name=\"movie\" value=\"",src,"\"></param>","<param name=\"flashvars\" value=\"",_108,"\"></param>","<param name=\"allowScriptAccess\" value=\"always\"></param>","<param name=\"quality\" value=\"best\"></param>","<param name=\"wmode\" value=\"",_f6,"\"></param>","<param name=\"bgcolor\" value=\"",_eb,"\"></param>","<param name=\"name\" value=\"",_109,"\"></param>","</object>","<scr","ipt event=FSCommand(info,args) for=",_109,">",_109,"_DoFSCommand(info, args);","</","script>"].join("")}else{_10f=["<embed type=\"application/x-shockwave-flash\" class=\""+_3e+"\" src=\"",src,"\" quality=\"best\" flashvars=\"",_108,"\" width=\"",_10e,"\" height=\"",_fa,"\" wmode=\"",_f6,"\" bgcolor=\"",_eb,"\" name=\"",_109,"\" id=\"",_109,"\" allowScriptAccess=\"always\" sifr=\"true\"></embed>"].join("")}var _110=ua.fixFocus&&_df.fixFocus?"<div class=\""+_43+"\">"+_10f+"</div>":_10f;dom.setInnerHtml(_f8,_110);_10a.html=_10f;_3b.callbacks.push(_10a);if(_df.selector){if(!_3b.callbacks[_df.selector]){_3b.callbacks[_df.selector]=[_10a]}else{_3b.callbacks[_df.selector].push(_10a)}}_f8.appendChild(_101);dom.addClass(_3d,_f8)}_b0.fragmentIdentifier.restore()};this.getCallbackByFlashElement=function(node){for(var i=0;i<_3b.callbacks.length;i++){if(_3b.callbacks[i].id==node.getAttribute("id")){return _3b.callbacks[i]}}};this.redraw=function(){for(var i=0;i<_3b.callbacks.length;i++){_3b.callbacks[i].resetMovie()}};function encodeVars(vars){return vars.join("&amp;").replace(/%/g,"%25")}function handleContent(_115,_116,_117){_117=_117||_83.uriEncode;var _118=[],_119=[],_11a=[];var _11b=_115.childNodes;var i=0;while(i<_11b.length){var node=_11b[i];if(node.nodeType==3){var text=_83.normalize(node.nodeValue);text=_83.textTransform(_116,text);text=text.replace(/</g,"&lt;");_119.push(text)}if(node.nodeType==1){var _11f=[];var _120=node.nodeName.toLowerCase();var _121=node.className||"";if(/\s+/.test(_121)){if(_121.indexOf(_41)>-1){_121=_121.match("(\\s|^)"+_41+"-([^\\s$]*)(\\s|$)")[2]}else{_121=_121.match(/^([^\s]+)/)[1]}}if(_121!=""){_11f.push("class=\""+_121+"\"")}if(_120=="a"){var href=_117(node.getAttribute("href")||"");var _123=node.getAttribute("target")||"";_11f.push("href=\""+href+"\"","target=\""+_123+"\"");if(_11a.length==0){_11a=[href,_123]}}_119.push("<"+_120+(_11f.length>0?" ":"")+_11f.join(" ")+">");if(node.hasChildNodes()){_118.push(i);i=0;_11b=node.childNodes;continue}else{if(!/^(br|img)$/i.test(node.nodeName)){_119.push("</",node.nodeName.toLowerCase(),">")}}}if(_118.length>0&&!node.nextSibling){do{i=_118.pop();_11b=node.parentNode.parentNode.childNodes;node=_11b[i];if(node){_119.push("</",node.nodeName.toLowerCase(),">")}}while(i==_11b.length-1&&_118.length>0)}i++}return {text:_119.join("").replace(/\n|\r/g,""),primaryLink:_11a}}function CallbackInfo(id,vars,_126){this.id=id;this.vars=vars;this._events=_126;this._firedReplacementEvent=!(_126.onReplacement!=null);this.html=""}CallbackInfo.prototype.getFlashElement=function(){return document.getElementById(this.id)};CallbackInfo.prototype.available=function(){var _127=this.getFlashElement();return _127&&_127.parentNode};CallbackInfo.prototype.handle=function(info,arg){if(!this.available()){return}if(/(FSCommand\:)?resize/.test(info)){var _12a=this.getFlashElement();var $=arg.split(/\:|,/);_12a.setAttribute($[0],$[1]);if($.length>2){_12a.style[$[2]]=$[3]+"px"}if(ua.khtml){var _12c=_12a.offsetHeight}if(!this._firedReplacementEvent){this._events.onReplacement(this);this._firedReplacementEvent=true}}else{if(/(FSCommand\:)?resetmovie/.test(info)){this.resetMovie()}else{if(/(FSCommand\:)?blur/.test(info)){dom.blurElement(this.getFlashElement())}else{if(/(FSCommand\:)?event/.test(info)){if(this._events[arg]){this._events[arg](this)}}else{if(this.debugHandler&&/(FSCommand\:)?debug/.test(info)){this.debugHandler(info,arg)}}}}}};CallbackInfo.prototype.call=function(type,_12e){if(!this.available()){return false}var _12f=this.getFlashElement();try{_12f.SetVariable("callbackType",type);_12f.SetVariable("callbackValue",_12e);_12f.SetVariable("callbackTrigger",true)}catch(e){return false}return true};CallbackInfo.prototype.replaceText=function(_130){var _131=_83.escape(_130);this.injectVars("content",_131);if(this.call("replacetext",_131)){dom.setInnerHtml(this.getAlternate(),_130);return true}return false};CallbackInfo.prototype.injectVars=function(name,_133){for(var i=0;i<this.vars.length;i++){if(this.vars[i].split("=")[0]==name){this.vars[i]=name+"="+_133;break}}this.html=this.html.replace(/(flashvars(=|\"\svalue=)\")[^\"]+/,"$1"+encodeVars(this.vars))};CallbackInfo.prototype.resetMovie=function(){if(!this.available()){return}var _135=this.getFlashElement();var node=_135.parentNode;node.replaceChild(dom.nodeFromHtml(this.html),_135)};CallbackInfo.prototype.resize=function(){if(!this.available()){return}var _137=this.getFlashElement();var _138=_137.parentNode;var _139=dom.getComputedStyle(_137,"width");var _13a=dom.getComputedStyle(_137,"height");_137.style.width="0px";_137.style.height="0px";_137.parentNode.style.minHeight=_13a;var _13b=this.getAlternate().childNodes;var _13c=[];for(var i=0;i<_13b.length;i++){var node=_13b[i].cloneNode(true);_13c.push(node);_138.appendChild(node)}var _13f=dom.getWidthFromStyle(_138);for(var i=0;i<_13c.length;i++){_138.removeChild(_13c[i])}_137.style.width=_139;_137.style.height=_13a;_137.parentNode.style.minHeight="";if(_13f!=parseInt(_139)){this.call("resize",_13f)}};CallbackInfo.prototype.changeCSS=function(css){css=_83.escape(_83.cssToString(_83.convertCssArg(css)));this.injectVars("css",css);return this.call("changecss",css)};CallbackInfo.prototype.getAlternate=function(){return document.getElementById(this.id+"_alternate")}};