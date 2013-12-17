package mvc
{
	import flash.display.Stage;
	
	import dorkbots.dorkbots_sound.SoundManager;
	
	import sound.EmbedSound;

	public class Controller
	{
		private var model:Model;
		
		public function Controller(aModel:Model)
		{
			model = aModel;
		}
		
		public final function init(stage:Stage):void
		{
			SoundManager.init( new EmbedSound(), stage.stageWidth, stage.stageHeight );
			
			// music model settings
			SoundManager.musicModel.volume = .3;
			
			// sound fx model settings
			SoundManager.soundFXModel.panWidth = stage.stageWidth + 50;
			SoundManager.soundFXModel.distanceToStartSoundFade = 150;
			SoundManager.soundFXModel.volume = .2;
			
			// voice-over model settings
			SoundManager.voiceOverModel.volumeMax = 4;
			SoundManager.voiceOverModel.volume = 3;
		}
		
		public final function start():void
		{
			model.updateState( Model.START );
		}
		
		public final function openSoundExample():void
		{
			model.updateState( Model.OPEN_SOUND_EXAMPLE );
		}
		
		public final function closeSoundExample():void
		{
			model.updateState( Model.CLOSE_SOUND_EXAMPLE );
		}
	}
}