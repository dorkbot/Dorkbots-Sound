﻿package dorkbots.dorkbots_vector2D{	public class Circle implements ICircle	{		protected var _radius:Number;		private var _x:Number;		private var _y:Number;		//		public function Circle(radius:Number = 0, aX:Number = 0, aY:Number = 0) 		{			_radius = radius;			_x = aX;			_y = aY;		}		//		public final function getCircleSprite():CircleSprite		{			return new CircleSprite(radius, _x, _y);		}		//		public function set x(value:Number):void		{			_x = value;		}		public final function get x():Number 		{			return _x;		}		//		public function set y(value:Number):void		{			_y = value;		}		public final function get y():Number 		{			return _y;		}		//		public final function set radius(value:Number):void		{			_radius = value;		}		public final function get radius():Number 		{			return _radius;		}		//		public final function set position(aV:Vector2D):void 		{			_x = aV.x;			_y = aV.y;		}		public final function get position():Vector2D 		{			return new Vector2D(_x, _y);		}	}}