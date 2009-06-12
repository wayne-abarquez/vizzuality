<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>Polygon styled in color by status</Name>
    <UserStyle>
      <Title>Polygon styled by status</Title>
      <Abstract>Based on a check on the status, the polygon is colored</Abstract>
      <FeatureTypeStyle>
        
        <!-- Status: 0 -->
        <Rule>
          <Title>Status: 0</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>status</ogc:PropertyName>
                <ogc:Literal>0</ogc:Literal>
           </ogc:PropertyIsEqualTo>
         </ogc:Filter>
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#FB75D2</CssParameter>
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#333333</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
        </Rule>


        <!-- Status: none
          Same as status: 0
         -->
        <Rule>
          <Title>Status: 0</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>status</ogc:PropertyName>
                <ogc:Literal>0</ogc:Literal>
           </ogc:PropertyIsEqualTo>
         </ogc:Filter>
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#FB75D2</CssParameter>
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#333333</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
        </Rule>
        
    <!-- Status: general distribution  
    	Same as status: 0
         -->
        <Rule>
        <Title>Status: general distribution</Title>
         <ogc:Filter>
            <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>status</ogc:PropertyName>
                <ogc:Literal>general distribution</ogc:Literal>
           </ogc:PropertyIsEqualTo>
         </ogc:Filter>
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#FB75D2</CssParameter>
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#333333</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
        </Rule>        


    <!-- Status: all year round -->
        <Rule>
        <Title>Status: all year round</Title>
         <ogc:Filter>
            <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>status</ogc:PropertyName>
                <ogc:Literal>all year round</ogc:Literal>
           </ogc:PropertyIsEqualTo>
         </ogc:Filter>
          <PolygonSymbolizer>
            <Fill>
				<CssParameter name="fill">#FB40D8</CssParameter>
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#333333</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
        </Rule>

 
    <!-- Status: breeding -->
        <Rule>
        <Title>Status: breeding</Title>
         <ogc:Filter>
            <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>status</ogc:PropertyName>
                <ogc:Literal>breeding</ogc:Literal>
           </ogc:PropertyIsEqualTo>
         </ogc:Filter>
          <PolygonSymbolizer>
            <Fill>
				<CssParameter name="fill">#E900BC</CssParameter>
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#333333</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
        </Rule>

 
    <!-- Status: feeding, wintering -->
        <Rule>
        <Title>Status: feeding, wintering</Title>
         <ogc:Filter>
            <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>status</ogc:PropertyName>
                <ogc:Literal>feeding, wintering</ogc:Literal>
           </ogc:PropertyIsEqualTo>
         </ogc:Filter>
          <PolygonSymbolizer>
            <Fill>
				<CssParameter name="fill">#36B1EA</CssParameter>
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#333333</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
        </Rule>

 


 
    <!-- Status: moulting -->
        <Rule>
        <Title>Status: moulting</Title>
         <ogc:Filter>
            <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>status</ogc:PropertyName>
                <ogc:Literal>moulting</ogc:Literal>
           </ogc:PropertyIsEqualTo>
         </ogc:Filter>
          <PolygonSymbolizer>
            <Fill>
				<CssParameter name="fill">#6D059A</CssParameter>
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#333333</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
        </Rule>


    <!-- Status:  non breeding summer -->
        <Rule>
        <Title>Status: non breeding summer</Title>
         <ogc:Filter>
            <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>status</ogc:PropertyName>
                <ogc:Literal>non breeding summer</ogc:Literal>
           </ogc:PropertyIsEqualTo>
         </ogc:Filter>
          <PolygonSymbolizer>
            <Fill>
				<CssParameter name="fill">#F4C410</CssParameter>
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#333333</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
        </Rule>


    <!-- Status: prior wintering area -->
        <Rule>
        <Title>Status: prior wintering area</Title>
         <ogc:Filter>
            <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>status</ogc:PropertyName>
                <ogc:Literal>prior wintering area</ogc:Literal>
           </ogc:PropertyIsEqualTo>
         </ogc:Filter>
          <PolygonSymbolizer>
            <Fill>
				<CssParameter name="fill">#2C6DDD</CssParameter>
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#333333</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
        </Rule>

 
    <!-- Status: resident -->
        <Rule>
        <Title>Status: resident</Title>
         <ogc:Filter>
            <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>status</ogc:PropertyName>
                <ogc:Literal>resident</ogc:Literal>
           </ogc:PropertyIsEqualTo>
         </ogc:Filter>
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#052383</CssParameter>
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#333333</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
        </Rule>

 
    <!-- Status: sightings -->
        <Rule>
        <Title>Status: sightings</Title>
         <ogc:Filter>
            <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>status</ogc:PropertyName>
                <ogc:Literal>sightings</ogc:Literal>
           </ogc:PropertyIsEqualTo>
         </ogc:Filter>
          <PolygonSymbolizer>
            <Fill>
				<CssParameter name="fill">#3876E4</CssParameter>
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#333333</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
        </Rule>


    <!-- Status: staging areas -->
        <Rule>
        <Title>Status: staging areas</Title>
         <ogc:Filter>
            <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>status</ogc:PropertyName>
                <ogc:Literal>staging areas</ogc:Literal>
           </ogc:PropertyIsEqualTo>
         </ogc:Filter>
          <PolygonSymbolizer>
            <Fill>
				<CssParameter name="fill">#EA5E0A</CssParameter>
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#333333</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
        </Rule>

      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
