package com.flashandmath.dg.geom3D {
	public class Point3D {
		
		public var x:Number;
		public var y:Number;
		public var z:Number;		
		
		private var outputPoint:Point3D;
		
		public function Point3D(x1:Number=0,y1:Number=0,z1:Number=0) {
			this.x = x1;
			this.y = y1;
			this.z = z1;
		}
		
		public function clone():Point3D {
			outputPoint = new Point3D();
			outputPoint.x = this.x;
			outputPoint.y = this.y;
			outputPoint.z = this.z;
			return outputPoint;
		}
	}
}
