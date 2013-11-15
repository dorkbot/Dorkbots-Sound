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
package dorkbots.dorkbots_sound.music
{
	import dorkbots.dorkbots_sound.sound.SoundModel;
	
	public class MusicCreator
	{
		protected var model:SoundModel;
		protected var _playDelete:Boolean = false;
		
		public function MusicCreator(aModel:SoundModel) 
		{
			model = aModel;
		}

		public function get playDelete():Boolean
		{
			return _playDelete;
		}
		
		public function createMusic(aType:String):MusicObject 
		{
			_playDelete = false;
			
			return new MusicObject(model, createSound(aType));
		}
		
		// TO DO if trying to do a random loop, but can't use event listener, it causes a gap.
		// create intro
		// create main (vector)
		// create outro
		protected function createSound (aType:String, aPlayDelete:Boolean = false):Class 
		{
			_playDelete = aPlayDelete;
			
			return model.embedSound[aType];
		}
		
		public function dispose():void
		{
			model = null;
		}
	}
}