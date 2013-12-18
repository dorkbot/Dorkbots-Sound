/*
* Author: Dayvid jones
* http://www.dayvid.com
* Copyright (c) Disco Blimp 2013
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
package dorkbots.dorkbots_ui.scrollbars{	import flash.display.MovieClip;	import flash.geom.Rectangle;	//	public class ScrollBarVertical extends ScrollBars {		//		public function ScrollBarVertical (aScroller_mc:MovieClip, aViewAreaHeight:Number = 0, aTarget:* = null, aTargetDefaultY:* = null, aScrollRect:* = null) {			//trace ("ScrollBarVertical");			scrollerType = "vertical";			xOrYPos = "y";			heightOrWidth = "height";			super(aScroller_mc, aViewAreaHeight, aTarget, aTargetDefaultY);			buildScrollRect ();			init (aScrollRect);		}		//		override protected function buildScrollRect ():void {			// back ground or scroll gutter must be called gutter_mc in scroller_mc. Registration point at top and x = 0.			if (upDateScrollRect) {				scrollRectangle = new Rectangle (0, 0, 0, Math.round(scroller_mc.gutter_mc[heightOrWidth] - scrub_mc[heightOrWidth]));			}		}		//		override protected function checkScrubScale ():void {			super.checkScrubScale ();			if (scrub_mc.scaleY < 1) {				scrub_mc.scaleY = 1;			}		}	}}