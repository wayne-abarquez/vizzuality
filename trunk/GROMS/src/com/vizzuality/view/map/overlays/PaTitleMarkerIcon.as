package com.vizzuality.view.map.overlays {

import com.google.maps.Color;
import com.vizzuality.view.AppStates;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class PaTitleMarkerIcon extends Sprite {
  private var label:String;
  private var siteId:Number;
  private var textField:TextField;


  public function PaTitleMarkerIcon(label:String,site_id:Number) {
    super();
    this.label = label;
    this.siteId=site_id;
    this.addEventListener(MouseEvent.ROLL_OVER,onRollOver,false,0,true);
    this.addEventListener(MouseEvent.ROLL_OUT,onRollOut,false,0,true);
    this.addEventListener(MouseEvent.CLICK,onClick,false,0,true);
    
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
  
  private function onClick(event:MouseEvent):void {
  	AppStates.gi().setAllStates(AppStates.PA,this.siteId.toString())
  }
  
}
}