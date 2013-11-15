package dorkbots_sound_example.app.view.mediators
{
	import com.dayvid.mvc.ISpriteView;
	import com.dayvid.util.RemoveChildren;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class SoundExampleMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "SoundExampleMediator";
		
		private var main_mc:Sprite;
		private var iMain_mc:ISpriteView;
		private var completeNotification:String;
		
		public function SoundExampleMediator(viewComponent:DisplayObject, aCompleteNotification:String)
		{
			//trace("[" + NAME + "]");
			super( NAME, viewComponent );
			
			completeNotification = aCompleteNotification;
			
			main_mc = Sprite( viewComponent );
			iMain_mc = ISpriteView( viewComponent );
			
			main_mc.addEventListener(Event.COMPLETE, mainComplete);
			
			iMain_mc.init();
		}
		
		private function mainComplete(event:Event):void
		{
			main_mc.removeEventListener(Event.COMPLETE, mainComplete);
			sendNotification( completeNotification );
		}
		
		override public function onRemove():void
		{
			//trace("[" + NAME + "] onRemove");
			RemoveChildren.removeAChild(main_mc.parent, main_mc);
			
			main_mc.removeEventListener(Event.COMPLETE, mainComplete);
			main_mc = null;
			
			iMain_mc.dispose();
			iMain_mc = null;
			
			viewComponent = null;
		}
	}
}