package bombdodger.events
{
	import starling.events.Event;
	
	public class GameEvent extends Event
	{
		private var _command:* = null;
		public static const GAME_CONSTRUCTED_EVENT:String = "GAME_CONSTRUCTED_EVENT";
		public static const GAME_BUILD_VIEWS:String = "GAME_DATA_SETUP_COMPLETE";
		public static const GAME_TILE_DATA_START:String = "GAME_TILE_DATA_START";
		public static const GAME_TILE_DATA_COMPLETE:String = "GAME_TILE_DATA_COMPLETE";
		public static const GAME_BOARD_DATA_START:String = "GAME_BOARD_DATA_START";
		public static const GAME_BOARD_DATA_COMPLETE:String = "GAME_BOARD_DATA_COMPLETE";
		public static const GAME_BOARD_WIN:String = "GAME_BOARD_WIN";
		public static const GAME_BOARD_LOSE:String = "GAME_BOARD_LOSE";
		public static const GAME_BOARD_UPDATE_REMAINING_TILES:String = "GAME_BOARD_UPDATE_REMAINING_TILES";
		public static const GAME_MENU_DATA_START:String = "GAME_MENU_DATA_START";
		public static const GAME_MENU_DATA_COMPLETE:String = "GAME_MENU_DATA_COMPLETE";
		public static const GAME_MENU_LEVEL_SELECTED:String = "GAME_MENU_LEVEL_SELECTED";
		public static const GAME_MENU_TILES_UPDATE:String = "GAME_MENU_TILES_UPDATE";
		public static const GAME_MENU_RESTART:String = "GAME_MENU_RESTART";
		public static const GAME_MENU_CLICK_MODE_CHANGE:String = "GAME_MENU_CLICK_MODE_CHANGE";
		
		
		public function GameEvent(type:String, command:*=null, bubbles:Boolean=false, data:Object=null)
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