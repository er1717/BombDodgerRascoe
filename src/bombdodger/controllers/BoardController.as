package bombdodger.controllers
{
	import bombdodger.events.BoardEvent;
	import bombdodger.events.GameEvent;
	import bombdodger.models.BoardModel;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	public class BoardController extends EventDispatcher
	{
		
		public function BoardController()
		{
			this.init();
		}
		
		
		private function init():void
		{
			this.addEventListeners();
		}
		
		private function addEventListeners():void
		{	
			GameController.gameController.addEventListener(GameEvent.GAME_BOARD_DATA_START, this.onGameBoardDataStart);
			this.addEventListener(BoardEvent.BOARD_DATA_SETUP_COMPLETE, this.onBoardDataSetupComplete);
			this.addEventListener(BoardEvent.BOARD_GAME_NO_MORE_TILES, this.onNoMoreTiles);
			this.addEventListener(BoardEvent.BOARD_BOMB_CLICKED, this.onBoardBombClicked);
			this.addEventListener(BoardEvent.BOARD_UPDATE_REMANING_TILES, this.onBoardUpdateRemainingTile);
		}
		
		private function onBoardBombClicked(inEvent:BoardEvent):void
		{
			GameController.gameController.dispatchEvent(new BoardEvent(BoardEvent.BOARD_BOMB_CLICKED, inEvent.command));
		}
		
		private function onBoardUpdateRemainingTile(inEvent:BoardEvent):void
		{
			GameController.gameController.dispatchEvent(new BoardEvent(BoardEvent.BOARD_UPDATE_REMANING_TILES, inEvent.command));
		}
		
		
		private function onNoMoreTiles(inEvent:BoardEvent):void
		{
			GameController.gameController.dispatchEvent(new BoardEvent(BoardEvent.BOARD_GAME_NO_MORE_TILES, inEvent.command));
		}
		
		private function onBoardDataSetupComplete(inEvent:BoardEvent):void
		{
			GameController.gameController.dispatchEvent(new GameEvent(GameEvent.GAME_BOARD_DATA_COMPLETE, null));	
		}
		
		private function onGameBoardDataStart(inEvent:GameEvent):void
		{
			this.dispatchEvent(new BoardEvent(BoardEvent.BOARD_DATA_SETUP_INIT, null));
		}
		
		
		
		public function onBoardAlertRestart(inEvent:Event):void
		{
			GameController.gameController.dispatchEvent(new BoardEvent(BoardEvent.BOARD_ALERT_RESTART, null));
		}
		
		public function onBoardAlertQuit(inEvent:Event):void
		{
			//No logic for now
		}
	}
}

