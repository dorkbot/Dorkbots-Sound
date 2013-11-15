package dorkbots_sound_example.app.controller
{
	import dorkbots.dorkbots_sound.SoundManager;
	
	import dorkbots_sound_example.app.notifications.Notifications;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class DisposeSoundCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			SoundManager.dispose();
			
			facade.registerCommand( Notifications.INIT_SOUND, InitSoundCommand );
			
			facade.removeCommand( Notifications.DISPOSE_SOUND );
		}
	}
}