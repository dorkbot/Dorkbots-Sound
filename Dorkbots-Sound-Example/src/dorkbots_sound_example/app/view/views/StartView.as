package dorkbots_sound_example.app.view.views
{
	import com.dayvid.mvc.ISpriteView;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class StartView extends Start_MC implements ISpriteView
	{
		public function StartView()
		{
			
		}
		
		public function init():void
		{			
			start_btn.addEventListener(MouseEvent.CLICK, startBtnClicked);
		}
		
		private function startBtnClicked(event:MouseEvent):void
		{
			start_btn.removeEventListener(MouseEvent.CLICK, startBtnClicked);
			this.dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		public function dispose():void
		{
			start_btn.removeEventListener(MouseEvent.CLICK, startBtnClicked);
		}
	}
}