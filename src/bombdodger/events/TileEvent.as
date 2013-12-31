package bombdodger.events
{
	import starling.events.Event;
	
	public class TileEvent extends Event
	{
		private var _command:* = null;
		public static const TILE_INIT_EVENT:String = "TILE_INIT_EVENT";
		public static const TILE_CLICK_EVENT:String = "TILE_CLICK_EVENT";
		public static const TILE_STATE_CHANGE:String = "TILE_STATE_CHANGE";
		public static const TILE_DATA_SETUP_INIT:String = "TILE_DATA_SETUP_INIT";
		public static const TILE_DATA_SETUP_COMPLETE:String = "TILE_DATA_SETUP_COMPLETE";
		
		public function TileEvent(type:String,command:*=null, bubbles:Boolean=false, data:Object=null)
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