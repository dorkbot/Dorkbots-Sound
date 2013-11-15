package dorkbots_sound_example.app.controller
{
	import dorkbots.dorkbots_sound.SoundManager;
	
	import dorkbots_sound_example.app.model.data_vos.StateVO;
	import dorkbots_sound_example.app.model.proxies.StateProxy;
	import dorkbots_sound_example.app.notifications.Notifications;
	import dorkbots_sound_example.sound.EmbedSound;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class InitSoundCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			var stateVO:StateVO = StateProxy( facade.retrieveProxy( StateProxy.NAME ) ).vo;
			
			SoundManager.init( new EmbedSound(), stateVO.stageWidth, stateVO.stageHeight );
		
			// music model settings
			SoundManager.musicModel.volume = .3;
			
			// sound fx model settings
			SoundManager.soundFXModel.panWidth = stateVO.stageWidth + 50;
			SoundManager.soundFXModel.distanceToStartSoundFade = 150;
			SoundManager.soundFXModel.volume = .2;
			
			// voice-over model settings
			SoundManager.voiceOverModel.volumeMax = 4;
			SoundManager.voiceOverModel.volume = 3;
			
			facade.registerCommand( Notifications.DISPOSE_SOUND, DisposeSoundCommand );
			
			facade.removeCommand( Notifications.INIT_SOUND );
		}
	}
}