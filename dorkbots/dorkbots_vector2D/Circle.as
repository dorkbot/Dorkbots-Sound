﻿/** Author: Dayvid jones* http://www.dayvid.com* Copyright (c) Disco Blimp 2013* http://www.discoblimp.com* Version: 1.0.3* * Licence Agreement** You may distribute and modify this class freely, provided that you leave this header intact,* and add appropriate headers to indicate your changes. Credit is appreciated in applications* that use this code, but is not required.* * Permission is hereby granted, free of charge, to any person obtaining a copy* of this software and associated documentation files (the "Software"), to deal* in the Software without restriction, including without limitation the rights* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell* copies of the Software, and to permit persons to whom the Software is* furnished to do so, subject to the following conditions:* * The above copyright notice and this permission notice shall be included in* all copies or substantial portions of the Software.* * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN* THE SOFTWARE.*/package dorkbots.dorkbots_vector2D{	public class Circle implements ICircle	{		protected var _radius:Number;		private var _x:Number;		private var _y:Number;		//		public function Circle(radius:Number = 0, aX:Number = 0, aY:Number = 0) 		{			_radius = radius;			_x = aX;			_y = aY;		}		//		public final function getCircleSprite():CircleSprite		{			return new CircleSprite(radius, _x, _y);		}		//		public function set x(value:Number):void		{			_x = value;		}		public final function get x():Number 		{			return _x;		}		//		public function set y(value:Number):void		{			_y = value;		}		public final function get y():Number 		{			return _y;		}		//		public final function set radius(value:Number):void		{			_radius = value;		}		public final function get radius():Number 		{			return _radius;		}		//		public final function set position(aV:Vector2D):void 		{			_x = aV.x;			_y = aV.y;		}		public final function get position():Vector2D 		{			return new Vector2D(_x, _y);		}	}}