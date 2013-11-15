﻿/** Author: Dayvid jones* http://www.dayvid.com* Copyright (c) Disco Blimp 2013* http://www.discoblimp.com* Version: 1.0.3* * Licence Agreement** You may distribute and modify this class freely, provided that you leave this header intact,* and add appropriate headers to indicate your changes. Credit is appreciated in applications* that use this code, but is not required.* * Permission is hereby granted, free of charge, to any person obtaining a copy* of this software and associated documentation files (the "Software"), to deal* in the Software without restriction, including without limitation the rights* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell* copies of the Software, and to permit persons to whom the Software is* furnished to do so, subject to the following conditions:* * The above copyright notice and this permission notice shall be included in* all copies or substantial portions of the Software.* * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN* THE SOFTWARE.*/package dorkbots.dorkbots_vector2D{	/**	 * Base class for moving vectors.	 */	public class MovingVector extends EuclideanVector2D	{		// potential edge behaviors		public static const WRAP:String = "wrap";		public static const BOUNCE:String = "bounce";		public static const NONE:String = "none";		//		protected var _edgeBehavior:String = WRAP;		protected var _maxSpeed:Number = 10;		public var boundsWidth:Number;		public var boundsHeight:Number;		protected var oldVelocity:Vector2D;		private var _desiredVelocity:Vector2D;		// max turn rate in degrees		protected var _maxTurnRate:Number = 0;		protected var maxTurnRadian:Number = _maxTurnRate * Math.PI / 180;		// width represents the width of the an object.  The length would be the diameter, but the width might be less than the diameter		protected var _width:Number = 0;		private var _rearEuclideanVector:EuclideanVector2D;		//		private var _minVelocity:Number = 0;		private var _friction:Number = 1;				public function MovingVector(aBoundsWidth:Number, aBoundsHeight:Number)		{			super();			boundsWidth = aBoundsWidth;			boundsHeight = aBoundsHeight;			oldVelocity = _velocity.clone();			_desiredVelocity = _velocity.clone();		}		/**		 * Handles all basic motion. Should be called on each frame / timer interval.		 */		public function update(aFriction:Number = 0):void		{			updateVelocity();			if (aFriction > 0) _friction = aFriction;			_velocity.length *= _friction;			// add velocity to position			if (_minVelocity == 0)			{				_position.add(_velocity);			}			else if (_velocity.length >= _minVelocity) 			{				_position.add(_velocity);			}			// handle any edge behavior			if(_edgeBehavior == WRAP) 			{				wrap();			} 			else if (_edgeBehavior == BOUNCE) 			{				bounce();			}			// update position of sprite			x = position.x;			y = position.y;			//			oldVelocity.copy(_velocity);			//			updateRearEuclideanVector();		}		//		public function updateVelocity():void		{			_desiredVelocity = _velocity.clone();			// 			checkRotationVelocity(_velocity);			// make sure velocity stays within max speed.			_velocity.truncate(_maxSpeed);			//			oldVelocity.copy(_velocity);		}		protected function checkRotationVelocity(aV:Vector2D):void		{			if(_maxTurnRate > 0)			{				var angleBtwn:Number = Vector2D.angleBetween(oldVelocity, aV);				if(angleBtwn > maxTurnRadian)				{					var heading:Vector2D = oldVelocity.clone().normalize();					aV.angle = oldVelocity.angle + (heading.sign(aV) * maxTurnRadian);				}			}		}		/**		 * Causes vector to bounce off edge if edge is hit.		 */		protected function bounce():void		{			if(position.x + _radius > boundsWidth)			{				position.x = boundsWidth - _radius;				velocity.x *= -1;			}			else if(position.x - _radius < 0)			{				position.x = _radius;				velocity.x *= -1;			}						if(position.y + _radius > boundsHeight)			{				position.y = boundsHeight - _radius;				velocity.y *= -1;			}			else if(position.y - _radius < 0)			{				position.y = _radius;				velocity.y *= -1;			}		}		/**		 * Causes vector to wrap around to opposite edge if edge is hit.		 */		protected function wrap():void		{			if(position.x > boundsWidth) position.x = 0;			if(position.x < 0) position.x = boundsWidth;			if(position.y > boundsHeight) position.y = 0;			if(position.y < 0) position.y = boundsHeight;		}		/**		 * This is acts likes the rear bumper of a MovingVector.  Used for for finding distance from the rear of another MovingVector		 */		public function updateRearEuclideanVector():void		{			// create vector that ends at the back of the mv			var backV:EuclideanVector2D = clone() as EuclideanVector2D;			// or not, make it in the front			/*backV.reverse();*/			backV.length = _radius;			// create a EuclideanVector for the width of the mv			var v0:EuclideanVector2D = backV.leftNormal;			var v1:EuclideanVector2D = backV.rightNormal;			if (_width > 0)			{				v0.length = _width * .5;				v1.length = _width * .5;			}			else			{				v0.length = _radius;				v1.length = _radius;			}			// vector for the width of aMV			_rearEuclideanVector = new EuclideanVector2D(v0.b, v1.b);		}		/**		 * Sets / gets what will happen if vector hits edge.		 */		public function set edgeBehavior(value:String):void		{			_edgeBehavior = value;		}		public function get edgeBehavior():String		{			return _edgeBehavior;		}		//		public function get desiredVelocity():Vector2D		{			return _desiredVelocity;		}		//		public function get maxTurnRate():uint 		{			return _maxTurnRate;		}		public function set maxTurnRate(aNum:uint):void 		{			_maxTurnRate = aNum;			maxTurnRadian = _maxTurnRate * Math.PI / 180;		}		/**		 * Sets / gets maximum speed of vector.		 */		public function set minVelocity(value:Number):void		{			_minVelocity = value;		}		public function get minVelocity():Number		{			return _minVelocity;		}		public function set maxSpeed(value:Number):void		{			_maxSpeed = value;		}		public function get maxSpeed():Number		{			return _maxSpeed;		}		public function set width(value:Number):void		{			_width = value;		}		public function get width():Number		{			return _width;		}		public function get rearEuclideanVector():EuclideanVector2D		{			return _rearEuclideanVector;		}		/********************************************************************************************************************************		 * Utilities		 ********************************************************************************************************************************/		public function distanceBtwnMovingVectors(vehicle:MovingVector):Number 		{			return _position.dist(vehicle.position);		}		//		public function movingVectorBehindWithIntersection(aMV:MovingVector):Boolean		{			//v1: this vector's vector			var v1:EuclideanVector2D = this;						// rear of aMV			var v2:EuclideanVector2D = aMV.rearEuclideanVector;						//v3: the vector between v1 and v2, this is the helper vector needed to calculate the intersection point			var v3:EuclideanVector2D = new EuclideanVector2D(v1.position, v2.position);						//Find the ratio of the per product between v3 and v2 and of v1 and v2			var t:Number = v3.perpDotProduct(v2) / v1.perpDotProduct(v2);						var intersection_X:Number = v1.a.x + v1.velocity.x * t;			var intersection_Y:Number = v1.a.y + v1.velocity.y * t;						//Find out if the intersection point is within the length of the vector. Create a fourth vector between the start point of collisionPlane and the intersection point			var v4:EuclideanVector2D = new EuclideanVector2D(v2.a, new Vector2D(intersection_X, intersection_Y));						//Create a fifth vector between the end point of collisionPlane and the intersection point			var v5:EuclideanVector2D = new EuclideanVector2D(v2.b, new Vector2D(intersection_X, intersection_Y));						if(v4.length > v2.length || v5.length > v2.length)			{				//trace("no intersection");				return false;			}			else			{				//trace("found intersection!");				if (t > 0) 				{					//trace("in the future");					return true;				}				else				{					//trace("in the past");					return false;				}			}		}		//		public function thisMovingVectorBehindMovingVector(aMV:MovingVector):Boolean		{			// vector for the rear of aMV			var v2:EuclideanVector2D = aMV.rearEuclideanVector;						// the vector between this vector and aMV			var v1:EuclideanVector2D = new EuclideanVector2D(v2.position, _position);						// dot product			var dp:Number = v1.dotProdCollision(v2.leftNormal);						// negative number means to the right of the v2			if (dp < 0) 			{				return true;			}			else			{				return false;			}		}		//		override public function clone():EuclideanVector2D		{			var aMovingVector:MovingVector = new MovingVector(boundsWidth, boundsHeight);			aMovingVector.copy(this as EuclideanVector2D);			return aMovingVector;		}		//		override public function copy(aEuclideanVector:EuclideanVector2D):void		{			super.copy(aEuclideanVector);			try			{				var aMovingVector:MovingVector = aEuclideanVector as MovingVector;				_maxSpeed = aMovingVector.maxSpeed;				_maxTurnRate = aMovingVector.maxTurnRate;				maxTurnRadian = _maxTurnRate * Math.PI / 180;				_desiredVelocity = aMovingVector.desiredVelocity;				oldVelocity = aMovingVector.oldVelocity;				_edgeBehavior = aMovingVector.edgeBehavior;				boundsWidth = aMovingVector.boundsWidth;				boundsHeight = aMovingVector.boundsHeight;				_width = aMovingVector.width;				_rearEuclideanVector = aMovingVector.rearEuclideanVector;			}			catch (error:Error)			{							}		}		//		override public function dispose():void		{			_desiredVelocity = null;			super.dispose();		}	}}