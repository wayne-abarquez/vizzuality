{include file="header.tpl"}

{literal}
<script type="text/javascript">
	function situar(){
        
        var addressval = $("#inputLocalizacion").val();
    	var dataObj = ({address : addressval,method: 'geolocateAddress'});
    
    	if(addressval="") {
    		return false; 
    	}
    
    	$('#buttonLocalizacion').val('...');
		$('#buttonLocalizacion').attr("disabled", "true"); 
		
	    // -- Start AJAX Call --
	    $.ajax({
	        type: "POST",
	        url: "/ajaxController.php",
	        data: dataObj,
	        cache: false,
	        success: function(result){
	                //notify the user that the username is used.
	                var lat = result.split(",")[0];
	                var lon = result.split(",")[1];
	                
	                $('#buttonLocalizacion').val('Situar');
					$('#buttonLocalizacion').removeAttr("disabled"); 
	                $('#latHidden').val(lat);
	              	$('#lonHidden').val(lon);

                    var map = new GMap2(document.getElementById("map"));
                    var start = new GLatLng(lat, lon);
                    map.setCenter(start, 10);
                    
                    map.addControl(new GSmallZoomControl());
                    new GKeyboardHandler(map);
                    map.enableContinuousZoom();
                    map.enableDoubleClickZoom();    
                    
                    var bounds = new GLatLngBounds();


                    function drawCircle(center, radius, nodes, liColor, liWidth, liOpa, fillColor, fillOpa)
                    {
                        map.clearOverlays();
                    // Esa 2006
                    	//calculating km/degree
                    	var latConv = center.distanceFrom(new GLatLng(center.lat()+0.1, center.lng()))/100;
                    	var lngConv = center.distanceFrom(new GLatLng(center.lat(), center.lng()+0.1))/100;

                    	//Loop 
                    	var points = [];
                    	var step = parseInt(360/nodes)||10;
                    	for(var i=0; i<=360; i+=step)
                    	{
                    	var pint = new GLatLng(center.lat() + (radius/latConv * Math.cos(i * Math.PI/180)), center.lng() + 
                    	(radius/lngConv * Math.sin(i * Math.PI/180)));
                    	points.push(pint);
                    	bounds.extend(pint); //this is for fit function
                    	}
                    	points.push(points[0]); // Closes the circle, thanks Martin
                    	fillColor = fillColor||liColor||"#0055ff";
                    	liWidth = liWidth||2;
                    	var poly = new GPolygon(points,liColor,liWidth,liOpa,fillColor,fillOpa);
                    	map.addOverlay(poly);
                    }  

                    function fit(){
                        map.panTo(bounds.getCenter()); 
                        map.setZoom(map.getBoundsZoomLevel(bounds)-1);
                    }

                    {/literal}{if !lat eq ""}{literal}
                        drawCircle(start,$('#inputRadio').val(), 40);   
                        fit();
                    {/literal}{else}{literal}
                        $('#map').hide();
                    {/literal}{/if}{literal}
			       
	        },
	        error:function (xhr, ajaxOptions, thrownError){
	        	$('#buttonLocalizacion').val('Situar');
				$('#buttonLocalizacion').removeAttr("disabled"); 
	        }
	    });
	    
	    return false;
	    }

</script>
{/literal}


{literal}
<script type="text/javascript">
function va(id){
	valhrs = $('#rec_hh_'+id).val();
	valmin = $('#rec_mm_'+id).val();
	valsec = $('#rec_ss_'+id).val();
	valdec = $('#rec_dd_'+id).val();

	//validar los inputs records de derecha a izquierda a partir de decimas
	if ((valdec!="") && (valhrs=="" && valmin=="" && valsec=="")){
		$('#rec_hh_'+id).attr("value", "00"); 
		$('#rec_mm_'+id).attr("value", "00"); 
		$('#rec_ss_'+id).attr("value", "00"); 
	} else if ((valdec!="") && (valhrs=="" && valmin=="" && valsec!="")){
		$('#rec_hh_'+id).attr("value", "00"); 
		$('#rec_mm_'+id).attr("value", "00"); 
	} else if ((valdec!="") && (valhrs=="" && valmin!="" && valsec!="")){
		$('#rec_hh_'+id).attr("value", "00");
	} else if ((valdec!="") && (valhrs=="" && valmin!="" && valsec=="")){
		$('#rec_hh_'+id).attr("value", "00"); 
		$('#rec_ss_'+id).attr("value", "00"); 
	} else if ((valdec!="") && (valhrs!="" && valmin=="" && valsec=="")){
		$('#rec_mm_'+id).attr("value", "00"); 
		$('#rec_ss_'+id).attr("value", "00"); 
	}else if ((valdec!="") && (valhrs!="" && valmin!="" && valsec=="")){
		$('#rec_ss_'+id).attr("value", "00"); 
	}else if ((valdec!="") && (valhrs!="" && valmin=="" && valsec!="")){
		$('#rec_mm_'+id).attr("value", "00"); 
	}
	
	//validar los inputs records de derecha a izquierda a partir de segundos
	if ((valsec!="") && (valhrs=="" && valmin=="")){
		$('#rec_hh_'+id).attr("value", "00"); 
		$('#rec_mm_'+id).attr("value", "00"); 
	} else if ((valsec!="") && (valhrs=="" && valmin!="")){
		$('#rec_hh_'+id).attr("value", "00"); 
	} else if ((valsec!="") && (valhrs!="" && valmin=="")){
		$('#rec_mm_'+id).attr("value", "00"); 
	}
	
	//validar los inputs records de derecha a izquierda a partir de minutos
	if ((valmin!="") && (valhrs=="")){
		$('#rec_hh_'+id).attr("value", "00"); 
	}
}
</script>
{/literal}

{literal}
<script type="text/javascript"> 
$(document).ready(function(){

	//para hacer crecer las columas a la vez
	if ($('div.rightColumn').height()<$('div.leftColumn').height()) {
		$('div.rightColumn').height($('div.leftColumn').height());	
	}

	//Para controlar la activación del radio de localización
	if ($("#alertsCheckBox").is(":checked")){
		$("#editRadio").show();
	}else{     
		$("#editRadio").hide();
	}

	
	$("#alertsCheckBox").click(function(){
	    if ($("#alertsCheckBox").is(":checked"))
	      {
	          $("#editRadio").show("fast");
	      }
	      else
	      {     
	          $("#editRadio").hide();
	      }	
	});
	
	
	//Para validar datos de usuario
	$("#editDataForm").validate({
		rules: {
			inputPassword: {
				required: true,
				minlength: 5
			},
			inputPassword2: {
				required: true,
				minlength: 5,
				equalTo: "#inputPassword"
			},
			inputMail: {
				required: true,
				email: true
			},
			inputName: {
				required: true,
				minlength: 5
			},
			inputLocalizacion: {
				required: true
			},
			inputRadio: {
				required: true
			},
			rec_hh_1: {
				max: 23
			},
			rec_hh_2: {
				max: 23
			},
			rec_hh_3: {
				max: 23
			},
			rec_hh_4: {
				max: 23
			},
			rec_hh_5: {
				max: 23
			},
			rec_hh_6: {
				max: 23
			},
			rec_hh_7: {
				max: 23
			},
			rec_hh_8: {
				max: 23
			},
			rec_hh_9: {
				max: 23
			},
			rec_mm_1: {
				max: 59
			},
			rec_mm_2: {
				max: 59
			},
			rec_mm_3: {
				max: 59
			},
			rec_mm_4: {
				max: 59
			},
			rec_mm_5: {
				max: 59
			},
			rec_mm_6: {
				max: 59
			},
			rec_mm_7: {
				max: 59
			},
			rec_mm_8: {
				max: 59
			},
			rec_mm_9: {
				max: 59
			},
			rec_ss_1: {
				max: 59
			},
			rec_ss_2: {
				max: 59
			},
			rec_ss_3: {
				max: 59
			},
			rec_ss_4: {
				max: 59
			},
			rec_ss_5: {
				max: 59
			},
			rec_ss_6: {
				max: 59
			},
			rec_ss_7: {
				max: 59
			},
			rec_ss_8: {
				max: 59
			},
			rec_ss_9: {
				max: 59
			},
			rec_dd_1: {
				max: 99
			},
			rec_dd_2: {
				max: 99
			},
			rec_dd_3: {
				max: 99
			},
			rec_dd_4: {
				max: 99
			},
			rec_dd_5: {
				max: 99
			},
			rec_dd_6: {
				max: 99
			},
			rec_dd_7: {
				max: 99
			},
			rec_dd_8: {
				max: 99
			},
			rec_dd_9: {
				max: 99
			}
		},
		messages: {
			inputPassword: {
				required: "Introduce contraseña",
				minlength: "Al menos 5 caracteres"
			},
			inputPassword2: {
				required: "Repite contraseña",
				minlength: "Al menos 5 caracteres",
				equalTo: "Debe ser igual a la contraseña"
			},
			inputMail: {
				required: "Introduce una dirección de correo",
				email: "No es una dirección válida"
			},
			inputName: {
				required: "Introduce tu nombre",
				minlength: "Al menos 5 caracteres"
			},
			inputLocalizacion: {
				required: "Introduce tu localidad"
			},
			inputRadio: {
				required: "Introduce un valor"
			},
			rec_hh_1: {
				max: ""
			},
			rec_hh_2: {
				max: ""
			},
			rec_hh_3: {
				max: ""
			},
			rec_hh_4: {
				max: ""
			},
			rec_hh_5: {
				max: ""
			},
			rec_hh_6: {
				max: ""
			},
			rec_hh_7: {
				max: ""
			},
			rec_hh_8: {
				max: ""
			},
			rec_hh_9: {
				max: ""
			},
			rec_mm_1: {
				max: ""
			},
			rec_mm_2: {
				max: ""
			},
			rec_mm_3: {
				max: ""
			},
			rec_mm_4: {
				max: ""
			},
			rec_mm_5: {
				max: ""
			},
			rec_mm_6: {
				max: ""
			},
			rec_mm_7: {
				max: ""
			},
			rec_mm_8: {
				max: ""
			},
			rec_mm_9: {
				max: ""
			},
			rec_ss_1: {
				max: ""
			},
			rec_ss_2: {
				max: ""
			},
			rec_ss_3: {
				max: ""
			},
			rec_ss_4: {
				max: ""
			},
			rec_ss_5: {
				max: ""
			},
			rec_ss_6: {
				max: ""
			},
			rec_ss_7: {
				max: ""
			},
			rec_ss_8: {
				max: ""
			},
			rec_ss_9: {
				max: ""
			},
			rec_dd_1: {
				max: ""
			},
			rec_dd_2: {
				max: ""
			},
			rec_dd_3: {
				max: ""
			},
			rec_dd_4: {
				max: ""
			},
			rec_dd_5: {
				max: ""
			},
			rec_dd_6: {
				max: ""
			},
			rec_dd_7: {
				max: ""
			},
			rec_dd_8: {
				max: ""
			},
			rec_dd_9: {
				max: ""
			}
		}
	});
	
    new AjaxUpload('#avatarPerfil', {
    	action: '/imageController.php',
    	data : { method:"uploadAvatar"},
    	onSubmit : function(file , ext){
    		if (ext && /^(jpg|png|jpeg|gif)$/.test(ext)){			
    			// change button text, when user selects file			
				$("#buttonUpload").html(".");


    			// If you want to allow uploading only 1 file at time,
    			// you can disable upload button
    			this.disable();


    			// Uploding -> Uploading. -> Uploading...
    			interval = window.setInterval(function(){
    				var text = $("#buttonUpload").html();
    				if (text.length < 17){
						$("#buttonUpload").html(text + '.');					
    				} else {
    					$("#buttonUpload").html(".");				
    				}
    			}, 200);

    		} else {

    			// extension is not allowed
    			//$('#example2 .text').text('Error: only images are allowed');
    			// cancel upload
    			return false;				
    		}

    	},
    	onComplete : function(file){

			$("#userImg").attr("src","/avatar.php?id={/literal}{$smarty.session.user.id}{literal}&type=t&"+new Date().valueOf());
			$("#buttonUpload").html("Click para subir avatar");

			window.clearInterval(interval);

			//enable upload button
			this.enable();
						
    	}		
    });
    
    	
});
</script>
{/literal}

<div class="span-24 column content">

	<div class="span-1 last leftColumn">
	<div class="span-1 columnNameUser">
		<a href="/perfil/{$smarty.session.user.username}"><p class="nameUserProfile">{$privateData.datos.completename} 
		<span class="nameUserProfileNick">({$privateData.datos.username})</span></p>
	</div><a class="dashboardLink" href="/perfil/{$smarty.session.user.username}">volver a tu dashboard <img src="/img/arrowDash.gif"></a>

		<div class="globalContainerUser">	
			<div class="span-1 last userData">
				<div class="span-1 avatarPerfil" id="avatarPerfil">
					<img class="imgAvatarPerfil" id="userImg" src="/avatar.php?id={$smarty.session.user.id}&type=t">
					<a class="changeAvatar" id="buttonUpload">Click para subir avatar</a>
				</div>
				<div class="span-1 last functionalContainer">
				<p class="titulo tituloLeft">ESTADÍSTICAS</p>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUser"><p>Visitas a tu perfil: </p></div>
						<div class="span-1 last dataUser"><p><b>{$privateData.datos.visits_profile}</b></p></div>
					</div>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUser"><p>Carreras corridas:</p></div>
						<div class="span-1 last dataUser"><p><b>{$privateData.datos.num_races_runned}</b></p></div>
					</div>
				</div>
<!--
				<div class="span-1 last functionalContainer">
				<p class="titulo tituloLeft">DARSE DE BAJA</p>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUser"><p>Quieres darte de baja?</p></div>
						<div class="span-1 last dataUser"><p><b><a href="javascript: void confirmationWindowUser()">BAJA</a></b></p></div>
					</div>
				</div>
-->	
				<div id="confirmationWindowUser" style='display:none'>
					<p>¿Estás seguro de que quieres borrar tu cuenta?</p>
					<div class="erasePhoto">
					<input class="deleteAcountButton" type="submit" value="Si, borrar cuenta" onclick="location.href='/usuario_editar.php?del_usuario=true'"/>
					<input class="deleteAcountButton" type="submit" value="No, ahora no" onclick="$.modal.close();"/>
					</div>
				</div>			
			</div>
			
			<form action="usuario_editar.php" method="POST" id="editDataForm">
				<input type="hidden" id="latHidden" name="latHidden" value="{$privateData.datos.lat}">
			    <input type="hidden" id="lonHidden" name="lonHidden" value="{$privateData.datos.lon}">	
		
			<div class="span-1 last dataUserEdit">
				<p class="titulo tituloLeft tituloRight">DATOS PERSONALES</p>
				<div class="span-1 editdata">
					<div class="nameEdit">
						<p class="data">NOMBRE Y APELLIDOS</p>
						<input type="text" name="inputName" id="inputName" class="inputName" value="{$privateData.datos.completename}">
					</div>
					<div class="sexoFecha">
						<div class="span-1 first sexoEdit">
							<p class="data">SEXO</p>
							<select name="is_men" id="combo_sex">
								{if $privateData.datos.is_men eq 't'}
								<option selected value="true">Hombre</option>
			        			<option value="false">Mujer</option>
			        			{else}
			        			<option selected value="false">Mujer</option>
			        			<option value="true">Hombre</option>
			        			{/if}
			    			</select>
						</div>
						<div class="span-1 last fechaEdit">
							<p class="data">FECHA NACIMIENTO</p>
							{html_select_date  prefix='birthday' time=$privateData.datos.birthday start_year='-55' month_format='%m' field_order='DMY' end_year='-8' reverse_years=true}
						</div>
					</div>
					<div class="localizacionEdit">
						<p class="data">LOCALIZACIÓN</p>
						<div class="span-1 first localizatorInputContainer"><input type="text" name="inputLocalizacion" id="inputLocalizacion" class="inputLocalizacion" value="{$privateData.datos.locality}"></div>
						<div class="span-1 last localizatorInputButton"><input id="buttonLocalizacion" type="button" value="Situar" class="ButtonLocalizationUpdate" onclick="javascript: situar();"></div>
					</div>
					<div id="mapBox">
						<div class="span-1 mapaAlerts" id="map">
{literal}
                        <script type="text/javascript">
                        //<![CDATA[
                            var map = new GMap2(document.getElementById("map"));
                            var start = new GLatLng({/literal}{$privateData.datos.lat}, {$privateData.datos.lon}{literal});
                            map.setCenter(start, 10);
                            
                            map.addControl(new GSmallZoomControl());
                            new GKeyboardHandler(map);
                            map.enableContinuousZoom();
                            map.enableDoubleClickZoom();    
                            
                            var bounds = new GLatLngBounds();


                            function drawCircle(center, radius, nodes, liColor, liWidth, liOpa, fillColor, fillOpa)
                            {
                                map.clearOverlays();
                            // Esa 2006
                            	//calculating km/degree
                            	var latConv = center.distanceFrom(new GLatLng(center.lat()+0.1, center.lng()))/100;
                            	var lngConv = center.distanceFrom(new GLatLng(center.lat(), center.lng()+0.1))/100;

                            	//Loop 
                            	var points = [];
                            	var step = parseInt(360/nodes)||10;
                            	for(var i=0; i<=360; i+=step)
                            	{
                            	var pint = new GLatLng(center.lat() + (radius/latConv * Math.cos(i * Math.PI/180)), center.lng() + 
                            	(radius/lngConv * Math.sin(i * Math.PI/180)));
                            	points.push(pint);
                            	bounds.extend(pint); //this is for fit function
                            	}
                            	points.push(points[0]); // Closes the circle, thanks Martin
                            	fillColor = fillColor||liColor||"#0055ff";
                            	liWidth = liWidth||2;
                            	var poly = new GPolygon(points,liColor,liWidth,liOpa,fillColor,fillOpa);
                            	map.addOverlay(poly);
                            }  

                            function fit(){
                                map.panTo(bounds.getCenter()); 
                                map.setZoom(map.getBoundsZoomLevel(bounds)-1);
                            }

                            {/literal}{if !$privateData.datos.lat eq ""}{literal}
                                drawCircle(start, {/literal}{$privateData.datos.radius_interest}{literal}, 40);   
                                fit();
                            {/literal}{else}{literal}
                                $('#map').hide();
                            {/literal}{/if}{literal}

                        //]]>

                        </script>
                        {/literal}		
					</div>
					<div class="checkAlerts"><input id="alertsCheckBox" name="alertsCheckBox" {if $privateData.datos.radius_interest gt 0}checked="checked"{/if} type="checkbox"><span>RECIBIR ALERTAS | ZONAS INTERÉS</span></div>
						
						<div class="span-1 editRadio" id="editRadio">
							<div class="span-1 first radioBusqueda">
								<p class="data">RADIO DE BÚSQUEDA</p><p class="km">(Km)</p>
								<input type="text" name="inputRadio" id="inputRadio" class="inputRadio" value="{$privateData.datos.radius_interest}">
							</div>
							<div class="span-1 last radioInfo">
								<p class="dataRadio">Las alertas se enviarán semanalmente a tu dirección de email</p>
							</div>						
						</div>
					</div>
				</div>
				<div class="span-1 dataUserButtons">
					<span><input class="saveChangesButton" type="submit" name="action" value="Guardar cambios"/></span>
				</div>
				
				<p class="titulo tituloLeft tituloRight">TUS MARCAS</p>
				<div class="span-1 editmarcas">
					<div class="span-1 first distanceName">
						<p class="data">DISTANCIA</p>
						{foreach key=id item=record from=$records}
							<p>{$record.distance_name}</p>
						{/foreach}
					</div>
					<div class="span-1 last recordsContainer">
						<p class="data">HH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CTS</p>
						{foreach key=id item=record from=$records}
						<div class="recordContainer"> 
						<div class="span-1">
							<input type="text" id="rec_hh_{$record.id}" name="rec_hh_{$record.id}" value="{$record.time_taken|substr:0:2}" maxlength="2" class="roundInputRecords" onblur="javascript: va({$record.id});">
						</div>
						<div class="span-1">
							<input type="text" id="rec_mm_{$record.id}" name="rec_mm_{$record.id}" value="{$record.time_taken|substr:3:2}" maxlength="2" class="roundInputRecords" onblur="javascript: va({$record.id});">
						</div>
						<div class="span-1">
							<input type="text" id="rec_ss_{$record.id}" name="rec_ss_{$record.id}" value="{$record.time_taken|substr:6:2}" maxlength="2" class="roundInputRecords" onblur="javascript: va({$record.id});">
						</div>
						<div class="span-1">
							<input type="text" id="rec_dd_{$record.id}" name="rec_dd_{$record.id}" value="{$record.time_taken|substr:9:2}" maxlength="2" class="roundInputRecords" onblur="javascript: va({$record.id});">
						</div>	
						
						<div class="span-1 last deleteButtons"><input type="button" class="deleteButton" value="x" onclick="javascript: void borrarRecords(rec_hh_{$record.id},rec_mm_{$record.id},rec_ss_{$record.id},rec_dd_{$record.id})"></div>
						
						</div>				
						{/foreach}
					</div>
				</div>
				<div class="span-1 dataUserButtons">
					<span><input class="saveChangesButton" type="submit" name="action" value="Guardar cambios"/></span>
				</div>
				
				<p class="titulo tituloLeft tituloRight">DATOS DE CUENTA</p>
				<div class="span-1 editAcount" id="editAcount">
					<div class="span-1 editMail">
						<p class="data">EMAIL</p>
						<input type="text" name="inputMail" id="inputMail" class="inputMail" value="{$privateData.datos.email}">
						<span class="emailCheck" id="checkEmailBox">
                            <img style='display:none' id="emailImage">
                            <p id="result"></p>
                    	</span>
					</div>
					<div class="span-1 editPass">
						<p class="data">PASSWORD</p>
						<input type="password" name="inputPassword" id="inputPassword" class="inputPassword" value="{$privateData.datos.pass}">
					</div>
					<div class="span-1 editPass2">
						<p class="data">REPITE PASSWORD</p>
						<input type="password" name="inputPassword2" id="inputPassword2" class="inputPassword2" value="{$privateData.datos.pass}">
					</div>
				</div>
				<div class="span-1 dataUserButtons">
					<span>
					<div class="span-1 baja"><a href="javascript: void confirmationWindowUser()" >¿Quieres darte de baja?</a></div>			
					<input class="saveChangesButton" type="submit" name="action" value="Guardar cambios"/>
					</span>
				</div>
			</div>			
		</div>
	</div>
	</form>

	<!-- RIGHT COLUMN -->
	<div class="span-1 last rightColumn userRightColumn">
		{if $nextRaces}
		<div class="span-1 functionalContainerRight">
			<p class="titulo tituloLeft tituloColumnRight">TUS PRÓXIMAS CARRERAS</p>
			<div class="events">
				{foreach key=id item=race from=$nextRaces name=raceloop}	    				    
					<div class="span-1 {cycle values="raceRight,raceRight2"}">
						<div class="span-1 first dateRight calendarRight">
					        <div class="month month{$race.run_type}">{getMonth month=$race.event_date|substr:5:2}</div>
							<div class="day">{$race.event_date|substr:8:2}</div>
						</div>
						{if $race.num_users > 0}
							<div class="ticketBlue"><p>{$race.num_users}</p></div>
							<div class="ticketBlueCorner ticketBlueCornerRight"></div>
						{/if}		
						<div class="span-1 last dataRaceRight">
							<div class="nameRaceRight"><a id="nameRunRight1{$smarty.foreach.raceloop.iteration}" href="/run/{$race.id}/{$race.name|seourl}">{$race.name}</a></div>
							<div class="dataRaceRight"><p>{$race.event_location} | {$race.distance_text}</p></div>
						</div>	
					</div>
					<div class="span-1 last separatorRight"></div>
			    {/foreach}					
			</div>
		</div>
		{/if}
		
		<div class="span-1 functionalContainerRight">
			<p class="titulo tituloLeft tituloColumnRight">CARRERAS APUNTADAS</p>
			<div id="map" class="mapStyleRight">
	            <object id="aroundMap" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="254" height="192">
				  <param name="flashvars" value="id={$smarty.session.user.id}&amp;mapkey={$smarty.const.GMAPS_KEY}" />
				  <param name="wmode" value="opaque" />
	              <param name="movie" value="/flash/UserRacesMap.swf?7" />
	              <!--[if !IE]>-->
	              <object type="application/x-shockwave-flash" data="/flash/UserRacesMap.swf?7" width="254" height="192" flashvars="id={$smarty.session.user.id}&amp;mapkey={$smarty.const.GMAPS_KEY}">
	              <!--<![endif]-->
	              <!--[if !IE]>-->
	              </object>
	              <!--<![endif]-->
	            </object>						
			</div>
		</div>
		
		{if $friends}
		<div class="span-1 functionalContainerRight">
			<p class="titulo tituloLeft tituloColumnRight">USUARIOS A LOS QUE SIGUES</p>
			<div class="events">
				<div class="avatarContainer">
				{foreach key=id item=friend from=$friends}
					<a href="/user/{$friend.username}"><img class="avatarRight" src="/avatar.php?id={$friend.id}&type=s"/>
						<div class="hidden">{$friend.username}</div>
					</a>
			  {/foreach}
			    </div>
			</div>
		</div>		
		{/if}
						
	</div>

</div> <!-- content -->

</div> <!-- container -->

{include file="footer.tpl"} 