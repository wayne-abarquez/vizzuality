package com.vizzuality.elecciones.map
{
	import com.google.maps.LatLng;
	import com.google.maps.PaneId;
	import com.google.maps.interfaces.IMap;
	import com.google.maps.interfaces.IPane;
	import com.google.maps.overlays.OverlayBase;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class PolygonsOverlay extends OverlayBase
	{
		
		public var vertexPoints:Array;
		private var firstvertexPoint:Point;
		private var polygonsSprite:Sprite;
		
		public function PolygonsOverlay()
		{
			super();
		}
		
		override public function positionOverlay(zoomChange:Boolean):void {
			
			if ( !vertexPoints ) 
				return;
			
			if ( !polygonsSprite ) {
				polygonsSprite = new Sprite();
				addChild( polygonsSprite );
				drawPolygon();
			} else {
				if ( zoomChange ) {
					drawPolygon();
				} else {
					
					movePolygonToNewPosition();
					
				}
			}
			
		}
		
		override public function getDefaultPane(arg0:IMap):IPane {
			
			return arg0.getPaneManager().getPaneById( PaneId.PANE_OVERLAYS );
			
		}
		
		private function drawPolygon() : void {
			polygonsSprite.x = 0;
			polygonsSprite.y = 0;
			
			var g:Graphics = polygonsSprite.graphics;
			g.clear();
			
			g.beginFill(0xFF0000,.4);
			g.lineStyle( 3, 0x000000, 1 );
			
			var paneLeftCornerCoords:Point = pane.fromProjectionPointToPaneCoords(new Point(0,0));
			
			
			//var p : Point = pane.fromLatLngToPaneCoords( vertexPoints[ 0 ] );
			var p:Point = new Point(vertexPoints[0].x-paneLeftCornerCoords.x, 
				vertexPoints[0].y -paneLeftCornerCoords.y);
			trace(paneLeftCornerCoords);
			
			
			firstvertexPoint = p;
			g.moveTo( p.x, p.y );
			
			for ( var i : int = 1; i < vertexPoints.length; i++ ) {
				//p = pane.fromLatLngToPaneCoords( LatLng( vertexPoints[ i ] ) );
				p = new Point(vertexPoints[i].x-paneLeftCornerCoords.x, 
					vertexPoints[i].y -paneLeftCornerCoords.y);
				g.lineTo( p.x, p.y );
			}
			g.endFill();
		}
		
		
		private function movePolygonToNewPosition() : void {
			//var newFirstPoint : Point = pane.fromLatLngToPaneCoords( vertexPoints[ 0 ] );
			var paneLeftCornerCoords:Point = pane.fromPaneCoordsToProjectionPoint(new Point(0,0));
			var newFirstPoint:Point = new Point(vertexPoints[0].x-paneLeftCornerCoords.x, 
				vertexPoints[0].y -paneLeftCornerCoords.y);
				
			var delta : Point = new Point( newFirstPoint.x - firstvertexPoint.x, newFirstPoint.y - firstvertexPoint.y );
			polygonsSprite.x = polygonsSprite.x + delta.x;
			polygonsSprite.y = polygonsSprite.y + delta.y;
			firstvertexPoint = newFirstPoint;
			
		}		
		
	}
}