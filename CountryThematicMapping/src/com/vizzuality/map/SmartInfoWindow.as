package com.vizzuality.map {
  import com.google.maps.LatLng;
  import com.google.maps.Map;
  import com.google.maps.styles.FillStyle;
  import com.google.maps.styles.StrokeStyle;
  
  import flash.display.DisplayObject;
  import flash.display.Graphics;
  import flash.display.Sprite;
  import flash.geom.Point;
  import flash.geom.Rectangle;
	
  public class SmartInfoWindow extends Sprite {
    [Embed(source = "assets/close.png")]
    private var CloseButtonImage:Class;
    
  	public static const ABOVE:int = 0;
  	public static const BELOW:int = 1;
  	public static const RIGHTTOP:int = 2;
  	public static const RIGHTBOTTOM:int = 3;
  	public static const RIGHTCENTRE:int = 4;
  	public static const LEFTTOP:int = 5;
  	public static const LEFTCENTRE:int = 6;
  	public static const LEFTBOTTOM:int = 7;
  	
  	private var content:DisplayObject;
  	private var contentOffset:Point;
  	
    private var positionValue:int = ABOVE;
    private var paddingValue:int = 0;
    private var cornerRadiusValue:int = 5;
    private var anchorSizeValue:int = 10;
    private var fillStyleValue:FillStyle = null;
    private var strokeStyleValue:StrokeStyle = null;
    
    private var anchorPointValue:Point = null;
    private var closeButton:DisplayObject = null;
  	
	public function SmartInfoWindow() {
      super();
      closeButton = new CloseButtonImage();
      addChild(closeButton);
	}
	
	public function setContent(content:DisplayObject):void {
	  if (this.content != null) {
	  	removeChild(this.content);
	  }
      
      this.content = content;
      addChild(this.content);
      setChildIndex(closeButton, numChildren - 1);
	}
	
	public function render():void {
	  var left:int = 0;
	  var top:int = 0;
	  var right:int = 2 * padding + content.width;
	  //var bottom:int = 2 * padding + content.height;
	  var bottom:int = 103;
	  
	  switch (position) {
	    case ABOVE:
          anchorPointValue = new Point((left + right) / 2, bottom + anchorSize);
          position = ABOVE;
          break;
	  	case BELOW:
	  	  top += anchorSize;
	  	  bottom += anchorSize;
	  	  anchorPointValue = new Point((left + right) / 2, 0);
	  	  break; 
        case RIGHTTOP:
          left += anchorSize;
          right += anchorSize;
          anchorPointValue = new Point(0, cornerRadius + 2 * anchorSize);
          break;
        case RIGHTCENTRE:
          left += anchorSize;
          right += anchorSize;
          anchorPointValue = new Point(0, (top + bottom) / 2);
          break;
        case RIGHTBOTTOM:
          left += anchorSize;
          right += anchorSize;
          anchorPointValue = new Point(0, bottom - cornerRadius - 2 * anchorSize);
          break;
        case LEFTTOP:
          anchorPointValue = new Point(right + anchorSize, cornerRadius + 2 * anchorSize);
          break;
        case LEFTCENTRE:
          anchorPointValue = new Point(right + anchorSize, (top + bottom) / 2);
          break;
        case LEFTBOTTOM:
          anchorPointValue = new Point(right + anchorSize, bottom - cornerRadius - 2 * anchorSize);
          break;
      }
      
      content.x = left + padding;
      content.y = top + padding;
      closeButton.x = right - cornerRadius - closeButton.width;
      closeButton.y = top + cornerRadius;
      
      graphics.clear();
      graphics.lineStyle(Number(strokeStyle.thickness), 
                         Number(strokeStyle.color), 
                         Number(strokeStyle.alpha),
                         Boolean(strokeStyle.pixelHinting));
      graphics.beginFill(Number(fillStyle.color), 
                         Number(fillStyle.alpha));
      
      graphics.moveTo(left + cornerRadius, top);
      
      drawLine(graphics, 
               new Point(left + cornerRadius, top),
               new Point(right - cornerRadius, top),
               (position == BELOW) ? anchorPoint : null);
               
      graphics.curveTo(right, top, right, top + cornerRadius);
      
      drawLine(graphics, 
               new Point(right, cornerRadius),
               new Point(right, bottom - cornerRadius),
               (position == LEFTTOP || position == LEFTBOTTOM || position == LEFTCENTRE) ? anchorPoint : null);
               
      graphics.curveTo(right, bottom, right - cornerRadius, bottom);
      
      drawLine(graphics, 
               new Point(right - cornerRadius, bottom),
               new Point(left + cornerRadius, bottom), 
               (position == ABOVE) ? anchorPoint : null);
               
      graphics.curveTo(left, bottom, left, bottom - cornerRadius);
      
      drawLine(graphics,
               new Point(left, bottom - cornerRadius),
               new Point(left, top + cornerRadius),
               (position == RIGHTTOP || position == RIGHTBOTTOM || position == RIGHTCENTRE) ? anchorPoint : null);
               
      graphics.curveTo(left, top, left + cornerRadius, top);
      
      graphics.endFill();
	}
	
	private function sign(value:Number):int {
	  if (value > 0) return 1;
	  if (value < 0) return -1;
	  return 0;
	}
	
	private function drawLine(graphics:Graphics,
	                          fromPoint:Point,
	                          toPoint:Point,
	                          anchorPoint:Point):void {
      if (anchorPoint == null) {
        graphics.lineTo(toPoint.x, toPoint.y);
        return;
      }
      
      var anchorStart:Point = 
          new Point(anchorPoint.x - anchorSize * sign(anchorPoint.x - fromPoint.x), 
                    anchorPoint.y - anchorSize * sign(anchorPoint.y - fromPoint.y));
      var anchorEnd:Point = 
          new Point(anchorPoint.x - anchorSize * sign(anchorPoint.x - toPoint.x), 
                    anchorPoint.y - anchorSize * sign(anchorPoint.y - toPoint.y));
                                      
      graphics.lineTo(anchorStart.x, anchorStart.y);
      graphics.lineTo(anchorPoint.x, anchorPoint.y);
      graphics.lineTo(anchorEnd.x, anchorEnd.y);
      graphics.lineTo(toPoint.x, toPoint.y);                                      
	}
	
	private var alignments:Array = [
      SmartInfoWindow.ABOVE,
      SmartInfoWindow.LEFTCENTRE,
      SmartInfoWindow.RIGHTCENTRE,
      SmartInfoWindow.BELOW,
      SmartInfoWindow.LEFTTOP,
      SmartInfoWindow.RIGHTTOP,
      SmartInfoWindow.LEFTBOTTOM,
      SmartInfoWindow.RIGHTBOTTOM
    ];
    
    public function getBestAlignment(map:Map, latLng:LatLng, contentSize:Point):int {
      var bestAlignment:int = alignments[0]; 
      var minPan:Number = 1e+30;
      
      for each (var alignment:int in alignments) {
        var panValue:Number = getPanValue(map, alignment, latLng, contentSize);
        if (panValue < minPan) {
          minPan = panValue;
          bestAlignment = alignment;
        }       
      }
      
      return bestAlignment;
    } 
    
    public static function getPanValue(map:Map, pan:int, latLng:LatLng, contentSize:Point):Number {
      var mapSize:Point = map.getSize();
      var latLngPoint:Point = map.fromLatLngToViewport(latLng, false);
      var approximateFocusPoint:Point;

      switch (pan) {
        case SmartInfoWindow.ABOVE:
          approximateFocusPoint = new Point(contentSize.x / 2, contentSize.y);
          break;
        case SmartInfoWindow.BELOW:
          approximateFocusPoint = new Point(contentSize.x / 2, 0);
          break;
        case SmartInfoWindow.RIGHTCENTRE:
          approximateFocusPoint = new Point(0, contentSize.y / 2);
          break;
        case SmartInfoWindow.LEFTCENTRE:
          approximateFocusPoint = new Point(contentSize.x, contentSize.y / 2);
          break;
        case SmartInfoWindow.RIGHTTOP:
          approximateFocusPoint = new Point(0, 0);
          break;
        case SmartInfoWindow.LEFTTOP:
          approximateFocusPoint = new Point(contentSize.x, 0);
          break;
        case SmartInfoWindow.RIGHTBOTTOM:
          approximateFocusPoint = new Point(0, contentSize.y);
          break;
        case SmartInfoWindow.LEFTBOTTOM:
          approximateFocusPoint = new Point(contentSize.x, contentSize.y);
          break;
      }
      
      var left:Number = Math.min(0, latLngPoint.x - approximateFocusPoint.x);
      var right:Number = Math.min(0, mapSize.x - latLngPoint.x - contentSize.x + approximateFocusPoint.x);
      var up:Number = Math.min(0, latLngPoint.y - approximateFocusPoint.y);
      var down:Number = Math.min(0, mapSize.y - latLngPoint.y - contentSize.y + approximateFocusPoint.y);
      
      return left * left + right * right + up * up + down * down;
    }
    
	public function get position():int {
	  return this.positionValue;
	}
	public function set position(value:int):void {
	  this.positionValue = value;
	}
	
	public function get padding():int {
	  return this.paddingValue;	
	}
	public function set padding(value:int):void {
	  this.paddingValue = value;
	}
	
	public function get fillStyle():FillStyle {
	  return this.fillStyleValue;
	}
	public function set fillStyle(value:FillStyle):void {
	  this.fillStyleValue = value;
	}
	
	public function get strokeStyle():StrokeStyle {
	  return this.strokeStyleValue;
	}
	public function set strokeStyle(value:StrokeStyle):void {
	  this.strokeStyleValue = value;
	}
	
	public function get cornerRadius():int {
	  return this.cornerRadiusValue;
	}
	public function set cornerRadius(value:int):void {
	  this.cornerRadiusValue = value;	
	}
	
	public function get anchorSize():int {
	  return this.anchorSizeValue;
	}
	public function set anchorSize(value:int):void {
	  this.anchorSizeValue = value;
	}
	
	public function get anchorPoint():Point {
	  return this.anchorPointValue;
	}
	public function get closeButtonRect():Rectangle {
	  return new Rectangle(closeButton.x, closeButton.y, 
	                       closeButton.width, closeButton.height);
	}
  }
}