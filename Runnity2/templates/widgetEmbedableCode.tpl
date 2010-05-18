<div style="width:610px; height:470px; position:relative; float:left; border:1px solid #CCCCCC; background-color:#FFFFFF;">	
<p style="float:left; font:bold 18px Arial; color:#006599; width:475px; margin:10px 0 0 10px;">{$data.name}</p>
<div style="float:right; width:110px; margin:0 5px 0 0;">
<p style="float:right; font:normal 11px Arial; color:#006599; width:85px; margin:10px 5px 0 0;">más carreras en</p>
<a href="http://www.runnity.com" style="float:right; background:url(http://www.runnity.com/img/logoRunnityWidget.png) no-repeat 0 0; width:99px; height:33px; margin:2px 5px 0 0;"></a>
</div>
<p style="float:left; font:normal 13px Arial; color:#999999; margin:0px 0 0 10px;">{$data.distance_text}</p><p style="float:left; font:normal 13px Arial; color:#999999; margin:0px 4px;"> | </p>
<p style="float:left; font:normal 13px Arial; color:#999999; margin:0px 0 0 0px;">{$data.province_name}</p>
<div style="float:left; margin:5px; width:600px; height:400px;">
<object id="flashMovie" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="600" height="400">
<param name="flashvars" value="id={$data.id}&amp;mapkey={$smarty.const.GMAPS_KEY}">
<param name="wmode" value="opaque">
<param name="movie" value="http://www.runnity.com/flash/raceMapViewer.swf?2" />
<!--[if !IE]>-->
<object type="application/x-shockwave-flash" data="http://www.runnity.com/flash/raceMapViewer.swf" width="600" height="400" flashvars="id={$data.id}&amp;mapkey={$smarty.const.GMAPS_KEY}">
<!--<![endif]-->
<!--[if !IE]>-->
</object>
<!--<![endif]-->
</object>
</div>
</div>
