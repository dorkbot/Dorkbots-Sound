/*
* Author: Dayvid jones
* http://www.dayvid.com
* Copyright (c) Disco Blimp 2012
* http://www.discoblimp.com
* Version: 1.0.3
* 
* Licence Agreement
*
* You may distribute and modify this class freely, provided that you leave this header intact,
* and add appropriate headers to indicate your changes. Credit is appreciated in applications
* that use this code, but is not required.
* 
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/
package dorkbots.dorkbots_sound.sound
{
	import flash.geom.Point;
	
	/**
	 * This class is used for defining "vars" parameters in SoundObject instances. Use this class instead of passing an object as a parameter in a SoundObject.playSound() method, the benefit is code hinting.
	 */	 

	public class SoundObjectVars
	{
		private var _vars:Object = new Object();
		
		public function SoundObjectVars()
		{
		}
		
		/**
		 * Returns an object with all of the varable settings.
		 * @returns Object An object with all varable settings.
		 */
		public function get vars():Object
		{
			return _vars;
		}

		private function set(property:String, value:*):SoundObjectVars
		{
			if (value == null) 
			{
				delete _vars[property]; //in case it was previously set
			} 
			else 
			{
				_vars[property] = value;
			}
			
			return this;
		}
		
		/**
		 * Raises or lowers the volume relative to the main volume level.
		 * 
		 * @param param A number that modifies the main volume level. Example: 1.1 increased volume, .9 decreases volume.
		 */
		public function adjustVol(param:Number):SoundObjectVars
		{
			set("adjustVol", param);
			
			return this;
		}
		
		/**
		 * Tells the SoundObject to perform an auto dispose when the sound completes.
		 * 
		 * @param param "true" sets the SoundObject to perform an auto dispose.
		 */
		public function diposeWhenCompleted(param:Boolean):SoundObjectVars
		{
			set("diposeWhenCompleted", param);
			
			return this;
		}
		
		/**
		 * Tells the SoundObject to restart.
		 * 
		 * @param param "true" sets the SoundObject to restart.
		 */
		public function restart(param:Boolean):SoundObjectVars
		{
			set("restart", param);
			
			return this;
		}
		
		/**
		 * The sound object can find a random start position in the sound.
		 * 
		 * @param param "true" tells the SoundObject to find a random start position.
		 */
		public function ranStartPosition(param:Boolean):SoundObjectVars
		{
			set("ranStartPosition", param);
			
			return this;
		}
		
		/**
		 * Sets start position in the sound.
		 * 
		 * @param param sets the start position of the sound.
		 */
		public function startPosition(param:uint):SoundObjectVars
		{
			set("startPosition", param);
			
			return this;
		}
		
		/**
		 * Sets the sound to loop.
		 * 
		 * @param param "true" sets the sound to loop.
		 */
		public function loop(param:Boolean):SoundObjectVars
		{
			set("loop", param);
			
			return this;
		}
		
		/**
		 * The SoundObject can play multiple sounds or play only a single sound.
		 * 
		 * @param param "true" plays only a single sound.
		 */
		public function solo(param:Boolean):SoundObjectVars
		{
			set("solo", param);
			
			return this;
		}
		
		/**
		 * This is the position on the screen that the sound originates from. You can pass the position of an object, like a button, or a moving display object. Use this with distanceFadeOn to make sounds sound and feel like they are moving. And make sure you are passing the stage's height and weight to SoundManager.init(aEmbedSound:Object, aStageWidth:Number = 0, aStageHeight:Number = 0)
		 * 
		 * @param param A point that is the x and y screen coordinates.
		 */
		public function position(param:Point):SoundObjectVars
		{
			set("position", param);
			
			return this;
		}
		
		/**
		 * This is usually used for games. You can set a distance from the center of the screen for when a sound's volume will fade. This gives the affect of the sound getting farther away. Good for making objects sound like they are traveling away or towards. Use with the "position" property. And make sure you are passing the stage's height and weight to SoundManager.init(aEmbedSound:Object, aStageWidth:Number = 0, aStageHeight:Number = 0)
		 * 
		 * @param param "true" turns the distance fade effect on. Set distanceToStartSoundFade property in the SoundObject's model.
		 */
		public function distanceFadeOn(param:Boolean):SoundObjectVars
		{
			set("distanceFadeOn", param);
			
			return this;
		}
		
		/**
		 * Adjusts the stereo pan of the sound. Using the point var will override this.
		 * 
		 * @param param The amount or direction of the pan.
		 */
		public function pan(param:Number):SoundObjectVars
		{
			set("pan", param);
			
			return this;
		}
		
		/**
		 * Adjusts the volume of the sound. Use this to ignore or override the SoundObject's model volume, or main volume.
		 * 
		 * @param param The amount of volume.
		 */
		public function vol(param:Number):SoundObjectVars
		{
			set("vol", param);
			
			return this;
		}
		
		/**
		 * You can use this to give the sound a delay before it starts.
		 * 
		 * @param param The amount of the delay in seconds.
		 */
		public function delay(param:Number):SoundObjectVars
		{
			set("delay", param);
			
			return this;
		}
	}
}