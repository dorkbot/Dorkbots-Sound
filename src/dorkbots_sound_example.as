package
{
	import flash.display.Sprite;
	
	import mvc.Controller;
	import mvc.Model;
	import mvc.RootView;
	
	[SWF( width='800', height='600', frameRate='30', backgroundColor='#666666' )]
	public class dorkbots_sound_example extends Sprite
	{
		public function dorkbots_sound_example()
		{
			var model:Model = new Model();
			var controller:Controller = new Controller(model);
			var rootView:RootView = new RootView(this, model, controller);
			controller.init(this.stage);
			controller.start();
		}
	}
}