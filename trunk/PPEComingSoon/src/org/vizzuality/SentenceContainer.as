package org.vizzuality{
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class SentenceContainer extends Sprite{
		
		private var t:TextField = new TextField();
		
		[Embed( source="/fonts/LucidaGrande.swf", fontFamily="Lucida Grande" )]
		public static var LucidaGrande:Class;
		
		[Embed(source="assets/facebookButton_up.png")]
		private var FacebookButton_up:Class;
		[Embed(source="assets/facebookButton_over.png")]
		private var FacebookButton_over:Class;
		
		[Embed(source="assets/twitterButton_up.png")]
		private var TwitterButton_up:Class;
		[Embed(source="assets/twitterButton_over.png")]
		private var TwitterButton_over:Class;
		
		private var textGlow:GlowFilter = new GlowFilter(0x000000,.2,5,5,2,2);
		public var sentence:String = 'Only the 4% of the earth is allready protected';
		
		
		public function SentenceContainer(){
			super();

			var tf:TextFormat = new TextFormat();
			tf.size = 18;
			tf.align = TextFormatAlign.CENTER;
			tf.font = "Lucida Grande";
			tf.letterSpacing= -1;

			t.defaultTextFormat = tf;
			t.text = "''Lorem ipsum dolor sit amen dolor sit''";
			t.textColor = 0xFFFFFF;
			t.width = 600;
			t.selectable = false;
			t.filters = [textGlow];
			this.addChild(t);
			
			var bf:Sprite = new Sprite()
			bf.x = 270;
			bf.y = 30;
			bf.addEventListener(MouseEvent.ROLL_OVER,function ():void {fb_over.visible = true});
			bf.addEventListener(MouseEvent.ROLL_OUT,function ():void {fb_over.visible = false});
			bf.addEventListener(MouseEvent.CLICK,function ():void {navigateToURL(new URLRequest('http://www.facebook.com/share.php?u=http://www.protectplanetearth.org'))});
			bf.buttonMode = true;
			bf.useHandCursor = true;
			bf.mouseChildren = false;
			var fb_up:Bitmap = new FacebookButton_up();
			bf.addChild(fb_up);
			var fb_over:Bitmap = new FacebookButton_over();
			fb_over.visible = false;
			bf.addChild(fb_over);
			this.addChild(bf);
			
			var tw:Sprite = new Sprite()
			tw.x = 300;
			tw.y = 30;
			tw.addEventListener(MouseEvent.ROLL_OVER,function ():void {tw_over.visible = true});
			tw.addEventListener(MouseEvent.ROLL_OUT,function ():void {tw_over.visible = false});
			tw.addEventListener(MouseEvent.CLICK,function ():void {navigateToURL(new URLRequest('http://twitter.com/home?status='+sentence+'-> http://www.protectplanetearth.org'))});
			tw.buttonMode = true;
			tw.useHandCursor = true;
			tw.mouseChildren = false;
			var tw_up:Bitmap = new TwitterButton_up();
			tw.addChild(tw_up);
			var tw_over:Bitmap = new TwitterButton_over();
			tw_over.visible = false;
			tw.addChild(tw_over);
			this.addChild(tw);			
			
		}
		
	}
}