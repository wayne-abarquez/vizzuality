package com.vizzuality.view.map.markers
{
	import com.enefekt.tubeloc.MovieSprite;
	import com.enefekt.tubeloc.event.*;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	public class YoutubeSprite extends Sprite {
		private var youtubeMovie:MovieSprite;

		public function YoutubeSprite() {
			
		}
		
		public function loadVideo(id:String):void {
			youtubeMovie = new MovieSprite(id);
			youtubeMovie.addEventListener(PlayerReadyEvent.PLAYER_READY, onPlayerReady);
			youtubeMovie.x = 0;
			youtubeMovie.y = 0;
			addChild(youtubeMovie);
			
		}

		private function onPlayerReady(event_p:PlayerReadyEvent):void {
			youtubeMovie.width = 300;
			youtubeMovie.height = 200 + MovieSprite.CHROME_HEIGHT;
		}
	}
}
