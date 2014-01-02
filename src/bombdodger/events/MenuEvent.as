package bombdodger.events
{
	import starling.events.Event;
	
	public class MenuEvent extends Event
	{
		private var _command:* = null;
		public static const MENU_DATA_SETUP_INIT:String = "MENU_DATA_SETUP_INIT";
		public static const MENU_DATA_SETUP_COMPLETE:String = "MENU_DATA_SETUP_COMPLETE";
		public static const MENU_BUILD_VIEW:String = "MENU_BUILD_VIEW";
		public static const MENU_UPDATE_DATA:String = "MENU_UPDATE_DATA";
		public static const MENU_UPDATE_TIME:String = "MENU_UPDATE_TIME";
		public static const MENU_CHANGE_STATE:String = "MENU_CHANGE_STATE";
		public static const MENU_RESTART:String = "MENU_RESTART";
		public static const MENU_GAME_LEVEL_SELECTION:String = "MENU_GAME_LEVEL_SELECTION";
		public static const MENU_TILES_UPDATE:String = "MENU_TILES_UPDATE";
		public static const MENU_CLICK_MODE_CHANGE:String = "MENU_CLICK_MODE_CHANGE";
		public static const MENU_OUT_OF_TIME:String = "MENU_OUT_OF_TIME";
		
		
		
		public function MenuEvent(type:String, command:*=null, bubbles:Boolean=false, data:Object=null)
		{
			this._command = command;
			super(type, bubbles, data);
		}
		
		public function get command():*
		{
			return _command;
		}
	}
}