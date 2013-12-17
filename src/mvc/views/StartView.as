package mvc.views
{
	import flash.events.MouseEvent;
	
	import mvc.Controller;
	import mvc.Model;
	
	import views.Start_MC;
	
	public class StartView extends Start_MC
	{
		private var model:Model;
		private var controller:Controller;
		
		public function StartView(aModel:Model, aController:Controller)
		{
			model = aModel;
			controller = aController;
		}
		
		public function init():void
		{			
			start_btn.addEventListener(MouseEvent.CLICK, startBtnClicked);
		}
		
		private function startBtnClicked(event:MouseEvent):void
		{
			start_btn.removeEventListener(MouseEvent.CLICK, startBtnClicked);
			
			controller.openSoundExample();
		}
		
		public function dispose():void
		{
			start_btn.removeEventListener(MouseEvent.CLICK, startBtnClicked);
			
			model = null;
			controller = null;
		}
	}
}