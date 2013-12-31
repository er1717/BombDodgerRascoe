package bombdodger.controllers
{
	import bombdodger.controllers.BoardController;
	import bombdodger.controllers.GameController;
	import bombdodger.events.TileEvent;
	import bombdodger.events.GameEvent;
	import bombdodger.events.BoardEvent;
	
	import starling.events.EventDispatcher;
	
	public class TileController extends EventDispatcher
	{
		
		
		public function TileController()
		{
			this.init();
		}
		
		private function init():void
		{
			this.addEventListeners();
		}

		private function addEventListeners():void
		{
			this.addEventListener(bombdodger.events.TileEvent.TILE_CLICK_EVENT, this.onTileClicked);
			this.addEventListener(TileEvent.TILE_DATA_SETUP_COMPLETE, this.onTileDataSetupComplete);
			GameController.gameController.addEventListener(GameEvent.GAME_TILE_DATA_START, this.onTileDataSetupInit)
		}
	
		
		private function onTileClicked(inTileEvent:TileEvent):void
		{
			this.dispatchEvent(new BoardEvent(BoardEvent.BOARD_TILE_CLICK,inTileEvent.command));
		}
		
		private function onTileDataSetupComplete(inTileEvent:TileEvent):void
		{
			GameController.gameController.dispatchEvent(new GameEvent(GameEvent.GAME_TILE_DATA_COMPLETE, null));
		}
		
		private function onTileDataSetupInit(inEvent:GameEvent):void
		{
			this.dispatchEvent(new TileEvent(TileEvent.TILE_DATA_SETUP_INIT, null));
		}
	}
}
