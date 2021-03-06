package bombdodger.controllers
{
	import bombdodger.events.*;
	import bombdodger.views.Game;
	
	import flash.events.Event;
	
	import starling.events.EventDispatcher;
	
	public class GameController extends EventDispatcher
	{
		private static var _instance:GameController;
		
		public function GameController(inSingletonEnforcer:SingletonEnforcer)
		{
			this.init();
		}
		
		public static function get gameController():GameController
		{
			if (_instance == null) 
			{ 
				_instance = new GameController(new SingletonEnforcer()); 
			}
			return _instance;
		}
		
		
		private function init():void
		{
			this.addEventListeners();
		}
		
		private function addEventListeners():void
		{
			this.addEventListener(GameEvent.GAME_CONSTRUCTED_EVENT, this.onGameConstructed);
			this.addEventListener(GameEvent.GAME_TILE_DATA_COMPLETE, this.onTileDataComplete);
			this.addEventListener(GameEvent.GAME_BOARD_DATA_COMPLETE, this.onBoardDataComplete);
			this.addEventListener(GameEvent.GAME_MENU_DATA_COMPLETE, this.onMenuDataComplete);
			this.addEventListener(MenuEvent.MENU_GAME_LEVEL_SELECTION, this.onMenuLevelSelection);
			this.addEventListener(MenuEvent.MENU_RESTART, this.onMenuRestart);
			this.addEventListener(MenuEvent.MENU_OUT_OF_TIME, this.onMenuOutOfTime);
			this.addEventListener(MenuEvent.MENU_CLICK_MODE_CHANGE, this.onClickModeChange);
			this.addEventListener(BoardEvent.BOARD_ALERT_RESTART, this.onBoardAlertRestart);
			this.addEventListener(BoardEvent.BOARD_GAME_NO_MORE_TILES, this.onBoardGameNoMoreTiles);
			this.addEventListener(BoardEvent.BOARD_BOMB_CLICKED, this.onBoardBombClicked);
			this.addEventListener(BoardEvent.BOARD_UPDATE_REMANING_TILES, this.onBoardUpdateRemainintTiles);
		}	
		
		private function onMenuOutOfTime(inEvent:MenuEvent):void
		{
			this.dispatchEvent(new GameEvent(GameEvent.GAME_BOARD_LOSE, inEvent.command));
		}		
		
		private function onBoardBombClicked(inEvent:BoardEvent):void
		{
			this.dispatchEvent(new GameEvent(GameEvent.GAME_BOARD_LOSE, inEvent.command));
		}		
		
		private function onClickModeChange(inEvent:MenuEvent):void
		{
			this.dispatchEvent(new GameEvent(GameEvent.GAME_MENU_CLICK_MODE_CHANGE,inEvent.command));
		}		
		
		private function onBoardUpdateRemainintTiles(inEvent:BoardEvent):void
		{
			this.dispatchEvent(new GameEvent(GameEvent.GAME_BOARD_UPDATE_REMAINING_TILES,inEvent.command));
		}
		
		private function onBoardGameNoMoreTiles(inEvent:BoardEvent):void
		{
			this.dispatchEvent(new GameEvent(GameEvent.GAME_BOARD_WIN));
		}
		
		private function onBoardAlertRestart(inEvent:BoardEvent):void
		{
			this.dispatchEvent(new GameEvent(GameEvent.GAME_MENU_RESTART));
		}
		
		private function onMenuRestart(inEvent:MenuEvent):void
		{
			this.dispatchEvent(new GameEvent(GameEvent.GAME_MENU_RESTART));
		}
		
		private function onMenuLevelSelection(inEvent:MenuEvent):void
		{
			this.dispatchEvent(new GameEvent(GameEvent.GAME_MENU_LEVEL_SELECTED, inEvent.command));
		}
		
		private function onGameConstructed(inEvent:GameEvent):void
		{
			//trace("Game classes are setup....");
			this.dispatchEvent(new GameEvent(GameEvent.GAME_TILE_DATA_START, inEvent.command));
		}
		
		private function onTileDataComplete(inEvent:GameEvent):void
		{
			//trace("Tile Data is setup complete...");
			this.dispatchEvent(new GameEvent(GameEvent.GAME_BOARD_DATA_START, inEvent.command));
		}
		
		private function onBoardDataComplete(inEvent:GameEvent):void
		{
			//trace("Board Data is setup complete...");
			this.dispatchEvent(new GameEvent(GameEvent.GAME_MENU_DATA_START, inEvent.command));
		}	
		
		private function onMenuDataComplete(inEvent:GameEvent):void
		{
			//trace("Menu Data is setup complete...");
			this.dispatchEvent(new GameEvent(GameEvent.GAME_BUILD_VIEWS, inEvent.command));
		}
	}
}
class SingletonEnforcer
{
	public function SingletonEnforcer()
	{
	}
}