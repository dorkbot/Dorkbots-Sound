/*
Flash AS3 tutorial by Dan Gries.

www.flashandmath.com
dan@flashandmath.com

Please see terms of use at http://www.flashandmath.com/about/terms.html
*/

/*
This class represents a linked list of particles. The only functions in this class (apart from the constructor) are:

	addParticle(x0=0, y0=0, z0=0, velX=0, velY=0, velZ=0) - adds a particle to the list with specified initial position and velocity.
		
	recycleParticle - removes a particle from the list.  Particle is saved in a recycle bin for future use.

*/

package com.flashandmath.dg.objects {
	import com.flashandmath.dg.objects.Particle3D;
	
	public class Particle3DList {
				
		public var first:Particle3D;
		public var recycleBinListFirst:Particle3D;
		public var numOnStage:Number;
		public var numInRecycleBin:Number;
		
		public function Particle3DList() {			
			numOnStage = 0;
			numInRecycleBin = 0;			
		}
		
		
		public function addParticle(x0:Number = 0, y0:Number = 0, z0:Number = 0, velX:Number = 0, velY:Number = 0, velZ:Number = 0):Particle3D {
			var particle:Particle3D; 
			
			numOnStage++;			

			//check recycle bin for available particle:
			if (recycleBinListFirst != null) {
				numInRecycleBin--;
				particle = recycleBinListFirst;
				//remove from bin
				if (particle.next != null) {
					recycleBinListFirst = particle.next;
					particle.next.prev = null;
				}
				else {
					recycleBinListFirst = null;
				}
				particle.pos.x = x0;
				particle.pos.y = y0;
				particle.pos.z = z0;
				particle.vel.x = velX;
				particle.vel.y = velY;
				particle.vel.z = velZ;
			}
			//if the recycle bin is empty, create a new particle:
			else {
				particle = new Particle3D(x0,y0,z0,velX,velY,velZ);
			}
			
			particle.age = 0;
			particle.dead = false;
			
			//add to beginning of onStageList
			if (first == null) {
				first = particle;
				particle.prev = null; //may be unnecessary
				particle.next = null;
			}
			else {
				particle.next = first;
				first.prev = particle;  //may be unnecessary
				first = particle;
				particle.prev = null; //may be unnecessary
			}
												
			return particle;
		}
						
		public function recycleParticle(particle:Particle3D):void {
			numOnStage--;
			numInRecycleBin++;
						
			//remove from onStageList
			if (first == particle) {
				if (particle.next != null) {
					particle.next.prev = null;
					first = particle.next;
				}
				else {
					first = null;
				}
			}
			else {
				if (particle.next == null) {
					particle.prev.next = null;
				}
				else {
					particle.prev.next = particle.next;
					particle.next.prev = particle.prev;
				}
			}

			//add to recycle bin
			if (recycleBinListFirst == null) {
				recycleBinListFirst = particle;
				particle.prev = null; //may be unnecessary
				particle.next = null;
			}
			else {
				particle.next = recycleBinListFirst;
				recycleBinListFirst.prev = particle;  //may be unnecessary
				recycleBinListFirst = particle;
				particle.prev = null; //may be unnecessary
			}
		}		
	}
}
				
		
			
