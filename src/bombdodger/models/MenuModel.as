package bombdodger.models
{
	import bombdodger.assets.Assets;
	import bombdodger.controllers.GameController;
	import bombdodger.controllers.MenuController;
	import bombdodger.enumerations.Enums;
	import bombdodger.events.GameEvent;
	import bombdodger.events.MenuEvent;
	import bombdodger.views.Game;
	
	import feathers.data.ListCollection;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.display.Image;
	import starling.events.EventDispatcher;
	import starling.textures.Texture;

	
	public class MenuModel extends EventDispatcher
	{
		private var _menuController:MenuController;
		private var _menuBackGroundTexture:Texture;
		private var _currentState:String;
		private var _gameLevel:String;
		private var _gameLevelTime:int;
		private var _gameTimer:Timer;
		private var _gameTimerDelay:int = 1000;
		private var _remainingTiles:int;
		private var _levellsButtonData:ListCollection;
		private var _beginHeaderText:String; 
		private var _menuPlayInstructions:String;
		private var _menuPlayReturnButtonText:String;

		
		
		public function MenuModel(inController:MenuController)
		{
			this._menuController = inController;
			this.addEventListeners();
		}
		
		private function init():void
		{
			this._currentState =  Enums.MENU_BEGIN_VIEW;
			this._gameLevel = Enums.MENU_GAME_LEVEL_EASY;
			this._beginHeaderText = Enums.MENU_BEGIN_HEADER;
			this._menuPlayReturnButtonText = Enums.MENU_PLAY_RESTART_BUTTON_TEXT;
			this._menuPlayInstructions = Enums.MENU_PLAY_INSTRUCTIONS;
			this.makeButtonsListCollection();
			this.makeTimer();
			this._menuBackGroundTexture = Assets.assets.getMenuBackgroundTexture();
			this._menuController.dispatchEvent(new MenuEvent(MenuEvent.MENU_DATA_SETUP_COMPLETE, null));
		}
		
		private function makeTimer():void
		{
			this._gameTimer = new Timer(0, 0);
			this._gameTimer.addEventListener(TimerEvent.TIMER, this.onTimerEvent,false,0,true);
			this._gameTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onGameTimerComplete,false,0,true);
		}

		
		protected function onGameTimerComplete(event:TimerEvent):void
		{
			this._gameTimer.stop();
			this._menuController.dispatchEvent(new MenuEvent(MenuEvent.MENU_OUT_OF_TIME,null));
		}
		
		protected function onTimerEvent(inEvent:TimerEvent):void
		{
			var displayTime:int = this._gameLevelTime - this._gameTimer.currentCount;
			this.dispatchEvent( new MenuEvent(MenuEvent.MENU_UPDATE_TIME, displayTime));
		}
		
		
		private function addEventListeners():void
		{
			this._menuController.addEventListener(MenuEvent.MENU_DATA_SETUP_INIT, this.onMenuDataSetup);
			GameController.gameController.addEventListener(GameEvent.GAME_BUILD_VIEWS, this.onGameBuildViews);
			GameController.gameController.addEventListener(GameEvent.GAME_MENU_LEVEL_SELECTED, this.onGameLevelSelected);
			GameController.gameController.addEventListener(GameEvent.GAME_MENU_TILES_UPDATE, this.onTilesUpdate);
			GameController.gameController.addEventListener(GameEvent.GAME_MENU_RESTART, this.onMenuRestart);
			GameController.gameController.addEventListener(GameEvent.GAME_BOARD_UPDATE_REMAINING_TILES, this.onTilesUpdate);
			GameController.gameController.addEventListener(GameEvent.GAME_BOARD_WIN, this.onBoardGameWin);
			GameController.gameController.addEventListener(GameEvent.GAME_BOARD_LOSE, this.onBoardGameLose);
		}
		
		private function onBoardGameLose(inEvent:GameEvent):void
		{
			this._gameTimer.stop();
		}
		
		private function onBoardGameWin(inEvent:GameEvent):void
		{
			this._gameTimer.stop();
		}		
		
		private function onMenuRestart(inEvent:GameEvent):void
		{
			this.changeState();
		}
		
		private function onTilesUpdate(inEvent:GameEvent):void
		{
			this._remainingTiles = inEvent.command;
			this.dispatchEvent( new MenuEvent(MenuEvent.MENU_UPDATE_DATA, this._remainingTiles));
		}
		
		private function onGameLevelSelected(inEvent:GameEvent):void
		{
			this._gameLevel = inEvent.command;
			this.determineGameLevelTime(this._gameLevel);
			this.changeState();
		}
		
		private function determineGameLevelTime(inGameLevel:String):void
		{
			switch (inGameLevel) 
			{
				case Enums.MENU_GAME_LEVEL_EASY:
					this._gameLevelTime = Enums.MENU_GAME_LEVEL_EASY_TIME;
					break;
				case Enums.MENU_GAME_LEVEL_MEDIUM:
					this._gameLevelTime = Enums.MENU_GAME_LEVEL_MEDIUM_TIME;
					break;
				case Enums.MENU_GAME_LEVEL_HARD:
					this._gameLevelTime = Enums.MENU_GAME_LEVEL_HARD_TIME;
					break;
				default:
					this._gameLevelTime = Enums.MENU_GAME_LEVEL_EASY_TIME;
			}
		}
		
		private function resetGameTimer():void
		{
			this._gameTimer.reset();
			this._gameTimer.delay = this._gameTimerDelay;
			this._gameTimer.repeatCount = this._gameLevelTime;
			this._gameTimer.start();
		}
		
		private function changeState():void
		{
			if(this._currentState == Enums.MENU_BEGIN_VIEW)
			{
				this._currentState = Enums.MENU_PLAY_VIEW;
				this.resetGameTimer();
			}
			else if(this._currentState == Enums.MENU_PLAY_VIEW)
			{
				this._currentState = Enums.MENU_BEGIN_VIEW;
			}
			
			this.dispatchEvent( new MenuEvent(MenuEvent.MENU_CHANGE_STATE, this._currentState));
		}
	
		
		private function onGameBuildViews(inEvent:GameEvent):void
		{
			this.dispatchEvent( new MenuEvent(MenuEvent.MENU_BUILD_VIEW, this._currentState));
			
		}
		
		private function makeButtonsListCollection():void
		{
			this._levellsButtonData = new ListCollection(
				[
					{ label: Enums.MENU_GAME_LEVEL_EASY, triggered: this._menuController.onLevelSelectionClick },
					{ label: Enums.MENU_GAME_LEVEL_MEDIUM, triggered: this._menuController.onLevelSelectionClick },
					{ label: Enums.MENU_GAME_LEVEL_HARD, triggered: this._menuController.onLevelSelectionClick },
				]);
		}
		
		
		private function onMenuDataSetup(inEvent:MenuEvent):void
		{
			this.init();
		}
		
		public function get menuBackGround():Image
		{
			return new Image(this._menuBackGroundTexture);	
		}
		
		public function get levelsButtonData():ListCollection
		{
			return this._levellsButtonData;
		}
		
		public function get begineHeaderText():String
		{
			return this._beginHeaderText;
		}
		
		
		public function get menuPlayInstructions():String
		{
			return this._menuPlayInstructions;
		}
		
		
		public function get menuReturnButtonText():String
		{
			return this._menuPlayReturnButtonText;
		}
	}
}