package dorkbots_sound_example.app.model.data_vos
{
	import flash.display.DisplayObjectContainer;

	public class StateVO
	{
		private var _dataReady:Boolean = false;
		private var _showApp:Boolean = false;
		private var _stageHeight:Number;
		private var _stageWidth:Number;
		private var _stage:DisplayObjectContainer;
		
		public function StateVO()
		{
			//trace("[StateVO]");
		}

		public function get stageHeight():Number
		{
			return _stageHeight;
		}

		public function set stageHeight(value:Number):void
		{
			_stageHeight = value;
		}
		
		public function get stageWidth():Number
		{
			return _stageWidth;
		}
		
		public function set stageWidth(value:Number):void
		{
			_stageWidth = value;
		}
		
		public function get stage():DisplayObjectContainer
		{
			return _stage;
		}

		public function set stage(value:DisplayObjectContainer):void
		{
			_stage = value;
		}

		public function get showApp():Boolean
		{
			return _showApp;
		}

		public function set showApp(value:Boolean):void
		{
			_showApp = value;
		}

		public function get dataReady():Boolean
		{
			return _dataReady;
		}

		public function set dataReady(value:Boolean):void
		{
			_dataReady = value;
		}
	}
}