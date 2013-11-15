/*
Flash AS3 tutorial by Dan Gries.

www.flashandmath.com
dan@flashandmath.com

Please see terms of use at http://www.flashandmath.com/about/terms.html
*/


//A Particle3D is not a display object, but rather just a collection of attributes for a particle.

package com.flashandmath.dg.objects {
	import com.flashandmath.dg.geom3D.Point3D;
	
	public class Particle3D {				
		public var size:Number;
		public var color:uint;
		
		public var pos:Point3D;
		public var vel:Point3D;
		public var accel:Point3D;
		
		public var airResistanceFactor:Number;
		
		public var age:Number;
		public var lifeSpan:Number;
				
		//The following attributes are for the purposes of creating a
		//linked list of Particle3D instances.
		public var next:Particle3D;
		public var prev:Particle3D;
				
		//The following are "envelope" parameters to control the evolution of a particle's size, etc.
		public var envelopeTime1:Number;
		public var envelopeTime2:Number;
		public var envelopeTime3:Number;
		public var paramInit:Number;
		public var paramHold:Number;
		public var paramLast:Number;
		public var dead:Boolean;

		public function Particle3D(x0:Number=0,y0:Number=0, z0:Number = 0, velX:Number = 0, velY:Number = 0, velZ:Number = 0) {
			pos = new Point3D(x0,y0,z0);
			vel = new Point3D(velX, velY, velZ);
			accel = new Point3D();
			size = 1;
			color = 0xFFFFFF;
			airResistanceFactor = 0.03;
			dead = false;
		}
	}
}
			
		