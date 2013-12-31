package bombdodger.models
{
	import bombdodger.controllers.BoardController;
	import bombdodger.controllers.MenuController;
	import bombdodger.controllers.TileController;
	import bombdodger.views.Board;
	import bombdodger.views.Game;
	import bombdodger.views.tiles.Tile;
	
	import starling.events.EventDispatcher;
	
	public class GameModel extends EventDispatcher
	{
		private static var _instance:GameModel;
		private var _gameView:Game;
		private var _board:Board;
		private var _boardModel:BoardModel;
		private var _boardController:BoardController;
		private var _menuModel:MenuModel;
		private var _menuController:MenuController;
		private var _tileModel:TileModel;
		private var _tileController:TileController;

		
		public function GameModel(inSingletonEnforcer:SingletonEnforcer)
		{
			this.init();
		}
		
		public static function get gameModel():GameModel
		{
			if (_instance == null) 
			{ 
				_instance = new GameModel(new SingletonEnforcer()); 
			}
			return _instance;
		}
		
		private function init():void
		{
			this._tileController = new TileController();
			this._tileModel = new TileModel(this._tileController);
			
			this._menuController = new MenuController();
			this._menuModel = new MenuModel(this._menuController);
			
			this._boardController = new BoardController();
			this._boardModel = new BoardModel(this._boardController, this._tileModel, this._tileController);

		}
		
		public function get boardModel():BoardModel
		{
			return this._boardModel;
		}
		
		public function get boardController():BoardController
		{
			return this._boardController;
		}
		
		public function get menuModel():MenuModel
		{
			return this._menuModel;
		}
		
		public function get menuController():MenuController
		{
			return this._menuController;
		}
	}
}

class SingletonEnforcer
{
	public function SingletonEnforcer()
	{
	}
}