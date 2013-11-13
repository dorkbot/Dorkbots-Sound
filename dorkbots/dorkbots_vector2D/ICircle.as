package dorkbots.dorkbots_vector2D
{
	public interface ICircle
	{
		function getCircleSprite():CircleSprite;
		function set x(value:Number):void;
		function get x():Number;
		function set y(value:Number):void;
		function get y():Number;
		function set radius(value:Number):void;
		function get radius():Number;
		function set position(aV:Vector2D):void;
		function get position():Vector2D;
	}
}