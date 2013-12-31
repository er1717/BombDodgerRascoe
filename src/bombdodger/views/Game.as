package bombdodger.views
{
	import bombdodger.controllers.BoardController;
	import bombdodger.controllers.GameController;
	import bombdodger.events.GameEvent;
	import bombdodger.models.BoardModel;
	import bombdodger.models.GameModel;
	
	import flash.display.Bitmap;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	
	public class Game extends Sprite
	{
		private static var _instance:Game;
		private var _menu:Menu;
		private var _board:Board;
		private var _gameModel:GameModel;
		private var _gameController:GameController;
		
		
		public function Game(inModel:GameModel, inController:GameController)
		{
			this._gameModel = inModel;
			this._gameController = inController;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
		}

		
		/**
		 * creates and arranges all necessary pieces to create this view 
		 */		
		private function init():void
		{
			
			this._menu = new Menu(this._gameModel.menuModel, this._gameModel.menuController);
			
			this._board = new Board(this._gameModel.boardModel, this._gameModel.boardController);
			this._board.y = 100;
			
			this.addChild(this._menu);
			this.addChild(this._board);
			
			GameController.gameController.dispatchEvent(new GameEvent(GameEvent.GAME_CONSTRUCTED_EVENT, null));
		}
		
		
		
		 
		/**
		 *When the View has been added to the stage the listener is removed and view can be built 
		 */		
		private function onAddedToStage(inEvent:Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
			this.init();
		}
	}
}
