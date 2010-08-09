//OVERLAYS
var baltic;
var baltic_over;
var antartic;
var north_pole;
var africa_1;
var oman;
var oceanic;
var brasil;
var cuba;
var newyork;
var chile;
var japan;
var africa_2;
var europe;
var mediterraneo;
var india;
var malasia;
var artic1;
var polygonOver;
var regions = []



	function addRegions() {


		$.ajax({
		  type: "GET",
		  url: 'regions.json.txt',
		  dataType: "json",
		  success: function(data) {
					console.log(data);
					for (var i=0; i<data.regions.length; i++) {
						var polylines_ = new Array();
						for (var j=0; j<data.regions[i].geometry.length; j++) {
							var obj = data.regions[i].geometry[j];
							obj.color = "#000000";
							obj.opacity = 0.2;
							obj.weight = 1;
							obj.numLevels = 18;
							obj.zoomFactor = 2;
							polylines_.push(obj);
						}
						
						var sea = new GPolygon.fromEncoded({
						  polylines: polylines_,
							fill: true,
						  color: "#000000",
						  opacity: 0.2,
						  outline: true,
							name: {name: data.regions[i].name,area:data.regions[i].area,pnumber:data.regions[i].num_pas,ppercent:data.regions[i].per_protected,id:data.regions[i].id}
						});
						map.addOverlay(sea);
						regions.push(sea);
						
						
						GEvent.addListener(sea, "mouseover", function(param) {
					    this.setFillStyle({color:"#FF6423",opacity:0.7});
							$('div#tooltip h4 a').text(this.name.name);
							$('div#tooltip div.areas_number p').text(this.name.pnumber);
							$('div#tooltip div.protected p').text(this.name.ppercent+'%');
							$('div#tooltip div.area p').html(this.name.area+'km<sup>2</sup>');
							var bounds = this.getBounds();
							var polygon_center = bounds.getCenter();
							var pixel = map.getCurrentMapType().getProjection().fromLatLngToPixel(map.fromDivPixelToLatLng(new GPoint(0,0),true),map.getZoom());
					        var offset=map.getCurrentMapType().getProjection().fromLatLngToPixel(polygon_center,map.getZoom());
					        var width =tooltip.clientWidth;
					        var height=tooltip.clientHeight;
					        var pos = new GControlPosition(G_ANCHOR_TOP_LEFT, new GSize(offset.x - pixel.x-20 - width/2, offset.y - pixel.y - 40 - height/2));
					        pos.apply(tooltip);
							$('div#tooltip').show();
						});
						
						
						
						GEvent.addListener(sea, "mouseout", function(latlng, index) {
							this.setFillStyle({color:"#000000",opacity:0.2});
							$('div#tooltip').hide();
						});
						
						GEvent.addListener(sea, "click", function(latlng, index) {
							window.location = 'region.html?id='+this.name.id;
						});
						
					}
			}
		});




		// 
		// 
		// 
		// 
		// //Baltic sea
		// 
		// 
		// baltic = new GPolygon.fromEncoded({
		//   polylines: [
		//     {points: "us}pKsjxgCpnw@|vXjn[x~lEjyb@}nr@fwcApqnBrzzAgl}Al_dBnihC~egAvn`GvjnCxvfFbafAzflAb}fArytAn~wEria@newEkq|H~tkBnabDk`o@|~eBhjCvvfFvdY{nyC|{`AoihCr_fApytAv|GxfsDbjbAgl}A|{y@tia@|hvB?l|nFnabD?vvfFf}V|flAfcnBf|i@xzCxvfFsqgDf|i@cwkB?cgxCznyCoopC?y~Gd|pCszrBria@g|}BrytA?f|i@`{qAidPrmo@h|i@mlCfl}Al}_D`tqGxs~AqvtL~o}Df|i@plHftcAvpi@my{Drc}Cly{Dnmt@yfsDtcaB~vXkwoBny{DjjhAf|i@~kf@}flA`lnAtqGr~CcldEpk~AhdP}ktA_|~Ibcq@etjDxgb@{~eBekcB{{eMqq_AwfzGj}CedwBlrnAi|i@czp@iq|HizRpa{@elp@?utR{~eBryH{v_CiuoE?kgmC~vX{coCgdwBoxLynyCbnh@{v_Crtv@_or@jiVel}A}er@sytAgghE}nr@goUnabDoxk@|nr@ibrBhdPmeiAei}LhkPqvtLo_s@idPizX}{eMc}kAtvmIox{A?hjbA~sxJ_|Opa{@nbv@rytAb`yAjfoQima@}vXqir@pqnBggCnabDwhuFhdPm}{EpqnBeimA{v_Cyiq@sa{@eam@{~eBuujFgqcLsbg@etjD_ayBria@ufTddwB_vl@sqGlr^ddwBuqP`deI",
		//      levels: "PMOMNNMMLIPOPNMPLPMONLNPMMNPLMNNNLPMMNMPPMOOOONOMMPNNNINHNMNPMNKNKNPMLLMPONLPMLMPNOLLMNMMPMPJLKMPMMOLP",
		//      color: "#000000",
		//      opacity: 0.2,
		//      weight: 1,
		//      numLevels: 18,
		//      zoomFactor: 2}],
		//   fill: true,
		//   color: "#000000",
		//   opacity: 0.2,
		//   outline: true,
		// 	name: {name: 'Baltic',area:'441,000',pnumber:'580',ppercent:'2.99',id:'0'}
		// });
		// map.addOverlay(baltic);
		// regions.push(baltic);
		// 
		// 
		// GEvent.addListener(baltic, "mouseover", function(param) {
		// 	    this.setFillStyle({color:"#FF6423",opacity:0.7});
		// 			$('div#tooltip h4 a').text(this.name.name);
		// 			$('div#tooltip div.areas_number p').text(this.name.pnumber);
		// 			$('div#tooltip div.protected p').text(this.name.ppercent+'%');
		// 			$('div#tooltip div.area p').html(this.name.area+'km<sup>2</sup>');
		// 			var bounds = this.getBounds();
		// 			var polygon_center = bounds.getCenter();
		// 			var pixel = map.getCurrentMapType().getProjection().fromLatLngToPixel(map.fromDivPixelToLatLng(new GPoint(0,0),true),map.getZoom());
		// 	        var offset=map.getCurrentMapType().getProjection().fromLatLngToPixel(polygon_center,map.getZoom());
		// 	        var width =tooltip.clientWidth;
		// 	        var height=tooltip.clientHeight;
		// 	        var pos = new GControlPosition(G_ANCHOR_TOP_LEFT, new GSize(offset.x - pixel.x-20 - width/2, offset.y - pixel.y - 40 - height/2));
		// 	        pos.apply(tooltip);
		// 			$('div#tooltip').show();
		// });
		// 
		// 
		// 
		// GEvent.addListener(baltic, "mouseout", function(latlng, index) {
		// 	this.setFillStyle({color:"#000000",opacity:0.2});
		// 	$('div#tooltip').hide();
		// 	  });
		// 
		// GEvent.addListener(baltic, "click", function(latlng, index) {
		// 	window.location = 'region.html?id='+this.name.id;
		// 	  });
		// 
		// 
		// 
		// //Antartic
		// 
		// antartic = new GPolygon.fromEncoded({polylines: [
		//     {points: "rqvoJ|l|{Pt|d}Aox~lEax`@yhuo_@}hg~Aikk|G?~rwg@er`^x~lE?h|ueLg}z|@x~lE?d`lkHffe^??hzafNdde|@ria@hitApvcjG",
		// 		     levels: "PPPPPPPPPPPPP",
		//      color: "#000000",
		//      opacity: 0.2,
		//      weight: 1,
		//      numLevels: 18,
		//      zoomFactor: 2}],
		//   fill: true,
		//   color: "#000000",
		//   opacity: 0.2,
		//   outline: true,
		// 	name: {name: 'Antartic',area:'35,688,000',pnumber:'40',ppercent:'0.19',id:'0'}
		// });
		// map.addOverlay(antartic);
		// regions.push(antartic);
		// 
		// GEvent.addListener(antartic, "mouseover", function(param) {
		// 	    this.setFillStyle({color:"#FF6423",opacity:0.7});
		// 			$('div#tooltip h4 a').text(this.name.name);
		// 			$('div#tooltip div.areas_number p').text(this.name.pnumber);
		// 			$('div#tooltip div.protected p').text(this.name.ppercent+'%');
		// 			$('div#tooltip div.area p').html(this.name.area+'km<sup>2</sup>');
		// 			var bounds = this.getBounds();
		// 			var polygon_center = bounds.getCenter();
		// 			var pixel = map.getCurrentMapType().getProjection().fromLatLngToPixel(map.fromDivPixelToLatLng(new GPoint(0,0),true),map.getZoom());
		// 	        var offset=map.getCurrentMapType().getProjection().fromLatLngToPixel(polygon_center,map.getZoom());
		// 	        var width =tooltip.clientWidth;
		// 	        var height=tooltip.clientHeight;
		// 	        var pos = new GControlPosition(G_ANCHOR_TOP_LEFT, new GSize(offset.x - pixel.x-820 - width/2, offset.y - pixel.y - 40 - height/2)); 
		// 	        pos.apply(tooltip);
		// 			$('div#tooltip').show();
		// });
		// 
		// 
		// 
		// GEvent.addListener(antartic, "mouseout", function(latlng, index) {
		// 	this.setFillStyle({color:"#000000",opacity:0.2});
		// 	$('div#tooltip').hide();
		// 	  });
		// 
		// GEvent.addListener(antartic, "click", function(latlng, index) {
		// 	window.location = 'region.html?id='+this.name.id;
		// 	  });
		// 	
		// 	
		// 	
		// 	
		// artic1 = new GPolygon.fromEncoded({polylines: [
		//     {points: "snh`HetboY~rJcgmxFy_jhAzfyz{@yoiCdi}L~cPn~aO_{iElnuPjvh@bd~Erc`DqytA~qGt~sHvzrC`tqGwiYv~lEyhgB{~eBsibE?garAwn`GfgGny{Db_~ClioFhmvErngJ~}hBoihCf_xCtn`G|`mBlybHdwcE|sxJ`suDhivIj_f@fi}Lzc_C~ceId}Hbd~EsukBqihCqp}Bq~zKchRiivIyskA?}bgBw~sHmsjCctjD_mzHetjDjib@vn`GdbaBpihCcxrBjioFdet@jivIgfbJ?fcvBnihC~qG`tqG}}wCvn`GyheEfdwBgpvE{nyC{ylAy~lEtfVcd~E}ldActjDq}Ucd~EqgsDftcAssoAqytAd`wA~ceIozc@`ikS}fsBbtjD_q{Abd~EucsDscaVniqAgtcAg|Eo~aOmttCny{D}j`@vn`G_fhBnihCue_CdypN{}bB{~eBu_j@gi}LocaF{clL_z[w~sHgtnAgtcAmzcC?_mDqhbdz@babBiyiKkcJin|Sx{ZycsOhk_BmioFjtgB?`i`Acd~Ecy\\aywQxxb@o~aOoz\\cd~EffyAoihCblbAwn`Gww]cd~E}xcCpytAyokA?z_h@o~aO?aywQtx}Lrpw`bAhhiFoihCakwAgdwBwf{@sia@hot@y~lE{lLkioFvtiDw~sHjfaB`tqG?vn`GnsqBqytAhs{BpytAejaAzs_N_svCbd~E?fyiKyfrCria@xyLbd~Eh}`Dsia@fwhCiorjcAy~T`tqGxowAidPxy\\my{DjjcGy~lEhxeBz~eBmjfA~ceIlpoEdnjZt`jB|nr@tncBhivIv{~BpytAodxCbd~E|rbApnnMpptAnihCw~mB?nrvBtngJ{ka@ly{Dnn~D|nr@|xvCdtjDxvpAoihCrvnDhdPlhfEv~lEdhsFidPf{bB~sxJd}uDidPhpr@`tqGzipE|nr@zcjD~ceI_qcMddwBoo{JfdwBay~GqytAqqaCcd~Eyfv@hdPcyu@mioFqlyMi~oUqp{A_deIkqlGqytAg|VkybHq_nAlioFjev@v~lEfs_DhdPtcGfdwBtl}DfyiK}{aAria@?fdwBsccD{~eBzeOl~aOvx}I`ikSlwlAhdPjrj@mioFrus@znyC_lYjybH|onA|sxJqyhB?_hmA~ceId`vAny{D_oPtxs^va}EvcsOv}uDlioFbssMnchYdnp@wn`GjpiDu~sHcteActjDhoxB_txJh~aGgtcAn_yLftcAlrqNtngJ",
		// 		     levels: "PPPNNPOONMPMOPNJOONLHOMMPMNOMMNPMNNOPNOPOPMMLONPNOLPNNPNMMPNNNOMPPNLONMOMLNMPOLOLPPOLOMNPMONPNNONPOPPMNOPNOMNOOMNNMPMNNONPOONNPKNPMMNNONPNONMPMOOPONOPMONNNOPMPMNNPNOP",
		//      color: "#000000",
		//      opacity: 0.2,
		//      weight: 1,
		//      numLevels: 18,
		//      zoomFactor: 2}],
		//   fill: true,
		//   color: "#000000",
		//   opacity: 0.2,
		//   outline: true,
		// 	name: {name: 'Artic',area:'20,111,000',pnumber:'128',ppercent:'1.93',id:'0'}
		// });
		// map.addOverlay(artic1);
		// regions.push(artic1);
		// 
		// GEvent.addListener(artic1, "mouseover", function(param) {
		// 	    this.setFillStyle({color:"#FF6423",opacity:0.7});
		// 			$('div#tooltip h4 a').text(this.name.name);
		// 			$('div#tooltip div.areas_number p').text(this.name.pnumber);
		// 			$('div#tooltip div.protected p').text(this.name.ppercent+'%');
		// 			$('div#tooltip div.area p').html(this.name.area+'km<sup>2</sup>');
		// 			var bounds = this.getBounds();
		// 			var polygon_center = bounds.getCenter();
		// 			var pixel = map.getCurrentMapType().getProjection().fromLatLngToPixel(map.fromDivPixelToLatLng(new GPoint(0,0),true),map.getZoom());
		// 	        var offset=map.getCurrentMapType().getProjection().fromLatLngToPixel(polygon_center,map.getZoom());
		// 	        var width =tooltip.clientWidth;
		// 	        var height=tooltip.clientHeight;
		// 	        var pos = new GControlPosition(G_ANCHOR_TOP_LEFT, new GSize(offset.x - pixel.x-20 - width/2, offset.y - pixel.y - 40 - height/2)); 
		// 	        pos.apply(tooltip);
		// 			$('div#tooltip').show();
		// });
		// 
		// 
		// 
		// GEvent.addListener(artic1, "mouseout", function(latlng, index) {
		// 	this.setFillStyle({color:"#000000",opacity:0.2});
		// 	$('div#tooltip').hide();
		// 	  });
		// 
		// GEvent.addListener(artic1, "click", function(latlng, index) {
		// 	window.location = 'region.html?id='+this.name.id;
		// 	  });	
		// 	
		// 
		// 
		// //North Pole
		// 
		// north_pole = new GPolygon.fromEncoded({
		//   polylines: [
		//     {points: "swcqLh|vxVqcUy~h{^?g}uu@f~jEo~aOnmlHria@h|pB|hrV~fnCzs_NfqwB`tqGsa_DbtjDkkfDctjDcwd@di}LnclEhtcAxkcFqihC|wLr~zKjsnBhivIfs|CftcApr_EvsfQywsCr~zKcpnGria@}_~Ddi}LfcpD{}kb@gcpDk~hRuy|CpihCe_oI|}d_@kefAvh`]iwiCnihCcel@x}re@`~pBxhyYn`mFp~zK`buGfi}Lxp}F|sxJnqnFv~sH~dzFt~sHhjxCbidPzf}F`tqG~foP?_~nV`e|pCbtfm@poeuClobPhgbjAozvFz~eB}y{Et~sHqkaBbidPiayF`tqGcq~E?ytsQxsfQnwlK`tqGhxjB|sxJ_r|BnihCaw_Ex~lEgt{EgtcAw}sHxhyYlvn@r~zKuz^|sxJjooNsia@rxbFlioFh|eEkivItw}HgtcAbwtEfi}LhjoU?i`tC`tqG}cdF|sxJ{m|J?qqRn~aOmi|Jfsia@?r~zK_`tHria@sveAt~sHsogKgtcA{mqHysfQm`zCsia@g}fCcidPsn}DmioFc|lCd~vXl_M{hrVk_nBaikS{{`Do~aOelmG`tqGykrCw~lEmn~Af~oUppgD?zvwIt~sHqnnEv~sH}roBitcAqnhA~sxJc`_Bdi}LkyaDria@ekJh~oU~}hFu~sHbvpEz~eB`zq@jivItxKrsmT~re@|sxJ_se@x}re@jqr@z}kb@cyiEsia@g_d@p~zKo}wKbhjp@",
		// 		     levels: "PHOPPNLPOOPNPMNNPNOPPOPNNPNPKLMJOPOPPNPNOONNPOPHOPOMPOPOPPPKOPNNOOPPNNNPPNMPOPPNPNOJOOPOPLLMMPOMP",
		//      color: "#000000",
		//      opacity: 0.2,
		//      weight: 1,
		//      numLevels: 18,
		//      zoomFactor: 2}],
		//   fill: true,
		//   color: "#000000",
		//   opacity: 0.2,
		//   outline: true,
		// 	name: {name: 'Artic',area:'20,111,000',pnumber:'128',ppercent:'1.93',id:'0'}
		// });
		// 
		// map.addOverlay(north_pole);
		// regions.push(north_pole);
		// 
		// GEvent.addListener(north_pole, "mouseover", function(param) {
		// 	    this.setFillStyle({color:"#FF6423",opacity:0.7});
		// 			$('div#tooltip h4 a').text(this.name.name);
		// 			$('div#tooltip div.areas_number p').text(this.name.pnumber);
		// 			$('div#tooltip div.protected p').text(this.name.ppercent+'%');
		// 			$('div#tooltip div.area p').html(this.name.area+'km<sup>2</sup>');
		// 			var bounds = this.getBounds();
		// 			var polygon_center = bounds.getCenter();
		// 			var pixel = map.getCurrentMapType().getProjection().fromLatLngToPixel(map.fromDivPixelToLatLng(new GPoint(0,0),true),map.getZoom());
		// 	        var offset=map.getCurrentMapType().getProjection().fromLatLngToPixel(polygon_center,map.getZoom());
		// 	        var width =tooltip.clientWidth;
		// 	        var height=tooltip.clientHeight;
		// 	        var pos = new GControlPosition(G_ANCHOR_TOP_LEFT, new GSize(offset.x - pixel.x-20 - width/2, offset.y - pixel.y - 40 - height/2)); 
		// 	        pos.apply(tooltip);
		// 			$('div#tooltip').show();
		// });
		// 
		// 
		// 
		// GEvent.addListener(north_pole, "mouseout", function(latlng, index) {
		// 	this.setFillStyle({color:"#000000",opacity:0.2});
		// 	$('div#tooltip').hide();
		// 	  });
		// 
		// GEvent.addListener(north_pole, "click", function(latlng, index) {
		// 	window.location = 'region.html?id='+this.name.id;
		// 	  });
		// 
		// 
		// // Africa 1
		// 
		// africa_1 = new GPolygon.fromEncoded({
		//   polylines: [
		//     {points: "mbx{Edspd@xk|eBzwh`Fb|xbCegimAvsjjEsia@jvv@undrDxkctAria@?wcwzDmxv\\sia@?{}kb@mehlBria@ar]bidPvjiKdtjDj}xAddwBtubJlioFxjkN~x~Tzwi@`tqG?xcsOb|zCdi}LmzsAvn`Gw{yHdtjD_oaCitcAa|fUtngJigdEx~lE}cxSly{DuwjH}nr@ysdZvsfQo`jL?sk_MoihCu~mIwn`GuhgD?}|rJxnyC}vwCqytAw|fSjybHkzgRn~aOsrjDftcAgioFqytAke~TgtcAa}gC`d~Exir@xcsOkxcIbd~EggcAdtjD|`P|sxJripGfncWqkcAhivIpkcA|clLjptA`tqGkptA~ceIkreJ|clLsikEt~sHgavKbtjDyc|F`tqGwcgDx~lEa~|HpytA}ufEdtjDkobBedwBixnQetjDgzbGddwBui`D}nr@qloBfdwBimnFuia@evjIoihCuzkCmioF}{sI}nr@kb{AetjDqzfD{~eBupeD}sxJckjHadeIempDhdP{knIgtcAwhoG{s_NyavKynyC",
		//      levels: "PPPPPPPPPPPNMOPLNNPNNNONOPNNNPNNOMPMPNONPNONLNPLONKNNPNONNOMPOOMNMOMOOP",
		//      color: "#000000",
		//      opacity: 0.2,
		//      weight: 1,
		//      numLevels: 18,
		//      zoomFactor: 2}],
		//   fill: true,
		//   color: "#000000",
		//   opacity: 0.2,
		//   outline: true,
		// 	name: {name: 'West Africa',area:'32,328,000',pnumber:'78',ppercent:'0.09',id:'0'}
		// });
		// 
		// map.addOverlay(africa_1);
		// regions.push(africa_1);
		// 
		// GEvent.addListener(africa_1, "mouseover", function(param) {
		// 	    this.setFillStyle({color:"#FF6423",opacity:0.7});
		// 			$('div#tooltip h4 a').text(this.name.name);
		// 			$('div#tooltip div.areas_number p').text(this.name.pnumber);
		// 			$('div#tooltip div.protected p').text(this.name.ppercent+'%');
		// 			$('div#tooltip div.area p').html(this.name.area+'km<sup>2</sup>');
		// 			var bounds = this.getBounds();
		// 			var polygon_center = bounds.getCenter();
		// 			var pixel = map.getCurrentMapType().getProjection().fromLatLngToPixel(map.fromDivPixelToLatLng(new GPoint(0,0),true),map.getZoom());
		// 	        var offset=map.getCurrentMapType().getProjection().fromLatLngToPixel(polygon_center,map.getZoom());
		// 	        var width =tooltip.clientWidth;
		// 	        var height=tooltip.clientHeight;
		// 	        var pos = new GControlPosition(G_ANCHOR_TOP_LEFT, new GSize(offset.x - pixel.x-20 - width/2, offset.y - pixel.y - 40 - height/2)); 
		// 	        pos.apply(tooltip);
		// 			$('div#tooltip').show();
		// });
		// 
		// 
		// 
		// GEvent.addListener(africa_1, "mouseout", function(latlng, index) {
		// 	this.setFillStyle({color:"#000000",opacity:0.2});
		// 	$('div#tooltip').hide();
		// 	  });
		// 
		// GEvent.addListener(africa_1, "click", function(latlng, index) {
		// 	window.location = 'region.html?id='+this.name.id;
		// 	  });
		// 
		// 
		// //OMAN - YEMEN
		// 
		// oman = new GPolygon.fromEncoded({
		//   polylines: [
		//     {points: "yzovDu`weEnliA|nr@x|cHoy{D|`jUsngJ~plBedwBbuNf|i@nctDg|i@|heEc|wFtt~Csia@djjLi|i@zarDwvfFdhnPmquEwniAsia@`azAsa{@jjaAoabDhfoKgqcLvjtBsia@j~h@pqnBn{cBgl}Av~oDoy{DbmG{~eBix{Ay~lEdv`@qqnBcplBoy{Dxt`@qytAmgXgl}Agt`@gtcAzfX}flAiai@}flAclG{v_Cc`sAoihC|kq@qqnBor`@g~akBk}jgAdtjDgbn@d|pCyj{C|nr@sqNfl}AiwlA??fapJkwFdtjD~`^pvtL_erCnchYez}Ezv_CehNzv_Crpt@tqGrie@z~eB{iNpytApvt@~nr@cv]nabDeteE`tqGq|jA`d~EonjLvn`GtgU|~eBkciApqnBvuaA?bv\\pytAwzMfl}Ab|pAsia@jyk@ftcAnls@}nr@h}}GqihC`gvDa|wF|cqChdPvaxE{nyCsx_F}vXzuF{v_Cl}xDhdPnbeA|nr@lhtBoihCotN}~eBq}m@gyiKiztA_wXsyuGu~sH|nyC_wXzigHynyCtueAkybH|cdFcd~Ebp~JvvfFybWrytAhgo@pa{@dxiGhdPtn_@ny{Dt|aDpytAhdGzfsDpvbDftcAreGxfsDznx@pytA_fG|~eBvgqAxfsDd_cC?jhbB~ceIxyjBjaiGlbkBfdwBba|Blv{Ot|zApqnBbn`@zv_CxbXpihCwkcBpqnBapoLddwB{`fFtqGsxjRrfaK}{oBpytA?pytAqnoB|flAua_A|nr@qyeG?mckGpihCsimAxfsDyvaEftcA{twOfyiKocNznyCdlrAtqG}yjApytAy_cAnihC{myHfdwB",
		//      levels: "PNLMNMNOKPNNNLMONOJPMMMMMKMMLLOMPONMMPJLOONOMLMNPMOOMNMLPMNLNNNPNOLNPIOMPMONPNMNONNNPMLNNNKMMMMJPNMNNMMIONPNMONNLOP",
		//      color: "#000000",
		//      opacity: 0.2,
		//      weight: 1,
		//      numLevels: 18,
		//      zoomFactor: 2}],
		//   fill: true,
		//   color: "#000000",
		//   opacity: 0.2,
		//   outline: true,
		// 	name: {name: 'Arabian seas',area:'3,034,000',pnumber:'51',ppercent:'0.60',id:'0'}
		// });
		// 
		// map.addOverlay(oman);
		// regions.push(oman);
		// 
		// GEvent.addListener(oman, "mouseover", function(param) {
		// 	    this.setFillStyle({color:"#FF6423",opacity:0.7});
		// 			$('div#tooltip h4 a').text(this.name.name);
		// 			$('div#tooltip div.areas_number p').text(this.name.pnumber);
		// 			$('div#tooltip div.protected p').text(this.name.ppercent+'%');
		// 			$('div#tooltip div.area p').html(this.name.area+'km<sup>2</sup>');
		// 			var bounds = this.getBounds();
		// 			var polygon_center = bounds.getCenter();
		// 			var pixel = map.getCurrentMapType().getProjection().fromLatLngToPixel(map.fromDivPixelToLatLng(new GPoint(0,0),true),map.getZoom());
		// 	        var offset=map.getCurrentMapType().getProjection().fromLatLngToPixel(polygon_center,map.getZoom());
		// 	        var width =tooltip.clientWidth;
		// 	        var height=tooltip.clientHeight;
		// 	        var pos = new GControlPosition(G_ANCHOR_TOP_LEFT, new GSize(offset.x - pixel.x-20 - width/2, offset.y - pixel.y - 40 - height/2)); 
		// 	        pos.apply(tooltip);
		// 			$('div#tooltip').show();
		// });
		// 
		// 
		// 
		// GEvent.addListener(oman, "mouseout", function(latlng, index) {
		// 	this.setFillStyle({color:"#000000",opacity:0.2});
		// 	$('div#tooltip').hide();
		// 	  });
		// 
		// GEvent.addListener(oman, "click", function(latlng, index) {
		// 	window.location = 'region.html?id='+this.name.id;
		// 	  });
		// 
		// 
		// 
		// //Australia
		// 
		// australia = new GPolygon.fromEncoded({
		//   polylines: [
		//     {points: "`hfcA{ddgNrt_jG?lzHqaniLdzf]idP~qG`kw~|@uxjwEhdP?}d~w}@aowU`tqGyqgSfsia@uh`]p~zKcxaK??zedwB|yeCr~zKyyO`lzeG",
		//      levels: "PPPPPPPPPNPNNP",
		//      color: "#000000",
		//      opacity: 0.2,
		//      weight: 1,
		//      numLevels: 18,
		//      zoomFactor: 2},{points: "vn}|Cy~ve\\xneFria@l`gH{v_Cr`tUnquErszDlquEf_mInihCn{mDpqnBxnbIh|i@bnpAzclL`nlCznyCdxYd|pCr`oAidPaq_DnabDe~oAfl}ArzmDjybHm{|Ax~lE?ly{Dy|t@fl}AewErytA_mtCd|pCutjDhdPouwCpqnB_|o@i|i@t|h@`|wF{cdCqa{@_nsCftcA~qoDra{@la[btjDaheAsia@raMgtcAiqzCuqGm|iB{~eBqgdD|nr@ruyDpqnBb`x@ddwBlbmA~nr@f}oBf|i@kgi@nabD}ji@g|i@}t{EnihCur_ArytA}uyB|vXq`y@z~eBp`\\~nr@uugApytA~yTddwBmnlBbd~Edqc@|clL|wzBtvmIggFvvfFdkhCtvmIpfyDbtjD_cF`ikSlmzEfyiK?~ceIyflClioFcifCra{@?sytAkn_AgtcAcfyG}vX{ngGbtjDef|FtqGar`Q~ceI~aVetjDmo{AsqG{bgGxfsDs{oNqihClfnB}nr@gevB{flAk~~F}clLe`GcldEkxwBoy{DfcOe|pCejg@e|pCsno@{nyCmskHkioFqlzChdP}kbC{v_Cv|cEgdwBs}yB}nr@u{iBh|i@?e|pCsmrB_wXo}yA?y`qGqnnM`tOoihCr~vEe|pCk`y@}nr@|mh@yvfFcay@sqGscy@f|i@}q~D}nr@wnuCyfsDee{A}nr@qdXwn`G{k{AgtcAifXnihCudsA}flAl~aFw{lP}cbAgdwBpalB}nr@ebbAqytA|uy@gl}AptuCz~eBll`@htcAxtjHpqnB|reEc|wFbop@oabDzqyAqqnB`px@oabDrxqB_lkHm|fHoy{DgkxSi|i@cnmHqytAplGsa{@`|kGynyCbvvJgl}Awg`@e|pCts{B{v_CniaI}nr@ry{D{v_CjpjD?`_yBsa{@vyqGeawMpmoBsa{@t{}Hgl}Agrn@qytA`{NgdwBhplEg|i@hi}AqihCbm|Ju~sH",
		// 		     levels: "PNONNLNPNMNPJOOMLLPNMMOONPNPMMMNPMMKPNMLMOMMMMPMMONNNNPMOMNONMNNOPPNMOMMMIPMNOOMNNKOPNNMPLMOLNONNPNNNMPLMPMLLIPNMPMNONOMMMPOLOMONMP",
		// 		     color: "#0000ff",
		// 		     opacity: 0.7,
		// 		     weight: 3,
		// 		     numLevels: 18,
		// 		     zoomFactor: 2}],
		//   fill: true,
		//   color: "#000000",
		//   opacity: 0.2,
		//   outline: true,
		// 	name: {name: 'Australia/New Zealand',area:'34,313,000',pnumber:'394',ppercent:'1.74',id:'0'}
		// });
		// 
		// map.addOverlay(australia);
		// regions.push(australia);
		// 
		// GEvent.addListener(australia, "mouseover", function(param) {
		// 	    this.setFillStyle({color:"#FF6423",opacity:0.7});
		// 			$('div#tooltip h4 a').text(this.name.name);
		// 			$('div#tooltip div.areas_number p').text(this.name.pnumber);
		// 			$('div#tooltip div.protected p').text(this.name.ppercent+'%');
		// 			$('div#tooltip div.area p').html(this.name.area+'km<sup>2</sup>');
		// 			var bounds = this.getBounds();
		// 			var polygon_center = bounds.getCenter();
		// 			var pixel = map.getCurrentMapType().getProjection().fromLatLngToPixel(map.fromDivPixelToLatLng(new GPoint(0,0),true),map.getZoom());
		// 	        var offset=map.getCurrentMapType().getProjection().fromLatLngToPixel(polygon_center,map.getZoom());
		// 	        var width =tooltip.clientWidth;
		// 	        var height=tooltip.clientHeight;
		// 	        var pos = new GControlPosition(G_ANCHOR_TOP_LEFT, new GSize(offset.x - pixel.x-20 - width/2, offset.y - pixel.y - 40 - height/2)); 
		// 	        pos.apply(tooltip);
		// 			$('div#tooltip').show();
		// });
		// 
		// 
		// 
		// GEvent.addListener(australia, "mouseout", function(latlng, index) {
		// 	this.setFillStyle({color:"#000000",opacity:0.2});
		// 	$('div#tooltip').hide();
		// 	  });
		// 
		// GEvent.addListener(australia, "click", function(latlng, index) {
		// 	window.location = 'region.html?id='+this.name.id;
		// 	  });
		// 
		// 
		// 
		// 
		// //OCEANIC
		// 
		// oceanic = new GPolygon.fromEncoded({
		//   polylines: [
		//     {points: "rmutCh}qk`@txjwE??czolN}hxzCtia@_pa}EdquaBgg`gB~muhEid_eA||j_A?_tpv~@dz}l@tlprFtk~Qlra{@ftvfB?fb}LgroaAhedP?lgzKuh`]`vrHria@kaPwn`GpogC}~eBdba@pihC`gvB?vagCoy{DzwhDedwB`pfCmioFtwiE{nyC{zOznyCylsAfyiKscyDny{DmsjEpihC{`gChivIz`gCbd~E`uyDria@pwbAz~eBqwbAjybHvsmG|nr@|v`@qstWbzmH?xjc_@gyiKdngRgsia@v~gVkybH|rNr_mw}@",
		//      levels: "PPPPPPPPOPPPPPOONNOMMMPKOLNPNMOOPPNPPPP",
		//      color: "#000000",
		//      opacity: 0.2,
		//      weight: 1,
		//      numLevels: 18,
		//      zoomFactor: 2}],
		//   fill: true,
		//   color: "#000000",
		//   opacity: 0.2,
		//   outline: true,
		// 	name: {name: 'North and South Pacific',area:'87,180,000',pnumber:'255',ppercent:'0.91',id:'0'}
		// });
		// 
		// map.addOverlay(oceanic);
		// regions.push(oceanic);
		// 
		// GEvent.addListener(oceanic, "mouseover", function(param) {
		// 	    this.setFillStyle({color:"#FF6423",opacity:0.7});
		// 			$('div#tooltip h4 a').text(this.name.name);
		// 			$('div#tooltip div.areas_number p').text(this.name.pnumber);
		// 			$('div#tooltip div.protected p').text(this.name.ppercent+'%');
		// 			$('div#tooltip div.area p').html(this.name.area+'km<sup>2</sup>');
		// 			var bounds = this.getBounds();
		// 			var polygon_center = bounds.getCenter();
		// 			var pixel = map.getCurrentMapType().getProjection().fromLatLngToPixel(map.fromDivPixelToLatLng(new GPoint(0,0),true),map.getZoom());
		// 	        var offset=map.getCurrentMapType().getProjection().fromLatLngToPixel(polygon_center,map.getZoom());
		// 	        var width =tooltip.clientWidth;
		// 	        var height=tooltip.clientHeight;
		// 	        var pos = new GControlPosition(G_ANCHOR_TOP_LEFT, new GSize(offset.x - pixel.x-20 - width/2, offset.y - pixel.y - 40 - height/2)); 
		// 	        pos.apply(tooltip);
		// 			$('div#tooltip').show();
		// });
		// 
		// 
		// 
		// GEvent.addListener(oceanic, "mouseout", function(latlng, index) {
		// 	this.setFillStyle({color:"#000000",opacity:0.2});
		// 	$('div#tooltip').hide();
		// 	  });
		// 
		// GEvent.addListener(oceanic, "click", function(latlng, index) {
		// 	window.location = 'region.html?id='+this.name.id;
		// 	  });
		// 
		// 
		// 
		// 
		// //BRASIL
		// 
		// brasil = new GPolygon.fromEncoded({
		//   polylines: [
		//     {points: "{mxYt_o{H?gfhjBjtvg@qstWvsjjEsia@jvv@undrDnoytA??xjnlHv}s{@?leP~pchBa{lWria@?q~zKw{|F?gypFbidPazbNx~lE}smD}~eBuekGmioFo`jHiivIm_lC~sxJa|eD}~eBqnhDu~sHspnG{~eBqxuCmioF}o~Fx~lE}yX{s_Nuf~Lsia@?kivIgkeCm~aO_vfIy~lEiybL|sxJlzsAei}L?_txJk{qJq~zKuzmOetjDswdKwsfQ}xgO?_}vHiivIa{|Bs~zKkd~@{s_Nqq}Cw~lEop~Esia@sg`FmioFw}dKsia@iw~\\}~eBiehEatqGeujFgtcAy|gDmioFeenGy~lEkufS|~eBelcA|sxJ{fsHfi}Laha@|sxJydhChivIr{eB`tqGmojDgtcAyqqG~hkSgioFfi}LocoUhivI",
		// 		     levels: "PPPPPPPPPPOPOPLMPPNNMPPPOMPPPMPOOOOPMNPNOJPNNMPPNOMNPOLPP",
		// 		     color: "#000000",
		// 		     opacity: 0.2,
		// 		     weight: 1,
		// 		     numLevels: 18,
		// 		     zoomFactor: 2}],
		//   fill: true,
		//   color: "#000000",
		//   opacity: 0.2,
		//   outline: true,
		// 	name: {name: 'South Atlantic',area:'15,543,000',pnumber:'113',ppercent:'0.18',id:'0'}
		// });
		// 
		// map.addOverlay(brasil);
		// regions.push(brasil);
		// 
		// GEvent.addListener(brasil, "mouseover", function(param) {
		// 	    this.setFillStyle({color:"#FF6423",opacity:0.7});
		// 			$('div#tooltip h4 a').text(this.name.name);
		// 			$('div#tooltip div.areas_number p').text(this.name.pnumber);
		// 			$('div#tooltip div.protected p').text(this.name.ppercent+'%');
		// 			$('div#tooltip div.area p').html(this.name.area+'km<sup>2</sup>');
		// 			var bounds = this.getBounds();
		// 			var polygon_center = bounds.getCenter();
		// 			var pixel = map.getCurrentMapType().getProjection().fromLatLngToPixel(map.fromDivPixelToLatLng(new GPoint(0,0),true),map.getZoom());
		// 	        var offset=map.getCurrentMapType().getProjection().fromLatLngToPixel(polygon_center,map.getZoom());
		// 	        var width =tooltip.clientWidth;
		// 	        var height=tooltip.clientHeight;
		// 	        var pos = new GControlPosition(G_ANCHOR_TOP_LEFT, new GSize(offset.x - pixel.x-20 - width/2, offset.y - pixel.y - 40 - height/2)); 
		// 	        pos.apply(tooltip);
		// 			$('div#tooltip').show();
		// });
		// 
		// 
		// 
		// GEvent.addListener(brasil, "mouseout", function(latlng, index) {
		// 	this.setFillStyle({color:"#000000",opacity:0.2});
		// 	$('div#tooltip').hide();
		// 	  });
		// 
		// GEvent.addListener(brasil, "click", function(latlng, index) {
		// 	window.location = 'region.html?id='+this.name.id;
		// 	  });
		// 
		// 
		// 
		// 
		// //CUBA
		// 
		// cuba = new GPolygon.fromEncoded({
		//   polylines: [
		//     {points: "imetDz|o}Pf{pEtngJfgl@v~lEh`rFjdPncaJria@pcdPz~eBbkaU_deIxhpAu~sH{gOycsOmicLatqGi`_EiivIj|^adeIlooFhdP~{qGhtcArkeInihCxhgHfdwB?gi}Lkpp@_deIdcvEmioFlpmJidPt~lH|nr@vczEoihCb{kFwn`G?atqGsyq@mioFtvsA_deImzq@mybHm{aJad~Ek_dBkivIkdvCatqGt|rAynyC|kvCnihC}ibAgyiKj`dBmioFxqq@u~sHwzO_ikS`bdKonuPdtnOe~vXtca@onnMje}E}clLhmcActjDubPeaicBacpyA|wdu@sdy_B`~agEdlsAjioF~ciDfdwBnbx@x~lEpe`CbtjDpvx@znyCdzsGbtjD`{iWw~lE`|aIsia@t}iD|nr@igwFxnyCkwfEx~lEsxuDpytAyg_GidP{l~EjybHhrbDfdwBalqDbd~EvxMjybHbyMt~sH~|uBnihCftvBny{DayxAlioFez\\zclL",
		// 		     levels: "PMPILPPMPONPLNIPLOPMOMPLNMPOMPOONMNPKONKPPPPNMMLNPNMPMOMNPOOFOKOMP",
		// 		     color: "#000000",
		// 		     opacity: 0.2,
		// 		     weight: 1,
		// 		     numLevels: 18,
		// 		     zoomFactor: 2}],
		//   fill: true,
		//   color: "#000000",
		//   opacity: 0.2,
		//   outline: true,
		// 	name: {name: 'Wider Caribbean',area:'11,690,000',pnumber:'580',ppercent:'1.43',id:'0'}
		// });
		// 
		// map.addOverlay(cuba);
		// regions.push(cuba);
		// 
		// GEvent.addListener(cuba, "mouseover", function(param) {
		// 	    this.setFillStyle({color:"#FF6423",opacity:0.7});
		// 			$('div#tooltip h4 a').text(this.name.name);
		// 			$('div#tooltip div.areas_number p').text(this.name.pnumber);
		// 			$('div#tooltip div.protected p').text(this.name.ppercent+'%');
		// 			$('div#tooltip div.area p').html(this.name.area+'km<sup>2</sup>');
		// 			var bounds = this.getBounds();
		// 			var polygon_center = bounds.getCenter();
		// 			var pixel = map.getCurrentMapType().getProjection().fromLatLngToPixel(map.fromDivPixelToLatLng(new GPoint(0,0),true),map.getZoom());
		// 	        var offset=map.getCurrentMapType().getProjection().fromLatLngToPixel(polygon_center,map.getZoom());
		// 	        var width =tooltip.clientWidth;
		// 	        var height=tooltip.clientHeight;
		// 	        var pos = new GControlPosition(G_ANCHOR_TOP_LEFT, new GSize(offset.x - pixel.x - width/2, offset.y - pixel.y - 40 - height/2)); 
		// 	        pos.apply(tooltip);
		// 			$('div#tooltip').show();
		// });
		// 
		// 
		// 
		// GEvent.addListener(cuba, "mouseout", function(latlng, index) {
		// 	this.setFillStyle({color:"#000000",opacity:0.2});
		// 	$('div#tooltip').hide();
		// 	  });
		// 
		// GEvent.addListener(cuba, "click", function(latlng, index) {
		// 	window.location = 'region.html?id='+this.name.id;
		// 	  });
		// 
		// 
		// 
		// 
		// 
		// //NEW YORK
		// 
		// newyork = new GPolygon.fromEncoded({
		//   polylines: [
		//     {points: "ctznIjqkfGlknwEhdPksv~AjcsgE{ciRpytAc`oF{~eBjmrHsytA{{bFgtcAmnpCmioFm{uDsia@cfsB_ikS_uqDddwB{}`FoihCou|Ekn|SyntDqnnMhpkBsia@`k`BjybHpgfCria@b|uA{~eBoudEwn`GgvlBcidPctcCmioFsk`FhtcAji}Av~lE`anCfdwByq~ArngJi}qAoy{Dgjb@jybHcu|ApihC}|rBgtcAyoa@t~sHxoa@u~sHqkhC}~eB{xdB|~eBknUvn`Gl_l@jybH|htHn~aOy_iHcd~Eq|xAungJii{DoihCc|Twmfg@o`gDujmGkcWoy{D_`GqihCwzvActjDmdT}nr@o}x@}j_AclwOi_|jA",
		// 		     levels: "PPPNPPNNPPNPKPNONONMPOMPOOONNPONPMOPPNOOMJNILNP",
		// 		     color: "#000000",
		// 		     opacity: 0.2,
		// 		     weight: 1,
		// 		     numLevels: 18,
		// 		     zoomFactor: 2}],
		//   fill: true,
		//   color: "#000000",
		//   opacity: 0.2,
		//   outline: true,
		// 	name: {name: 'North West Atlantic',area:'6,804,000',pnumber:'590',ppercent:'0.17',id:'0'}
		// });
		// 
		// map.addOverlay(newyork);
		// regions.push(newyork);
		// 
		// GEvent.addListener(newyork, "mouseover", function(param) {
		// 	    this.setFillStyle({color:"#FF6423",opacity:0.7});
		// 			$('div#tooltip h4 a').text(this.name.name);
		// 			$('div#tooltip div.areas_number p').text(this.name.pnumber);
		// 			$('div#tooltip div.protected p').text(this.name.ppercent+'%');
		// 			$('div#tooltip div.area p').html(this.name.area+'km<sup>2</sup>');
		// 			var bounds = this.getBounds();
		// 			var polygon_center = bounds.getCenter();
		// 			var pixel = map.getCurrentMapType().getProjection().fromLatLngToPixel(map.fromDivPixelToLatLng(new GPoint(0,0),true),map.getZoom());
		// 	        var offset=map.getCurrentMapType().getProjection().fromLatLngToPixel(polygon_center,map.getZoom());
		// 	        var width =tooltip.clientWidth;
		// 	        var height=tooltip.clientHeight;
		// 	        var pos = new GControlPosition(G_ANCHOR_TOP_LEFT, new GSize(offset.x - pixel.x - width/2, offset.y - pixel.y -50 - height/2)); 
		// 	        pos.apply(tooltip);
		// 			$('div#tooltip').show();
		// });
		// 
		// 
		// 
		// GEvent.addListener(newyork, "mouseout", function(latlng, index) {
		// 	this.setFillStyle({color:"#000000",opacity:0.2});
		// 	$('div#tooltip').hide();
		// 	  });
		// 
		// GEvent.addListener(newyork, "click", function(latlng, index) {
		// 	window.location = 'region.html?id='+this.name.id;
		// 	  });
		// 
		// 
		// 
		// 
		// //CHILE
		// 
		// chile = new GPolygon.fromEncoded({
		//   polylines: [
		//     {points: "_vdyArbeqP~~gF{s_NjxaAq~zKrsqKu~sH|{nH?lmzMos{ZackEw~lEu|bAatqGxoyLw~sHhaiStia@zkxJxs_N`qfQx~lEhrrWria@xyqHiivI|hzb@k~hRdqjHitcAfpfF}sxJljgIcidP|cfQy~lEne}KpihCtlnSsia@nddObtjDzvqP|~eBzju_@lioFvfnL?pyjVv~lElvpPx~lElpjFoihC`twDv~lEdt~X{~eBv|rH}sxJptaJgsia@pb`X}~eB?ldfdDsst{Ctia@iee|EdquaBkckmAm{soB",
		// 		     levels: "PNPNPPNPPOOOPONOIPPNNMLNOLOOOPNPPPPPP",
		// 		     color: "#000000",
		// 		     opacity: 0.2,
		// 		     weight: 1,
		// 		     numLevels: 18,
		// 		     zoomFactor: 2}],
		//   fill: true,
		//   color: "#000000",
		//   opacity: 0.2,
		//   outline: true,
		// 	name: {name: 'South East Pacific',area:'19,161,000',pnumber:'62',ppercent:'0.82',id:'0'}
		// });
		// map.addOverlay(chile);
		// regions.push(chile);
		// 
		// GEvent.addListener(chile, "mouseover", function(param) {
		// 	    this.setFillStyle({color:"#FF6423",opacity:0.7});
		// 			$('div#tooltip h4 a').text(this.name.name);
		// 			$('div#tooltip div.areas_number p').text(this.name.pnumber);
		// 			$('div#tooltip div.protected p').text(this.name.ppercent+'%');
		// 			$('div#tooltip div.area p').html(this.name.area+'km<sup>2</sup>');
		// 			var bounds = this.getBounds();
		// 			var polygon_center = bounds.getCenter();
		// 			var pixel = map.getCurrentMapType().getProjection().fromLatLngToPixel(map.fromDivPixelToLatLng(new GPoint(0,0),true),map.getZoom());
		// 	        var offset=map.getCurrentMapType().getProjection().fromLatLngToPixel(polygon_center,map.getZoom());
		// 	        var width =tooltip.clientWidth;
		// 	        var height=tooltip.clientHeight;
		// 	        var pos = new GControlPosition(G_ANCHOR_TOP_LEFT, new GSize(offset.x - pixel.x - width/2, offset.y - pixel.y - height/2)); 
		// 	        pos.apply(tooltip);
		// 			$('div#tooltip').show();
		// });
		// 
		// 
		// 
		// GEvent.addListener(chile, "mouseout", function(latlng, index) {
		// 	this.setFillStyle({color:"#000000",opacity:0.2});
		// 	$('div#tooltip').hide();
		// 	  });
		// 
		// GEvent.addListener(chile, "click", function(latlng, index) {
		// 	window.location = 'region.html?id='+this.name.id;
		// 	  });
		// 
		// 
		// 
		// 
		// //JAPAN-EEUU
		// 
		// japan = new GPolygon.fromEncoded({
		//   polylines: [
		//     {points: "ujyiJddvpYbokUuh`]tpbEs~zKf{iLwsfQhgsIiivIsyIlioFhkzLuczR`xaIkybH`kuUpytAxgsRidPd}f`@kn|SxitEmnuPl{lT{clLhrjHiivItggC`d~EvwoIo~aO`ufGqytAruhIq~zKw|{Dsia@_e_YvsfQw`iI~ceIuw`JddwBxdtBq~zKj}~KgdwBjeai@u}yh@`~nI?nu`EgtcAhbtHaywQ~jiK}mx`@coqAkybH|xhHycsObukmAdfomBglqgBrxwiEqjpdA~lw}@wxMu~kt~@tn}m@t||pFxfoR`}c|@vdOl{soBnstIt~sHctpAhyiKarbFftcAsjqK}nr@cynAenjZctlGostWudua@uxs^aukMqytAay`Q|sxJ}i~Bny{Dw~vJ}clLy|gC{nyCsyg@v~sHnclB~ceIa}oDria@ek}AlioFqlwB?s_hIkn|SzhzAmy{DhgjDly{DxrqCsia@spuGaywQlwjDoy{Dv{gEznyCn|xBs~zKxneQ|~eBqraBmnuPieyO}nr@u`{IrngJye_NmnuPwbiEiivIlscBwn`Gg_{D_txJyweU}x~T?wsfQ{sJuwvfFqcgiAxfyz{@",
		// 		     levels: "PMMOOOMPMPPONPONPPNMNPOOPMPMONPPPPPOPPPPMPNPPONPGPNONPNPONPOPOOPPOPMOOOPGPP",
		// 		     color: "#000000",
		// 		     opacity: 0.2,
		// 		     weight: 1,
		// 		     numLevels: 18,
		// 		     zoomFactor: 2},{points: "kz{sGuse_ZhtgKrqGpnKb|wFnfiCftcAz`~DidPvm`D}nr@jql@zv_CheaB?bngAgl}AthrHnabDfjmFhapJoijAf|i@bjZ|~eBlieGd|pCtyh@bidPp|xEt~sH?pytAlutEjybHdlzDsia@ivToabDbj}AftcA~rzEtqGgdaAy~lEorxJe|pCfqx@ynyCy|fAoquEwyfCw~lEl~bBqabDopfCctjDgmeC_wXvii@wn`Gym~@{v_C}dp@oabDm{gBa|wFgzbCf|i@{_bJgtcA{t`@edwBephFqqnBe~eJbldEymeCfdwBkzdAuqGtiEedwBitK}~eBtmqBufzGg{vD}~eByvoBiapJq}uAfl}AcvgBgtcAz~nAd|pCiokGvk`R",
		// 				     levels: "PONOLNNMNPNMONOMLPNOMPNPNLNOMONKKPMONPLMPKMONPNONP",
		// 				     color: "#0000ff",
		// 				     opacity: 0.2,
		// 				     weight: 1,
		// 				     numLevels: 18,
		// 				     zoomFactor: 2}],
		//   fill: true,
		//   color: "#000000",
		//   opacity: 0.2,
		//   outline: true,
		// 	name: {name: 'North West Pacific',area:'17,885,000',pnumber:'212',ppercent:'0.46',id:'0'}
		// });
		// map.addOverlay(japan);
		// regions.push(japan);
		// 
		// GEvent.addListener(japan, "mouseover", function(param) {
		// 	    this.setFillStyle({color:"#FF6423",opacity:0.7});
		// 			$('div#tooltip h4 a').text(this.name.name);
		// 			$('div#tooltip div.areas_number p').text(this.name.pnumber);
		// 			$('div#tooltip div.protected p').text(this.name.ppercent+'%');
		// 			$('div#tooltip div.area p').html(this.name.area+'km<sup>2</sup>');
		// 			var bounds = this.getBounds();
		// 			var polygon_center = bounds.getCenter();
		// 			var pixel = map.getCurrentMapType().getProjection().fromLatLngToPixel(map.fromDivPixelToLatLng(new GPoint(0,0),true),map.getZoom());
		// 	        var offset=map.getCurrentMapType().getProjection().fromLatLngToPixel(polygon_center,map.getZoom());
		// 	        var width =tooltip.clientWidth;
		// 	        var height=tooltip.clientHeight;
		// 	        var pos = new GControlPosition(G_ANCHOR_TOP_LEFT, new GSize(offset.x - pixel.x - width/2, offset.y - pixel.y - 90 - height/2)); 
		// 	        pos.apply(tooltip);
		// 			$('div#tooltip').show();
		// });
		// 
		// 
		// 
		// GEvent.addListener(japan, "mouseout", function(latlng, index) {
		// 	this.setFillStyle({color:"#000000",opacity:0.2});
		// 	$('div#tooltip').hide();
		// 
		// 	  });
		// 
		// GEvent.addListener(japan, "click", function(latlng, index) {
		// 	window.location = 'region.html?id='+this.name.id;
		// 	  });
		// 
		// 
		// 
		// 
		// //AFRICA 2
		// 
		// africa_2 = new GPolygon.fromEncoded({
		//   polylines: [
		//     {points: "p~cdDk}kzElehlBidP{cKeafkGarjmEhdPmu`@fb|_A{wpiCria@uxO|pjkBdujFftcAjuzEria@jknGznyC`}uRrngJhi|L~sxJfnxJxcsO|lnMzclLjpjDpihCdmr@ddwBn_vQlioFdqxCqihC|jkE~nr@nagLsytA~nsAoihCptfN}nr@~xmJidPbxeEftcAvavFlioFxmrCp~zKpkrDfdwBh|aFjioF}cOfdwBzz_NqihCrayKsia@rpgGn~aOjrhDhdPrgjBuczR",
		// 		     levels: "PPPPPPPKNFPNNKMOPNMNNKPMONLNPMPPOP",
		// 		     color: "#000000",
		// 		     opacity: 0.2,
		// 		     weight: 1,
		// 		     numLevels: 18,
		// 		     zoomFactor: 2},{points: "nsr~AafsxGuo}DmioF{vbBqqnB{ssB?t_X}flAmu}C{v_C_ocBftcA}uy@e|pCtqfD{~eBn{iN{~eBvcbBria@a{yApytAfa`@h|i@|n}Esia@xnip@l~aO|~bChyiKyskBlquEwp}OxfsDcjnDqa{@a`hGy~lEwn~MpqnB}r}FqqnBghjB_deI",
		// 				     levels: "PJNMMNNPMPNMONPPNPMONOP",
		// 				     color: "#000000",
		// 				     opacity: 0.2,
		// 				     weight: 1,
		// 				     numLevels: 18,
		// 				     zoomFactor: 2}],
		//   fill: true,
		//   color: "#000000",
		//   opacity: 0.2,
		//   outline: true,
		// 	name: {name: 'East Africa',area:'22,221,000',pnumber:'94',ppercent:'0.09',id:'0'}
		// });
		// map.addOverlay(africa_2);
		// regions.push(africa_2);
		// 
		// 
		// GEvent.addListener(africa_2, "mouseover", function(param) {
		// 	    this.setFillStyle({color:"#FF6423",opacity:0.7});
		// 			$('div#tooltip h4 a').text(this.name.name);
		// 			$('div#tooltip div.areas_number p').text(this.name.pnumber);
		// 			$('div#tooltip div.protected p').text(this.name.ppercent+'%');
		// 			$('div#tooltip div.area p').html(this.name.area+'km<sup>2</sup>');
		// 			var bounds = this.getBounds();
		// 			var polygon_center = bounds.getCenter();
		// 			var pixel = map.getCurrentMapType().getProjection().fromLatLngToPixel(map.fromDivPixelToLatLng(new GPoint(0,0),true),map.getZoom());
		// 	        var offset=map.getCurrentMapType().getProjection().fromLatLngToPixel(polygon_center,map.getZoom());
		// 	        var width =tooltip.clientWidth;
		// 	        var height=tooltip.clientHeight;
		// 	        var pos = new GControlPosition(G_ANCHOR_TOP_LEFT, new GSize(offset.x - pixel.x - width/2, offset.y - pixel.y -50 - height/2)); 
		// 	        pos.apply(tooltip);
		// 			$('div#tooltip').show();
		// });
		// 
		// 
		// 
		// GEvent.addListener(africa_2, "mouseout", function(latlng, index) {
		// 	this.setFillStyle({color:"#000000",opacity:0.2});
		// 	$('div#tooltip').hide();
		// 
		// 	  });
		// 
		// GEvent.addListener(africa_2, "click", function(latlng, index) {
		// 	window.location = 'region.html?id='+this.name.id;
		// 	  });
		// 
		// 
		// //EUROPE UK
		// 
		// europe = new GPolygon.fromEncoded({
		//   polylines: [
		//     {points: "wndoI`lzeGxkhxEhdPo_|dB{wh`FqmmBidPo~~AjybHpjZ`tqGi}eF}nr@csoAnihCo_yMynyCi_eH|nr@mscB|nr@yeoBcd~E~yWynyCv{Wshg`@gruF{nyCynzD?chvBria@iboBnabDgtvAtia@ey~@nqnBbdVfl}Aaq~@|~eBiwDzv_CahoA_or@m}w@pqnBug}@kybHl}bA{~eB_`PwvfFyvyEzflA?edwBrjgAgtcA?oquEkddCwn`GwybD}vXa|_BgqcL}siAi|i@semCedwBoo|Ai|i@queByfsDgbDcd~Ei|v@edwBbaDe|pCcvtAqihCa`b@ria@gonAria@{{oBsqGqvj@pqnBy|tDuqGw~|Aqa{@uviC}krKonuAfqcL~sUtfzGudZra{@yvaBlquEe_sVlrspCrwzl@poeuC",
		// 		     levels: "PPPNNPNNNLPNLPNLPMLNMLNNPMMOOMMONNNKKMOMLPOKMNNPMPMMFNPP",
		// 		     color: "#000000",
		// 		     opacity: 0.2,
		// 		     weight: 1,
		// 		     numLevels: 18,
		// 		     zoomFactor: 2},{points: "alzdJ`fk^~jUe|pC{lLy~lEt{t@sia@fl~@bd~Eznc@sytA~tc@fl}A_xLqvtLxxc@gtcAfmpDd|pChl[d|pCfh`@gl}A`m`@dtjDrqHoquE~wuAoabDjseDqytAfubBy~lE`k}B}nr@sgNzv_CxjaAetjDjtX{flA|vw@ddwB?qqnBajI{~eBpgc@}flA`_hA_wXxos@~vXjknAnihCjit@rytAdjDyfsDjgeBftcAbgOd|pC?ddwBolDlioFbveAny{Dwce@pqnBrmkA|flAy}InihCtlp@dtjDr_JnihCy|xEu~sHioTa|wFoeoA}~eBx~^bldEk}n@jivImjxBoquEedgBtqGnjIfl}AgklAqqnBicDqihCecD{v_Cei|@htcAgedBidPs`IpytAm~iAria@knz@ddwBzt\\zv_C{t\\htcAdqk@pqnBhy_Auia@bfq@fl}AflrCidPreyEra{@lgDd|pCninCz{eM?pytAwui@g|i@wxn@fl}Aygi@|nr@yps@}flAezbAa|wFzkIlioFymfBoy{Dscm@bd~EalpAitcA}qjAfl}A?kybHk{iAgl}A{xWhtcAo`dAsytA}uMctjDauMyfsDz~t@sytAihrAmy{Diz_B_wXhklAxfsDgqwB?u{oAi|i@_j[|~eBekeAhdPk}mAzv_C_d_Cria@cegAqytAbvtC_or@vzz@}nr@qivA}nr@krxCedwB",
		// 				     levels: "PLPMMNOMPMNNPMOMMONIOOJLPLNHONPKHMMMMLKPMMPMPNNNOEPMNMMPLLOMNMOLLPMKOLPOONNPNMNNFMNPNNLNMMMPNLOKP",
		// 				     color: "#000000",
		// 				     opacity: 0.2,
		// 				     weight: 1,
		// 				     numLevels: 18,
		// 				     zoomFactor: 2}],
		//   fill: true,
		//   color: "#000000",
		//   opacity: 0.2,
		//   outline: true,
		// 	name: {name: 'North East Atlantic',area:'11,060,000',pnumber:'313',ppercent:'0.22',id:'0'}
		// });
		// map.addOverlay(europe);
		// regions.push(europe);
		// 
		// GEvent.addListener(europe, "mouseover", function(param) {
		// 	    this.setFillStyle({color:"#FF6423",opacity:0.7});
		// 			$('div#tooltip h4 a').text(this.name.name);
		// 			$('div#tooltip div.areas_number p').text(this.name.pnumber);
		// 			$('div#tooltip div.protected p').text(this.name.ppercent+'%');
		// 			$('div#tooltip div.area p').html(this.name.area+'km<sup>2</sup>');
		// 			var bounds = this.getBounds();
		// 			var polygon_center = bounds.getCenter();
		// 			var pixel = map.getCurrentMapType().getProjection().fromLatLngToPixel(map.fromDivPixelToLatLng(new GPoint(0,0),true),map.getZoom());
		// 	        var offset=map.getCurrentMapType().getProjection().fromLatLngToPixel(polygon_center,map.getZoom());
		// 	        var width =tooltip.clientWidth;
		// 	        var height=tooltip.clientHeight;
		// 	        var pos = new GControlPosition(G_ANCHOR_TOP_LEFT, new GSize(offset.x - pixel.x - width/2, offset.y - pixel.y -80 - height/2)); 
		// 	        pos.apply(tooltip);
		// 			$('div#tooltip').show();
		// });
		// 
		// 
		// 
		// GEvent.addListener(europe, "mouseout", function(latlng, index) {
		// 	this.setFillStyle({color:"#000000",opacity:0.2});
		// 	$('div#tooltip').hide();
		// 
		// 	  });
		// 
		// GEvent.addListener(europe, "click", function(latlng, index) {
		// 	window.location = 'region.html?id='+this.name.id;
		// 	  });
		// 
		// 
		// 
		// 
		// //MEDITERRANEO
		// 
		// mediterraneo = new GPolygon.fromEncoded({
		//   polylines: [
		//     {points: "_pgzE~u~_@vsqCe|pCc`TkybHhab@y~lEs|uBwvfFs{S{nyCuztBynyC_xjAgi}LymZiivIpz|@gdwBwb_By~lEvbh@{~eBiqS{~eBhqS}flA_vLgdwBqzwAu~sHv`aCgtcAwia@qqnB|mkDfl}AdmtDoihCfdzCbldEtsiBi|i@tgMqqnBzj_Ag|i@nfq@gdwBhkq@qytAteFgl}AyrTqihCd{|AsvmId|jE{v_ChkhAuvmIjfkCkybHor\\edwBqpwA}flAkgsErqGq`sBe|pCocgActjDfy[etjD~ac@{v_CblgA_wXdic@oabDtgFctjDzx}Asa{@}hFqqnBrqc@kaiGfyeB_txJ}acC_|~Ij}TyfsDdir@e|pC{iFqqnB|_UgtcA}ty@oihCi}wRu~sHan|DhdPipkAuia@ulv@h|i@a_dA}flAubo@~vX~wcAz~eBwdo@znyC`uqApytA`i}@`tqGc_pCtvmI?pqnBpe{BrqGv|EdtjD{rfBny{Dh{EnihCwka@pytAofqA?gqu@~nr@e`yBf|i@ufS|~eBcgbA|nr@rlL{nyC__bAhdP{oiB~vXhsEpqnBuexEi|i@arsAlquEh~KvfzGj}zBgl}AwsRpqnBtwmAidPeo{BznyCfk`Apa{@~aeEqqnB~l|A{v_C|xcBgtcArv}ApytA_|`@fl}AjbgC|flAxdvCsqGgkh@|nr@yoZddwBsfzBpqnBoc~Afl}Au`pAqqnBmvEfl}AgbcGbd~EsccDnabDortFsa{@kicFnv{OsytLp~zKqdW|flAf_`BpytAue|C|nr@h`W`tqGbu_BgtcAhwu@ria@vutAsqGv~fCyvfFtqhCsia@dkwA{~eBv_xAoabDfkEetjDtuxA?twsCsfaKfogB{~eBzihB|vXkmuBrytA}ff@ly{D`u{B|flA~r{AqqnB`fhA?hjLfl}AvabEzv_CuwEpytA`hwArytA~}pAsia@`ixApa{@st`FpfhNgu}Ae|pCrgn@}~eBsgn@sngJio~B}flA_zfFfl}AyvbMnchY{_~HlioFm}nAvn`G`xvFdypNk{iA`d~E?x~lEj{iAd|pCd{hF?~}rDr~zKvqeHvn`G|kqC_or@rjbEfdwBt~bAbldEv`aCpytAfwLfi}LxcwCx~lE",
		// 		     levels: "PNLOMMOLNMMLLNKPNNNONPMLJNKMNNMPMNNLPKMMKNNKMONLLLPNNLMNPMMNMNNNNMMPMLLMMOOGNNOPONNNNPMLPMNMPLMINOMKOPNOMNPOMLPNMNMNNMPNMONMOMMMNMPPNMPNPNNPONMPONONPMNNP",
		// 		     color: "#000000",
		// 		     opacity: 0.2,
		// 		     weight: 1,
		// 		     numLevels: 18,
		// 		     zoomFactor: 2},{points: "slj{GucwzD`mkDxfsD``bDria@?dtjDlwfHpa{@`od@fl}AbecCpytAzpqAqytAlflDetjD?{{eM_vrCgyiK?sngJxje@}flA?gl}Avwx@sa{@`{_BgyiK?uvmIw``D_deIwzcE|nr@yi|BvfzGe~_DvvfFs|oDfyiK_ju@g|i@?{v_Cm`gA?qwn@sytA?{flAkk{BxnyCuwJoabDcjeA{~eBwtJbldE`ubB|clLxqiBv~lEzvhCgl}A?ad~Exl{@f|i@|`EfdwBnro@xnyCjqtAdtjDmgKftcAkzrB?krsAdtjDo~lAyfsDyun@rqG?pqnBwsb@`|wFwcz@zfsD",
		// 				     levels: "PMNNNMPHPMNOLLLNOPOLLPMMMMONMPMMONPMLKPMMOMOKLP",
		// 				     color: "#000000",
		// 				     opacity: 0.2,
		// 				     weight: 1,
		// 				     numLevels: 18,
		// 				     zoomFactor: 2}],
		//   fill: true,
		//   color: "#000000",
		//   opacity: 0.2,
		//   outline: true,
		// 	name: {name: 'Mediterranean and Black Seas',area:'2,989,000',pnumber:'236',ppercent:'0.79',id:'0'}
		// });
		// map.addOverlay(mediterraneo);
		// regions.push(mediterraneo);
		// 
		// GEvent.addListener(mediterraneo, "mouseover", function(param) {
		// 	    this.setFillStyle({color:"#FF6423",opacity:0.7});
		// 			$('div#tooltip h4 a').text(this.name.name);
		// 			$('div#tooltip div.areas_number p').text(this.name.pnumber);
		// 			$('div#tooltip div.protected p').text(this.name.ppercent+'%');
		// 			$('div#tooltip div.area p').html(this.name.area+'km<sup>2</sup>');
		// 			var bounds = this.getBounds();
		// 			var polygon_center = bounds.getCenter();
		// 			var pixel = map.getCurrentMapType().getProjection().fromLatLngToPixel(map.fromDivPixelToLatLng(new GPoint(0,0),true),map.getZoom());
		// 	        var offset=map.getCurrentMapType().getProjection().fromLatLngToPixel(polygon_center,map.getZoom());
		// 	        var width =tooltip.clientWidth;
		// 	        var height=tooltip.clientHeight;
		// 	        var pos = new GControlPosition(G_ANCHOR_TOP_LEFT, new GSize(offset.x - pixel.x - width/2, offset.y - pixel.y - 50 - height/2)); 
		// 	        pos.apply(tooltip);
		// 			$('div#tooltip').show();
		// });
		// 
		// 
		// 
		// GEvent.addListener(mediterraneo, "mouseout", function(latlng, index) {
		// 	this.setFillStyle({color:"#000000",opacity:0.2});
		// 	$('div#tooltip').hide();
		// 
		// 	  });
		// 
		// GEvent.addListener(mediterraneo, "click", function(latlng, index) {
		// 	window.location = 'region.html?id='+this.name.id;
		// 	  });
		// 
		// 
		// //INDIA
		// 
		// india = new GPolygon.fromEncoded({
		//   polylines: [
		//     {points: "us`pCyi__LquNgdwB~rmAftcA`cmCmquEkg~@etjDtvuBhtcAbw^`d~E|mnHsngJwd_Ba|wFifvEsia@?gdwBpnvAftcAr{vEel}A~apDftcAvyoAgtcAnsxB|vXfdtPedwBhh}De|pCrg{Hgl}A~qlHetjDxiyNoabDlsjEmquEw}q@{v_C{wuBi|i@m}OcldEmfkAra{@us_Dsa{@gmGqytA_w{FrqGebuH{v_CicmJ|flAo`zAsia@cih@edwBo|bC{v_CkmvHgi}Lm{kIkq|Hkh_@ctjDkxwBqqnBkhgDidP_ufBy~lExvfAsa{@u}NedwB{v~@etjDl{Vgl}Au|N{flAcdvBuia@swVoihCzt}IqihCj{gDoihCneWe|pCt~}LyfsD~}nHftcAngh@cldEoxcDyfsDptWgl}A}psD_wXnntEedwBzdiAsa{@lxmE?j|rHqihCjplH}vX~p`E?``fChdPpzi`Cbn|oBezOzl~`A_lrjCtqG_ljgAny{D",
		// 		     levels: "PNNNONPPNNPMNNMMPMMLNPMNPNMNMNMPMLMNNMNPNLMNMMPNMONPNNOPKPMNLKPPPNP",
		// 		     color: "#000000",
		// 		     opacity: 0.2,
		// 		     weight: 1,
		// 		     numLevels: 18,
		// 		     zoomFactor: 2}],
		//   fill: true,
		//   color: "#000000",
		//   opacity: 0.2,
		//   outline: true,
		// 	name: {name: 'Central Indian Ocean',area:'7,717,000',pnumber:'79',ppercent:'0.09',id:'0'}
		// });
		// map.addOverlay(india);
		// regions.push(india);
		// 
		// GEvent.addListener(india, "mouseover", function(param) {
		// 	    this.setFillStyle({color:"#FF6423",opacity:0.7});
		// 			$('div#tooltip h4 a').text(this.name.name);
		// 			$('div#tooltip div.areas_number p').text(this.name.pnumber);
		// 			$('div#tooltip div.protected p').text(this.name.ppercent+'%');
		// 			$('div#tooltip div.area p').html(this.name.area+'km<sup>2</sup>');
		// 			var bounds = this.getBounds();
		// 			var polygon_center = bounds.getCenter();
		// 			var pixel = map.getCurrentMapType().getProjection().fromLatLngToPixel(map.fromDivPixelToLatLng(new GPoint(0,0),true),map.getZoom());
		// 	        var offset=map.getCurrentMapType().getProjection().fromLatLngToPixel(polygon_center,map.getZoom());
		// 	        var width =tooltip.clientWidth;
		// 	        var height=tooltip.clientHeight;
		// 	        var pos = new GControlPosition(G_ANCHOR_TOP_LEFT, new GSize(offset.x - pixel.x - width/2, offset.y - pixel.y - 50 - height/2)); 
		// 	        pos.apply(tooltip);
		// 			$('div#tooltip').show();
		// });
		// 
		// 
		// 
		// GEvent.addListener(india, "mouseout", function(latlng, index) {
		// 	this.setFillStyle({color:"#000000",opacity:0.2});
		// 	$('div#tooltip').hide();
		// 
		// 	  });
		// 
		// GEvent.addListener(india, "click", function(latlng, index) {
		// 	window.location = 'region.html?id='+this.name.id;
		// 	  });
		// 
		// 
		// 
		// 
		// //MALASIA
		// 
		// malasia = new GPolygon.fromEncoded({
		//   polylines: [
		//     {points: "`mubA{ddgNqlGytonF~|y@}hrVqb_D}sxJ?iih_ByavG}vXeeqDly{Du~q@idPh~bAx~lE|}`@laiGunqD}flAs_Pe|pCoar@|vXa`PqytAosz@pytAcbpGfdwBm`wFtczR{fa@fdwBsalAz~eBpocAria@~tXfl}Ak`hCria@outApihCscPqqnB}qcAitcAvcPqqnBwi}Aqa{@b`{@~kkHuawBra{@mscAbldEca{@ra{@unr@}nr@ha{@sia@{k}AitcA{nr@oihC?}flAxflAatqGxrjDsqGrkyCsia@fdlA_or@gdlAsqGrhyCgppAfqG}byAmcjB{byAoha@ixv@svv@idP{ha@etjD_scA~zKqwv@e|pCfvyEuk`RbvXitcAgyfS_{Ko|oJz|qbAok~fBh`]?xpqnBz~hJjq|H{aCbtjD}_p@peuCo|dBdhjBothB~zKmafJ_{Ky`cC?j}v@fhjBd`k@ria@p`W|j_A~_Kh|i@jhgAh`]`l_AhhC|cS~vXjdSpa{@?hxv@fbuDren@ljWsia@d|pB}j_AtmWsen@x`t@_{Kfi|@i`]b`l@}flAlr`A}vXpdqA}~eBzemEchqElxiHquaB|toE}re@j|vA|re@ftxB?xgwA|re@x`dBdpwDbcoAfxv@?|byActKfxv@?~nr@vlm@hhC`q\\ria@efCria@hzfAidPpwq@ren@l~pDvvfF?|j_A_wcF_{Kaom@qen@{idBneuC?puaBk_uBren@be~@fppAgwoDren@qeXf|i@ceX~nr@}epBp}gAaeCbhqE_vyChhCejGpabDdiiF|zKfxsIzjfDr`_F_{K`nGghjBve_LedwBpbr@wvfFrwkGatqGvncC}flAl|nH?zg_A_{Kbvv@}nr@nvv@i|i@rwtAi|i@zj}AsqG?|re@zzKhxv@vvXrmTwwv@ren@u{i@pqnBy_]|flAqauCly{D_vX~vX_qaB?kajBfl}Aou}Mzv_Cka~Jj}uGhvoAftcAivoAtmTwj|ArqGw`oC}re@yjoA_se@onm@~zKhov`CbjipB",
		// 		     levels: "PMOOPNMPLPNMMOMPKLNMPMOMMMPOMLPMMMNLPKNNMPMKLMMMPGPPPPPNPMOKIPLLINKLMKNPKLLJMLLKPLNKLPLNJJNLKLMNMPMOMNNNMILNNNPMPNNONLOKNIMLPJLNLELIPLMONOJMKLPP",
		// 		     color: "#000000",
		// 		     opacity: 0.2,
		// 		     weight: 1,
		// 		     numLevels: 18,
		// 		     zoomFactor: 2},	{points: "etnOoepfTnluEpa{@cia@zrlC`dPfppAcscA|nr@?ra{@lbwBra{@nnr@?f}gArmT|{wF}re@nen@ixv@rflAgtcAjia@}j_AltaB~vXl`{@umTbjyCg|i@?s}gA~~\\_{KmzK{~eBkqe@quaB`upCidP{yi@}byAdqGi|i@ilr@qytAbzi@edwBtga@ixv@klTg|i@fzKquaBvztCumTid{Bke|F_ruG}zrB_xtAhtcAax{Dm}uGi}nD~re@mm{Bs}gAsj_AsmTtnr@oabDqmTsia@mrjDv~lEgj}A}nr@_iwDzjfDcuv@uqGkga@gppAcjpAfxv@wkTcldEui_Cren@azz@yb`EmxiBznyCsgCfppAgwz@uqGfaPrytAogcA?c_pAp}gAaxKra{@kgC|nr@|lvFneuCx{\\fppAx_}AtqGjwi@jaiGrtjHdpwDjqaB~{~I",
		// 					     levels: "POLMLNPKLNJKNMIPLMKONLLNKMLOPONNONKOLPNNPMNNNNPLMMNLMIPMMONOP",
		// 					     color: "#0000ff",
		// 					     opacity: 0.7,
		// 					     weight: 3,
		// 					     numLevels: 18,
		// 					     zoomFactor: 2}],
		//   fill: true,
		//   color: "#000000",
		//   opacity: 0.2,
		//   outline: true,
		// 	name: {name: 'East Asian Seas',area:'12,043,000',pnumber:'529',ppercent:'0.73',id:'0'}
		// });
		// map.addOverlay(malasia);
		// regions.push(malasia);
		// 
		// GEvent.addListener(malasia, "mouseover", function(param) {
		// 	    this.setFillStyle({color:"#FF6423",opacity:0.7});
		// 			$('div#tooltip h4 a').text(this.name.name);
		// 			$('div#tooltip div.areas_number p').text(this.name.pnumber);
		// 			$('div#tooltip div.protected p').text(this.name.ppercent+'%');
		// 			$('div#tooltip div.area p').html(this.name.area+'km<sup>2</sup>');
		// 			var bounds = this.getBounds();
		// 			var polygon_center = bounds.getCenter();
		// 			var pixel = map.getCurrentMapType().getProjection().fromLatLngToPixel(map.fromDivPixelToLatLng(new GPoint(0,0),true),map.getZoom());
		// 	        var offset=map.getCurrentMapType().getProjection().fromLatLngToPixel(polygon_center,map.getZoom());
		// 	        var width =tooltip.clientWidth;
		// 	        var height=tooltip.clientHeight;
		// 	        var pos = new GControlPosition(G_ANCHOR_TOP_LEFT, new GSize(offset.x - pixel.x - width/2, offset.y - pixel.y-50 - height/2)); 
		// 	        pos.apply(tooltip);
		// 			$('div#tooltip').show();
		// });
		// 
		// 
		// 
		// GEvent.addListener(malasia, "mouseout", function(latlng, index) {
		// 	this.setFillStyle({color:"#000000",opacity:0.2});
		// 	$('div#tooltip').hide();
		// 
		// 	  });
		// 
		// GEvent.addListener(malasia, "click", function(latlng, index) {
		// 	window.location = 'region.html?id='+this.name.id;
		// 	  });


	}
		
		
		