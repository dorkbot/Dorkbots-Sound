package dorkbots_sound_example.app.controller
{
	import dorkbots_sound_example.app.model.proxies.StateProxy;
	import dorkbots_sound_example.app.notifications.Notifications;
	import dorkbots_sound_example.app.notifications.notification_objects.StartupNotification;
	import dorkbots_sound_example.app.view.ApplicationMediator;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class StartupCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			//trace("[StartupCommand]");
			var body:StartupNotification = StartupNotification(notification.getBody());
			
			facade.registerProxy( new StateProxy( body ) );
			
			facade.registerCommand( Notifications.LOAD_DATA, LoadDataCommand );
			facade.registerCommand( Notifications.DATA_READY, DataReadyCommand );
			facade.registerCommand( Notifications.APP_READY, AppCommand );

			facade.registerMediator( new ApplicationMediator( body.stage ) );
			
			sendNotification( Notifications.LOAD_DATA );
			
			facade.removeCommand( Notifications.STARTUP );
		}
	}
}