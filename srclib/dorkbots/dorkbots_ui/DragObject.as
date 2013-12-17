package dorkbots.dorkbots_ui
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;

	public class DragObject extends EventDispatcher
	{
		private var target_mc:DisplayObject;
		
		public function DragObject(aTarget_mc:DisplayObject)
		{
			target_mc = aTarget_mc;
			init();
		}
		
		private function init():void
		{
			target_mc.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			target_mc.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		private function mouseMove(event:MouseEvent):void
		{
			this.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE));
		}
		private function mouseDownHandler(e:MouseEvent):void
		{
			target_mc.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			e.currentTarget.startDrag();
		}
		private function mouseUpHandler(e:MouseEvent):void
		{
			target_mc.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			e.currentTarget.stopDrag();
		}
		
		public function dispose():void
		{
			target_mc.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			target_mc.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			target_mc.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			target_mc = null;
		}
	}
}