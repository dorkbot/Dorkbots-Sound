﻿/** Author: Dayvid jones* http://www.dayvid.com* Copyright (c) Disco Blimp 2012* http://www.discoblimp.com* Version: 1.0.3* * Licence Agreement** You may distribute and modify this class freely, provided that you leave this header intact,* and add appropriate headers to indicate your changes. Credit is appreciated in applications* that use this code, but is not required.* * Permission is hereby granted, free of charge, to any person obtaining a copy* of this software and associated documentation files (the "Software"), to deal* in the Software without restriction, including without limitation the rights* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell* copies of the Software, and to permit persons to whom the Software is* furnished to do so, subject to the following conditions:* * The above copyright notice and this permission notice shall be included in* all copies or substantial portions of the Software.* * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN* THE SOFTWARE.*/package dorkbots.dorkbots_sound.sound {		import flash.events.Event;	import flash.events.TimerEvent;	import flash.geom.Point;	import flash.media.Sound;	import flash.media.SoundChannel;	import flash.utils.Timer;		import dorkbots.dorkbots_broadcasters.BroadcastingObject;	import dorkbots.dorkbots_sound.SoundEvents;	import dorkbots.dorkbots_sound.util.SoundPanVol;
	import dorkbots.dorkbots_vector2D.EuclideanVector2D;
	import dorkbots.dorkbots_vector2D.Vector2D;
		/**	 * SoundObject manage and control one sound. It can play many instances of this one sound or it can play a single instance of its sound.	 * <ol>	 *		<li> param aModel SoundModel used for states and properties.</li>	 *		<li> param aSoundClass The Sound Class associated with this SoundObject.</li>	 * 		<li> param aSoundObjectCreator The Factory that created and manages this SoundObject.</li>	 *  </ol>	 */	public class SoundObject extends BroadcastingObject	{		private var soundObjectCreator:SoundObjectCreator;		private var sound:Sound;		private var soundClass:Class = null;		private var channel:SoundChannel = new SoundChannel();		private var setPanAndVol:SoundPanVol;		private var _soundPlaying:Boolean = false;		private var model:SoundModel;		private var currentDistance:Number = 0;		private var centerScreenEV:EuclideanVector2D;		private var _cleanedUp:Boolean = false;		private var xPos:* = null;				// model		private var _vol:Number = 0;		private var _adjustVol:Number = 1;		private var _pan:Number = 0;		private var _distanceFadeOn:Boolean = false;		private var _position:Point = null;		private var _solo:Boolean = false;		private var _thisLoop:Boolean = false;		private var _startPosition:uint = 0;		private var _ranStartPosition:Boolean = false;		private var _diposeWhenCompleted:Boolean = false;		private var _delay:uint = 0;				private var delayTimer:Timer = new Timer(_delay);				/**		 * Constructor		 * @param aModel SoundModel used for states and properties.		 * @param aSoundClass The Sound Class associated with this SoundObject.		 * @param aSoundObjectCreator The Factory that created and manages this SoundObject.		 */		public function SoundObject(aModel:SoundModel, aSoundClass:Class, aSoundObjectCreator:SoundObjectCreator)		{			//trace("SoundFX");			model = aModel;			_soundPlaying = false;			soundClass = aSoundClass;			soundObjectCreator = aSoundObjectCreator;			centerScreenEV = new EuclideanVector2D(new Vector2D(model.stageWidth / 2, model.stageHeight / 2));			setPanAndVol = new SoundPanVol();		}		/**		 * Raises or lowers the volume relative to the main volume level		 * 		 */		public function get adjustVol():Number
		{
			return _adjustVol;
		}		/**		 * Tells the SoundObject to perform an auto dispose when the sound completes.		 * 		 */		public function get diposeWhenCompleted():Boolean
		{
			return _diposeWhenCompleted;
		}				/**		 * Tells the SoundObject to perform an auto dispose when the sound completes.		 * 		 */		public function set diposeWhenCompleted(value:Boolean):void		{			_diposeWhenCompleted = value;			if (_diposeWhenCompleted) _solo = true;		}				/**		 * Sets a random start position in the sound.		 * 		 */		public function get ranStartPosition():Boolean
		{
			return _ranStartPosition;
		}		/**		 * Sets start position in the sound.		 * 		 */		public function get startPosition():uint
		{
			return _startPosition;
		}		/**		 * Sets the sound to loop.		 * 		 */		public function get loop():Boolean
		{
			return _thisLoop;
		}		/**		 * The SoundObject can play multiple sounds or play only a single sound.		 * 		 */		public function get solo():Boolean
		{
			return _solo;
		}		/**		 * This is the position on the screen that the sound originates from. You can pass the position of an object, like a button, or a moving display object. Use this with distanceFadeOn to make sounds sound like they are moving.		 * 		 */		public function get position():Point
		{
			return _position;
		}		/**		 * This is usually used for games. You can set a distance from the center of the screen for when a sound's volume will fade. This gives the affect of the sound getting farther away. Good for making objects sound like they are traveling away or towards. Use with the "position" property.		 * 		 */		public function get distanceFadeOn():Boolean
		{
			return _distanceFadeOn;
		}		/**		 * Adjusts the stereo pan of the sound.		 * 		 */		public function get pan():Number
		{
			return _pan;
		}		/**		 * Adjusts the volume of the sound. Use this to ignore or override the SoundObject's model volume, or main volume.		 * 		 */		public function get vol():Number
		{
			return _vol;
		}				/**		 * Controls and adjusts the SoundObject. Use this method for all updates.		 * 		 * @param vars An optional object for all params. You can use a SoundObjectVars.		 */		public function playSound(vars:Object = null):void 		{			if (vars == null) 			{				vars = new Object();			}						if (vars is SoundObjectVars)			{				vars = SoundObjectVars(vars).vars;			}						// turn distance fade on			if (vars.distanceFadeOn != null) 			{				_distanceFadeOn = vars.distanceFadeOn;			}						// volume			if (vars.vol != null) 			{				_vol = vars.vol;			} 			else 			{				_vol = model.volume;			}						// adds to or subtracts from the main volume			if (vars.adjustVol != null) 			{				_adjustVol = vars.adjustVol;				_vol *= _adjustVol;				_vol = Math.max(0, _vol);			} 						// stereo panning			if (vars.pan != null) 			{				_pan = vars.pan;			} 						// x position for stereo			if (vars.x != null && vars.x is Number) 			{				_position = new Point(vars.x, 0);			} 			else if (vars.position != null) 			{				_position = vars.position;			}						// solo play back, if true then only one can be played at a time			if (vars.solo != null) 			{				_solo = vars.solo;			} 						// for looping			if (vars.loop != null) 			{				_thisLoop = vars.loop;			} 						// sets sound start position in milliseconds			if (vars.startPosition != null) 			{				_startPosition = vars.startPosition;			} 						// random start position			if (vars.ranStartPosition != null) 			{				_ranStartPosition = vars.ranStartPosition;			}						// delay			if (vars.delay != null)			{				_delay = vars.delay			}						// does an auto clean up when completed			if (vars.diposeWhenCompleted != null) 			{				_diposeWhenCompleted = vars.diposeWhenCompleted;				if (_diposeWhenCompleted) _solo = true;			}						// does an auto clean up when completed USED BY OLD PROJECTS			if (vars.dispose != null) 			{				_diposeWhenCompleted = vars.dispose;				if (_diposeWhenCompleted) _solo = true;			}						// stop sfx before playing, similar to solo except it restarts the sound instead of waiting for sound to finish playing			if (vars.restart != null) 			{				if (vars.restart) stopSound();			}						if (_soundPlaying && _solo) 			{				// do nothing, makes sure only one sfx plays at a time and waits untill completed before starting sfx				setSoundTransform(_vol, _pan, _position);			} 			else 			{								if (_delay > 0 && !delayTimer.running)				{					delayTimer = new Timer(_delay, 1);					delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, delayTimerComplete);					delayTimer.start();				}				else				{					playSoundPassed();				}			}		}				private function delayTimerComplete(event:TimerEvent):void		{			delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, delayTimerComplete);			if (_delay > 0) playSoundPassed();		}				private function playSoundPassed():void		{			if (!_cleanedUp && soundClass != null)			{				_soundPlaying = true;				// problem with play sfx to quickly, transform doesnt change the preceeding calls				//setSoundTransform(vol, pan, position);				//channel = new SoundChannel();								var thisSFX:Sound = new soundClass();								if (_ranStartPosition)				{					_startPosition = Math.floor(Math.random() * thisSFX.length);				}								if (_thisLoop && !_ranStartPosition) 				{					channel = thisSFX.play(_startPosition, 1000);				} 				else 				{					//trace("thisSFX: " + thisSFX);					channel = thisSFX.play(_startPosition, 1);										//trace("channel: " + channel);					if (channel == null) channel = thisSFX.play(_startPosition, 1);										//trace("channel: " + channel);					if (channel != null) channel.addEventListener(Event.SOUND_COMPLETE, soundComplete);				}								if (channel != null) setSoundTransform(_vol, _pan, _position);			}		}				/**		 * Allows for direct control of the sounds properties. But use with caution, updating the model volume will override your volume levels. For a better result use the playSound method.		 * 		 * @param aVol volume amount.		 * @param aPan the pan amount.		 * @param aPosition the position that the sound comes from.		 */		public function setSoundTransform(aVol:Number = 1, aPan:Number = 0, aPosition:Point = null):void 		{			_position = aPosition;						_vol = aVol;						if (model.distanceToStartSoundFade > 0 && aPosition != null)			{				centerScreenEV.b = new Vector2D(aPosition.x, aPosition.y);				currentDistance = centerScreenEV.length;								var currentFadeDistance:Number;				if (_distanceFadeOn)				{					currentFadeDistance = currentDistance - model.distanceToStartSoundFade;				}				else				{					currentFadeDistance = 0;				}								/*if (currentFadeDistance > model.soundFXFadeRange)				{					vol = 0;				}				else */				if (currentFadeDistance > 0)				{					// start fade					_vol *= model.distanceToStartSoundFade / currentDistance;					//vol = vol - (vol * (currentFadeDistance / model.soundFXFadeRange));					// make sure vol isn't below 0					_vol = Math.max(_vol, 0);				}			}						//trace("position: " + position + ", currentDistance: " + currentDistance + ", currentFadeDistance: " + currentFadeDistance + ", vol: " + vol);			_pan = aPan;						if (_position != null)			{				xPos = _position.x;			}						if (_position != null && model != null) 			{				if (channel != null) setPanAndVol.adjustSound(channel, _vol, aPan, xPos, model.panWidth, model.stageWidth);			} 			else 			{				if (channel != null) setPanAndVol.adjustSound(channel, _vol, aPan);			}		}				/**		 * Allows for direct control of the sounds volume. But use with caution, updating the model volume will override your volume levels. For a better result use the playSound method and the adjustVol parameter, or use the model to change the volume.		 * 		 * @param aNum volume amount.		 */		public function changeVolume(aNum:Number):void		{			setSoundTransform (aNum, _pan, _position);		}				private function soundComplete(event:Event):void 		{						event.currentTarget.removeEventListener(Event.SOUND_COMPLETE, soundComplete);			broadcastEvent( SoundEvents.SOUND_COMPLETE );						// if loop is true and random start position is true, then do a reset and play the sfx again			if (_ranStartPosition && _thisLoop)			{				_ranStartPosition = false;				_startPosition = 0;				playSoundPassed();			}			else			{				_soundPlaying = false;				if (_diposeWhenCompleted) dispose();			}		}				/**		 * Stops all sounds.		 * 		 */		public function stopSound():void 		{			if (delayTimer != null) 			{				delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, delayTimerComplete);				delayTimer.stop();			}						if (channel != null) channel.stop();						_soundPlaying = false;						_delay = 0;		}				/**		 * Use this getter to check if the sound is playing or not.		 * 		 * @return Boolean Returns true if the sound is playing		 */		public function get soundPlaying():Boolean		{			return _soundPlaying;		}				/**		 * Cleans up for garbage collection.		 * 		 * If you want the sound to dispose after its completed then set disposeWhenCompleted = true;		 * If disposeWhenCompleted = true but you want the dispose method to stop the sound object, then set disposeWhenCompleted = false before calling dispose();		 */		override public function dispose():void 		{			if (_diposeWhenCompleted && _soundPlaying)			{				// don't stop sound object until it is finished			}			else			{				stopSound();								if (soundObjectCreator)				{					soundObjectCreator.removeSound(this);					soundObjectCreator = null;					model = null;				}								if (channel != null) 				{					channel.removeEventListener(Event.SOUND_COMPLETE, soundComplete);					channel = null;				}								if (sound != null) sound = null;								if (soundClass != null) soundClass = null;								if (model!= null) model = null;								if (setPanAndVol != null) setPanAndVol = null;								if (centerScreenEV != null) 				{					centerScreenEV.dispose();					centerScreenEV = null;				}								delayTimer = null;								_cleanedUp = true;								super.dispose();			}		}	}}