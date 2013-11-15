package dorkbots_sound_example.app.controller
{
	import dorkbots_sound_example.app.notifications.Notifications;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class DataReadyCommand extends SimpleCommand implements ICommand
	{
		private var configXML_URL:String;
		
		override public function execute(notification:INotification):void
		{
			sendNotification( Notifications.APP_READY );
			
			facade.removeCommand( Notifications.DATA_READY );
		}
	}
}