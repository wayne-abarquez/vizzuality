package com.vizzuality.view.map.overlays {

import com.google.maps.Color;
import com.google.maps.LatLng;
import com.google.maps.MapEvent;
import com.google.maps.PaneId;
import com.google.maps.interfaces.IMap;
import com.google.maps.interfaces.IPane;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class PaTitleMarkerIcon extends Sprite {
  private var latLng:LatLng;
  private var label:String;
  private var textField:TextField;


  public function PaTitleMarkerIcon(label:String) {
    super();
    this.label = label;
    this.addEventListener(MouseEvent.ROLL_OVER,onRollOver,false,0,true);
    this.addEventListener(MouseEvent.ROLL_OUT,onRollOut,false,0,true);
    
    this.textField = new TextField();
    this.textField.text = this.label;
    this.textField.selectable = false;
    this.textField.background = true;
    this.textField.multiline = true;
    this.textField.textColor = 0xFFFFFF;
    this.textField.autoSize = TextFieldAutoSize.CENTER;
    this.textField.backgroundColor = 0x333333;
    this.textField.setTextFormat(new TextFormat("Arial",12,Color.WHITE));
    this.addChild(textField);
    
  }
  
  private function onRollOver(event:MouseEvent):void {
  	this.textField.backgroundColor = 0xFD3F16;
  }
  private function onRollOut(event:MouseEvent):void {
  	this.textField.backgroundColor = 0x333333;
  	
  }
  
}
}