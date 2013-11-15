package dorkbots_sound_example.app.model.proxies
{
	import dorkbots_sound_example.app.model.data_vos.StateVO;
	import dorkbots_sound_example.app.notifications.notification_objects.StartupNotification;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class StateProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "StateProxy";
		
		public function StateProxy(startupVO:StartupNotification, aVo:Object = null)
		{
			//trace("[" + NAME + "]");
			
			
			if (aVo == null)
			{
				aVo = new StateVO();
			}
			
			super( NAME, aVo );
			
			vo.stage = startupVO.stage;
		}		
		
		public function get vo():StateVO
		{
			return data as StateVO;
		}
	}
}