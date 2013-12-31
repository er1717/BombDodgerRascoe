package bombdodger.events
{
	import starling.events.Event;
	
	public class BoardEvent extends Event
	{
		private var _command:* = null;
		public static const BOARD_INIT_EVENT:String = "BOARD_INIT_EVENT";
		public static const BOARD_TILE_CLICK:String = "BOARD_TILE_CLICK";
		public static const BOARD_DATA_SETUP_INIT:String = "BOARD_DATA_SETUP_INIT";
		public static const BOARD_DATA_SETUP_COMPLETE:String = "BOARD_DATA_SETUP_COMPLETE";
		public static const BOARD_BUILD_VIEW:String = "BOARD_BUILD_VIEW";
		public static const BOARD_UPDATE:String = "BOARD_UPDATE";
		public static const BOARD_REVEAL_CLICKED_TILE:String = "BOARD_REVEAL_CLICKED_TILE";
		public static const BOARD_REVEAL_TILE:String = "BOARD_REVEAL_TILE";
		public static const BOARD_BOMB_CLICKED:String = "BOARD_BOMB_CLICKED";
		public static const BOARD_GAME_WIN:String = "BOARD_GAME_WIN";
		public static const BOARD_CLEAR_DATA:String = "BOARD_CLEAR_DATA";
		public static const BOARD_BUILD_COMPLETE:String = "BOARD_BUILD_COMPLETE";
		public static const BOARD_ALERT_RESTART:String = "BOARD_ALERT_RESTART";
		public static const BOARD_UPDATE_REMANING_TILES:String = "BOARD_UPDATE_REMANING_TILES";
		
		public function BoardEvent(type:String, command:*=null, bubbles:Boolean=false, data:Object=null)
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