<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
<Document>
	<name>Location of {$taxon[0].NameAuthorYearString}</name>
	<open>1</open>
    <Style id="normalPlacemark">
      <IconStyle>
        <Icon>
          <href>{$smarty.const.SERVER_URL}images/bigmarker.png</href>
        </Icon>
      </IconStyle>
    </Style>		
	<Style id="s_ylw-pushpin">
		<IconStyle>
			<scale>1.1</scale>
			<Icon>
				<href>http://maps.google.com/mapfiles/kml/pushpin/ylw-pushpin.png</href>
			</Icon>
			<hotSpot x="20" y="2" xunits="pixels" yunits="pixels"/>
		</IconStyle>
		<LineStyle>
			<color>ff4dc0ff</color>
			<width>2</width>
		</LineStyle>
		<PolyStyle>
			<color>804dc0ff</color>
		</PolyStyle>
	</Style>
	<Style id="s_ylw-pushpin_hl">
		<IconStyle>
			<scale>1.3</scale>
			<Icon>
				<href>http://maps.google.com/mapfiles/kml/pushpin/ylw-pushpin.png</href>
			</Icon>
			<hotSpot x="20" y="2" xunits="pixels" yunits="pixels"/>
		</IconStyle>
		<LineStyle>
			<color>ff4dc0ff</color>
			<width>2</width>
		</LineStyle>
		<PolyStyle>
			<color>804dc0ff</color>
		</PolyStyle>
	</Style>
	<StyleMap id="m_ylw-pushpin">
		<Pair>
			<key>normal</key>
			<styleUrl>#s_ylw-pushpin</styleUrl>
		</Pair>
		<Pair>
			<key>highlight</key>
			<styleUrl>#s_ylw-pushpin_hl</styleUrl>
		</Pair>
	</StyleMap>
	{foreach key=UnitID item=result from=$data}
	    {if ($result.LatitudeDecimal != '' || $result.LongitudeDecimal != '') || $result.coords != ''}
    	<Placemark>
    		<name>{$result.UnitID} - {$result.NameAuthorYearString}</name>
    		<description>{$result.LocalityText} - {$result.BiotopeText}</description>
    		{if ($result.LatitudeDecimal != '' || $result.LongitudeDecimal != '')}
    			<styleUrl>#normalPlacemark</styleUrl>
    		    <Point>
    		      <coordinates>{$result.LongitudeDecimal},{$result.LatitudeDecimal},0</coordinates>
    		    </Point>    		
  
    		{else}
  			    <styleUrl>#m_ylw-pushpin</styleUrl>
    			<Polygon>
    				<outerBoundaryIs>
    					<LinearRing>
    						<coordinates>{$result.coords}</coordinates>
    					</LinearRing>
    				</outerBoundaryIs>
    			</Polygon>		
    		{/if}
	</Placemark>
	{/if}
	{/foreach}
</Document>
</kml>
