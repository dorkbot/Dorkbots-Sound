package mvc.views
{
	import com.dVyper.utils.Alert;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import dorkbots.dorkbots_broadcasters.IBroadcastedEvent;
	import dorkbots.dorkbots_effects.fireworks.Fireworks;
	import dorkbots.dorkbots_sound.SoundEvents;
	import dorkbots.dorkbots_sound.SoundManager;
	import dorkbots.dorkbots_sound.sound.SoundObject;
	import dorkbots.dorkbots_sound.sound.SoundObjectVars;
	import dorkbots.dorkbots_ui.DragObject;
	import dorkbots.dorkbots_ui.scrollbars.ScrollBarHorizontal;
	import dorkbots.dorkbots_ui.scrollbars.ScrollBars;
	
	import mvc.Controller;
	import mvc.Model;
	
	import sound.MusicList;
	import sound.SoundFXList;
	import sound.VoiceOverList;
	
	import views.SoundExample_MC;
	
	public class SoundExampleView extends SoundExample_MC
	{
		private var model:Model;
		private var controller:Controller;
		
		private var cheerSFX:SoundObject;
		private var fireworks:Fireworks;
		private var fireworksSFX:SoundObject;
		private var cycleDragObject:DragObject;
		private var revvingLoopSFX:SoundObject;
		private var voiceOver:SoundObject;
		private var musicSlider:ScrollBarHorizontal;
		private var sfxSlider:ScrollBarHorizontal;
		private var voSlider:ScrollBarHorizontal;
		
		public function SoundExampleView(aModel:Model, aController:Controller)
		{
			model = aModel;
			controller = aController;
		}
		
		public final function init():void
		{
			// Alert window - Opens when the VO is finished
			Alert.init( this.stage, { colour:0x006633, textColour:0xFFFFFF } );
			
			// Motorcycle - 
			cycleDragObject = new DragObject( cycle_mc );
			cycleDragObject.addEventListener( MouseEvent.MOUSE_MOVE, cycleDrabObjectMoved );
			cycle_mc.buttonMode = true;
			revvingLoopSFX = SoundManager.soundFXPlayer.createSound( SoundFXList.REVVINGLOOP );
			revvingLoopSFX.playSound( { loop:true, distanceFadeOn:true, position:new Point( cycle_mc.x, cycle_mc.y ) } );
			
			fireworks = new Fireworks();
			addChildAt( fireworks, 0 );
			fireworks.addEventListener( Fireworks.FIREWORK_STARTED, fireworkStarted );
			fireworks.init( this.stage.stageWidth, this.stage.stageHeight );
			
			// Sound FX
			var messagePopSFX:SoundObject = SoundManager.soundFXPlayer.createSound( SoundFXList.MESSAGEPOP );
			messagePopSFX.playSound( new SoundObjectVars().diposeWhenCompleted( true ) );
			
			fireworksSFX = SoundManager.soundFXPlayer.createSound( SoundFXList.FIREWORKS );
			
			cheerSFX = SoundManager.soundFXPlayer.createSound( SoundFXList.CHEER );
			cheerSFX.playSound( new SoundObjectVars().diposeWhenCompleted( true ) );
			trace("[SoundExampleView] -> init -> cheerSFX.soundPlaying = " + cheerSFX.soundPlaying);
			
			// Music
			SoundManager.musicPlayer.playMusic( MusicList.HALLOWEEN_LOOP );
			
			// Voice Over
			voiceOver = SoundManager.voiceOverPlayer.createSound( VoiceOverList.L_CE_1 );
			startVO_btn.addEventListener(MouseEvent.CLICK, startVOBtnClicked);
			stopVO_btn.addEventListener(MouseEvent.CLICK, stopVOBtnClicked);
			
			// music volume
			musicSlider = new ScrollBarHorizontal(musicSlider_mc);
			musicSlider.powerSide = ScrollBars.RIGHT_TOP;
			musicSlider.powerMax = SoundManager.musicModel.volumeMax;
			musicSlider.power = SoundManager.musicModel.volume;
			musicSlider.initManual(20);
			musicSlider.addEventListener(Event.CHANGE, musicSliderUpDatePower);
			
			// sound fx volume
			sfxSlider = new ScrollBarHorizontal(sfxSlider_mc);
			sfxSlider.powerSide = ScrollBars.RIGHT_TOP;
			sfxSlider.powerMax = SoundManager.soundFXModel.volumeMax;
			sfxSlider.power = SoundManager.soundFXModel.volume;
			sfxSlider.initManual(20);
			sfxSlider.addEventListener(Event.CHANGE, sfxSliderUpDatePower);
			
			// voice over volume
			voSlider = new ScrollBarHorizontal(voSlider_mc);
			voSlider.powerSide = ScrollBars.RIGHT_TOP;
			voSlider.powerMax = SoundManager.voiceOverModel.volumeMax;
			voSlider.power = SoundManager.voiceOverModel.volume;
			voSlider.initManual(20);
			voSlider.addEventListener(Event.CHANGE, voSliderUpDatePower);
			
			close_btn.addEventListener(MouseEvent.CLICK, closeBtnClicked);
		}
		
		private function closeBtnClicked(event:MouseEvent):void
		{
			close_btn.removeEventListener(MouseEvent.CLICK, closeBtnClicked);
			
			var postionPoint:Point = this.localToGlobal( new Point( event.currentTarget.x, event.currentTarget.y ) );
			var messagePopSFX:SoundObject = SoundManager.soundFXPlayer.createSound( SoundFXList.MESSAGEPOP );
			messagePopSFX.playSound( new SoundObjectVars().diposeWhenCompleted( true ).position(postionPoint) );
			
			SoundManager.musicPlayer.stopMusic();
			
			controller.closeSoundExample();
		}
		
		private function stopVOBtnClicked(event:MouseEvent):void
		{
			voiceOver.removeEventListener(Event.SOUND_COMPLETE, voSoundComplete);
			
			var postionPoint:Point = this.localToGlobal( new Point( event.currentTarget.x, event.currentTarget.y ) );
			var messagePopSFX:SoundObject = SoundManager.soundFXPlayer.createSound( SoundFXList.MESSAGEPOP );
			messagePopSFX.playSound( new SoundObjectVars().diposeWhenCompleted( true ).position( postionPoint ) );
			
			voiceOver.stopSound();
		}
		
		private function startVOBtnClicked(event:MouseEvent):void
		{
			var postionPoint:Point = this.localToGlobal( new Point( event.currentTarget.x, event.currentTarget.y ) );
			var messagePopSFX:SoundObject = SoundManager.soundFXPlayer.createSound( SoundFXList.MESSAGEPOP );
			messagePopSFX.playSound( new SoundObjectVars().diposeWhenCompleted( true ).position( postionPoint ) );
			
			voiceOver.addEventListener(SoundEvents.SOUND_COMPLETE, voSoundComplete);
			voiceOver.playSound( new SoundObjectVars().restart( true ) );
		}
		
		private function voSoundComplete(event:IBroadcastedEvent):void
		{
			Alert.show(
				"Voice Over is complete!"
			);
		}
		
		private function voSliderUpDatePower(event:Event):void
		{
			SoundManager.voiceOverModel.volume = voSlider.power;
		}
		
		private function musicSliderUpDatePower(event:Event):void 
		{
			SoundManager.musicModel.volume = musicSlider.power;
		}
		
		private function sfxSliderUpDatePower(event:Event):void 
		{
			SoundManager.soundFXModel.volume = sfxSlider.power;
		}
		
		private function cycleDrabObjectMoved(event:MouseEvent):void
		{
			var revvingLoopSFXVars:SoundObjectVars = new SoundObjectVars().loop(true);
			var postionPoint:Point = this.localToGlobal( new Point( cycle_mc.x, cycle_mc.y ) );
			revvingLoopSFX.playSound( new SoundObjectVars().solo( true ).loop( true ).distanceFadeOn( true ).position( postionPoint ) );
		}
		
		private function fireworkStarted(event:Event):void
		{
			var fireworks:Fireworks = Fireworks( event.currentTarget );
			var postionPoint:Point = fireworks.localToGlobal( new Point( fireworks.fireworkOrigin.x, fireworks.fireworkOrigin.y ) );
			fireworksSFX.playSound( new SoundObjectVars().adjustVol(2).restart( true ).position( postionPoint ) );
		}
		
		public final function dispose():void
		{
			close_btn.removeEventListener(MouseEvent.CLICK, closeBtnClicked);
			startVO_btn.removeEventListener(MouseEvent.CLICK, startVOBtnClicked);
			stopVO_btn.removeEventListener(MouseEvent.CLICK, stopVOBtnClicked);
			
			// this sound object is set to dispose when it's completed. To stop and dispose the sound object right now, we set disposeWhenCompleted = false;
			cheerSFX.diposeWhenCompleted = false;
			cheerSFX.dispose();
			cheerSFX = null;
			
			fireworksSFX.dispose();
			fireworksSFX = null;
			
			fireworks.removeEventListener(Fireworks.FIREWORK_STARTED, fireworkStarted);
			fireworks.dispose();
			fireworks = null;
			
			cycleDragObject.removeEventListener(MouseEvent.MOUSE_MOVE, cycleDrabObjectMoved);
			cycleDragObject.dispose();
			cycleDragObject = null;
			
			revvingLoopSFX.dispose();
			revvingLoopSFX = null;
			
			voiceOver.removeEventListener(SoundEvents.SOUND_COMPLETE, voSoundComplete);
			voiceOver.dispose();
			voiceOver = null;
			
			musicSlider.removeEventListener(Event.CHANGE, musicSliderUpDatePower);
			musicSlider.dispose();
			musicSlider = null;
			
			sfxSlider.removeEventListener(Event.CHANGE, sfxSliderUpDatePower);
			sfxSlider.dispose();
			sfxSlider = null;
			
			voSlider.removeEventListener(Event.CHANGE, voSliderUpDatePower);
			voSlider.dispose();
			voSlider = null;
			
			model = null;
			controller = null;
		}
	}
}