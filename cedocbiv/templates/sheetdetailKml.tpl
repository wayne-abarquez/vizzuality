<?xml version="1.0" encoding="LATIN-1"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
<Document>
	<name>Location of {$data.UnitID}</name>
	<open>1</open>
	<Style>
	</Style>
    <Style id="normalPlacemark">
      <IconStyle>
        <Icon>
          <href>http://www.runnity.com/Widgets/bigmarker_up.png</href>
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
			<width>0.6</width>
		</LineStyle>
		<PolyStyle>
			<fill>0</fill>
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
			<width>0.1</width>
		</LineStyle>
		<PolyStyle>
			<fill>0</fill>
		</PolyStyle>
	</Style>
	<StyleMap id="m_ylw-pushpin_copy0">
		<Pair>
			<key>normal</key>
			<styleUrl>#s_ylw-pushpin</styleUrl>
		</Pair>
		<Pair>
			<key>highlight</key>
			<styleUrl>#s_ylw-pushpin_hl</styleUrl>
		</Pair>
	</StyleMap>
	<Placemark>
		<name>{$data.UnitID} - {$data.NameAuthorYearString}</name>
		<description>{$data.LocalityText} - {$data.BiotopeText}</description>
		{if $isUtm}
			<styleUrl>#m_ylw-pushpin_copy0</styleUrl>
			<Polygon>
				<outerBoundaryIs>
					<LinearRing>
						<coordinates>{$data.coords|trim}</coordinates>
					</LinearRing>
				</outerBoundaryIs>
			</Polygon>
		{else}
			<styleUrl>#normalPlacemark</styleUrl>
		    <Point>
		      <coordinates>{$data.LongitudeDecimal},{$data.LatitudeDecimal},0</coordinates>
		    </Point>			
		{/if}
	</Placemark>
</Document>
</kml>
