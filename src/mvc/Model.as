package mvc
{
	import dorkbots.dorkbots_broadcasters.broadcasters_state.BroadcasterState;
	import dorkbots.dorkbots_broadcasters.broadcasters_state.IBroadcasterState;
	
	public class Model extends BroadcasterState implements IBroadcasterState
	{
		public static const START:String = "start";
		public static const OPEN_SOUND_EXAMPLE:String = "open sound example";
		public static const CLOSE_SOUND_EXAMPLE:String = "close sound example";
		
		public function Model()
		{
			super();
		}
		
		override protected function setUpStates():void
		{
			addState(START);
			addState(OPEN_SOUND_EXAMPLE);
			addState(CLOSE_SOUND_EXAMPLE);
		}
	}
}