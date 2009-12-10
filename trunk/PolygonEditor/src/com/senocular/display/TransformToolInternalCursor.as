package com.senocular.display
{
	import flash.events.Event;
	import flash.geom.Point;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.display.Sprite;
	import com.senocular.events.TransformEvent;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	
	public class TransformToolInternalCursor extends TransformToolCursor {
		
		public var offset:Point = new Point();
		public var icon:Sprite = new Sprite();
		
		public function TransformToolInternalCursor() {
			addChild(icon);
			offset = _mouseOffset;
			addEventListener(TransformEvent.CONTROL_INIT, init);
		}
			
		private function init(event:Event):void {
			_transformTool.addEventListener(TransformEvent.NEW_TARGET, maintainTransform);
			_transformTool.addEventListener(TransformEvent.CONTROL_PREFERENCE, maintainTransform);
			draw();
		}
		
		protected function maintainTransform(event:Event):void {
			offset = _mouseOffset;
			if (_transformTool.maintainControlForm) {
				transform.matrix = new Matrix();
				var concatMatrix:Matrix = transform.concatenatedMatrix;
				concatMatrix.invert();
				transform.matrix = concatMatrix;
				offset = concatMatrix.deltaTransformPoint(offset);
			}
			updateVisible(event);
		}
		
		protected function drawArc(originX:Number, originY:Number, radius:Number, angle1:Number, angle2:Number, useMove:Boolean = true):void {
			var diff:Number = angle2 - angle1;
			var divs:Number = 1 + Math.floor(Math.abs(diff)/(Math.PI/4));
			var span:Number = diff/(2*divs);
			var cosSpan:Number = Math.cos(span);
			var radiusc:Number = cosSpan ? radius/cosSpan : 0;
			var i:int;
			if (useMove) {
				icon.graphics.moveTo(originX + Math.cos(angle1)*radius, originY - Math.sin(angle1)*radius);
			}else{
				icon.graphics.lineTo(originX + Math.cos(angle1)*radius, originY - Math.sin(angle1)*radius);
			}
			for (i=0; i<divs; i++) {
				angle2 = angle1 + span;
				angle1 = angle2 + span;
				icon.graphics.curveTo(
					originX + Math.cos(angle2)*radiusc, originY - Math.sin(angle2)*radiusc,
					originX + Math.cos(angle1)*radius, originY - Math.sin(angle1)*radius
				);
			}
		}
		
		protected function getGlobalAngle(vector:Point):Number {
			var globalMatrix:Matrix = _transformTool.globalMatrix;
			vector = globalMatrix.deltaTransformPoint(vector);
			return Math.atan2(vector.y, vector.x) * (180/Math.PI);
		}
		
		override public function position(event:Event = null):void {
			if (parent) {
				x = parent.mouseX + offset.x;
				y = parent.mouseY + offset.y;
			}
		}
		
		public function draw(rot:int = 0):void {
			icon.graphics.lineStyle(1, 0x000000, 1, true, "normal", CapsStyle.NONE, JointStyle.MITER, 3);
			icon.graphics.beginFill(0xFFFFFF);
		}
	}
}