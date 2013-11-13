package dorkbots.dorkbots_vector2D
{
	public class CrossedVectorCheck
	{
		public function CrossedVectorCheck()
		{
		}
		public static function crossedVector(v1:EuclideanVector2D, v2:EuclideanVector2D):Boolean
		{
			// Vector between v0 start point and v1
			var v3:EuclideanVector2D = new EuclideanVector2D(v2.position, v1.position);
			// dot products
			var dp1:Number = v3.dotProdCollision(v2.leftNormal);
			//Check if v1 has crossed v2 from right to left
			if(dp1 <= 0) return true else return false;
		}
	}
}