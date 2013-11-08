﻿/** Author: Dayvid jones* http://www.dayvid.com* Copyright (c) Disco Blimp 2012* http://www.discoblimp.com* Version: 1.0.3* * Licence Agreement** You may distribute and modify this class freely, provided that you leave this header intact,* and add appropriate headers to indicate your changes. Credit is appreciated in applications* that use this code, but is not required.* * Permission is hereby granted, free of charge, to any person obtaining a copy* of this software and associated documentation files (the "Software"), to deal* in the Software without restriction, including without limitation the rights* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell* copies of the Software, and to permit persons to whom the Software is* furnished to do so, subject to the following conditions:* * The above copyright notice and this permission notice shall be included in* all copies or substantial portions of the Software.* * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN* THE SOFTWARE.*/package dorkbots.dorkbots_sound.music {	import flash.events.Event;	import flash.media.Sound;	import flash.media.SoundChannel;		import dorkbots.dorkbots_broadcasters.BroadcastingObject;	import dorkbots.dorkbots_sound.SoundEvents;	import dorkbots.dorkbots_sound.sound.SoundModel;	import dorkbots.dorkbots_sound.util.SoundPanVol;
		public class MusicObject extends BroadcastingObject	{		private var music:Sound;		private var channel:SoundChannel = new SoundChannel();		private var musicPlaying:Boolean;		private var model:SoundModel;		private var setPanAndVol:SoundPanVol;				public function MusicObject(aModel:SoundModel, aSoundClass:Class) 		{			model = aModel;			musicPlaying = false;			music = new aSoundClass();			setPanAndVol = new SoundPanVol();		}				public function get playing():Boolean		{			return musicPlaying;		}				public function playMusic():void 		{			if (!musicPlaying) 			{				//channel = music.play(0);				channel = music.play(0, 1000);				channel.addEventListener(Event.SOUND_COMPLETE, channelComplete);				musicPlaying = true;			}			setSoundTransform(model.volume);		}				public function stopMusic():void 		{			if (musicPlaying) 			{				channel.removeEventListener(Event.SOUND_COMPLETE, channelComplete);				channel.stop();				musicPlaying = false;			}		}				public function setSoundTransform(aVol:Number = 1, aPan:Number = 0, aX:* = null):void 		{			if (aX != null) 			{				setPanAndVol.adjustSound(channel, aVol, aPan, aX, model.stageWidth);			} 			else 			{				setPanAndVol.adjustSound(channel, aVol, aPan);			}		}				private function channelComplete(event:Event):void		{			broadcasterManager.broadcastEvent( SoundEvents.SOUND_COMPLETE );		}				override public function dispose():void 		{			stopMusic();			music = null;			channel = null;			model = null;			setPanAndVol = null;						super.dispose();		}	}}