package dorkbots_sound_example.app.controller
{
	import dorkbots_sound_example.app.notifications.Notifications;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class AppCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			//trace("[AppCommand] -> execute");
			facade.registerCommand( Notifications.INIT_SOUND, InitSoundCommand );
		}
	}
}