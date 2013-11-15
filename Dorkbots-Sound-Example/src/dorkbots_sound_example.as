package
{
	import dorkbots_sound_example.DorkbotsSoundSystemFacade;
	
	import flash.display.Sprite;
	
	[SWF( width='800', height='600', frameRate='30', backgroundColor='#666666' )]
	public class dorkbots_sound_example extends Sprite
	{
		public function dorkbots_sound_example()
		{
			var facade:DorkbotsSoundSystemFacade = DorkbotsSoundSystemFacade.getInstance();
			trace(facade);
			facade.startup(this);			
		}
	}
}