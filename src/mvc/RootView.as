package mvc
{
	import flash.display.DisplayObjectContainer;
	
	import dorkbots.dorkbots_broadcasters.IBroadcastedEvent;
	
	import mvc.views.SoundExampleView;
	import mvc.views.StartView;

	public class RootView
	{
		private var container:DisplayObjectContainer;
		private var model:Model;
		private var controller:Controller;
		
		private var startView:StartView;
		private var soundExampleView:SoundExampleView;
		
		public function RootView(aContainer:DisplayObjectContainer, aModel:Model, aController:Controller)
		{
			container = aContainer;
			model = aModel;
			controller = aController;
			
			model.addEventListener( Model.START, modelStarted);
		}
		
		private function modelStarted(even:IBroadcastedEvent):void
		{
			model.removeEventListener( Model.START, modelStarted);
			
			openStartView();
		}
		
		private function openStartView():void
		{
			startView = new StartView(model, controller);
			startView.init();
			container.addChild(startView);
			
			model.addEventListener( Model.OPEN_SOUND_EXAMPLE, modelOpenSoundExample);
		}
		
		private function modelOpenSoundExample(even:IBroadcastedEvent):void
		{
			model.removeEventListener( Model.OPEN_SOUND_EXAMPLE, modelOpenSoundExample);
			
			container.removeChild(startView);
			startView.dispose();
			
			soundExampleView = new SoundExampleView(model, controller);
			container.addChild(soundExampleView);
			soundExampleView.init();
			
			model.addEventListener( Model.CLOSE_SOUND_EXAMPLE, modelCloseSoundExample);
		}
		
		private function modelCloseSoundExample(even:IBroadcastedEvent):void
		{
			model.removeEventListener( Model.CLOSE_SOUND_EXAMPLE, modelCloseSoundExample);
			
			container.removeChild(soundExampleView);
			soundExampleView.dispose();
			
			openStartView();
		}
	}
}