package bombdodger.views
{
	import bombdodger.controllers.BoardController;
	import bombdodger.controllers.GameController;
	import bombdodger.data.TileDataItem;
	import bombdodger.events.BoardEvent;
	import bombdodger.events.GameEvent;
	import bombdodger.models.BoardModel;
	import bombdodger.models.GameModel;
	import bombdodger.views.tiles.Tile;
	
	import feathers.controls.Alert;
	import feathers.data.ListCollection;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.textures.Texture;
	
	public class Board extends Sprite
	{
		private var _backGround:Image;
		private var _boardWidth:int = 800;
		private var _boardHeight:int = 500;
		private var _tilesVector:Vector.<Tile>;
		private var _boardModel:BoardModel;
		private var _boardController:BoardController

		
		public function Board(inModel:BoardModel, inController:BoardController)
		{
			this._boardModel = inModel;
			this._boardController = inController;
			this.addEventListeners();
		}
		
		
		private function init():void
		{
			this.setupVars();
			this.addBackground();
		}
		
		
		private function setupVars():void
		{
			this._backGround = this._boardModel.backgroundImage;
			this._boardWidth = this._boardModel.boardWidth;
			this._boardHeight = this._boardModel.boardHeight;
		}
		
		
		private function addBackground():void
		{
			this.addChild(this._backGround);
		}
		
		
		private function addTiles():void
		{
			var yPos:int = 0;
			var xPos:int = 0;
			var tempRowIndex:int = 0;

			for(var i:int=0; i<this._tilesVector.length; i++)
			{
				var tempTile:Tile = this._tilesVector[i];
				this.addChild(tempTile);
				
				xPos = xPos;
				if(i == 0) xPos = 0-tempTile.width;
				if((xPos + tempTile.width) > this._boardWidth - tempTile.width)
				{
					yPos = yPos + tempTile.height;
					xPos = 0;
					tempRowIndex++;
				}
				else
				{
					xPos = xPos + tempTile.width;
				}
				
				tempTile.x = xPos;
				tempTile.y = yPos;
				tempTile.update();
			}
		}
		
		private function clearBoard():void
		{
			while(this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
			
			this.addBackground();
			
			while(this._tilesVector!= null && this._tilesVector.length > 0)
			{
				this._tilesVector.pop();
			}
			
			this._tilesVector = null;
		}
		
		
		private function addEventListeners():void
		{
			this._boardModel.addEventListener(BoardEvent.BOARD_BUILD_VIEW,  this.onBoardBuildView);
			this._boardModel.addEventListener(BoardEvent.BOARD_REVEAL_CLICKED_TILE, this.onBoardRevealClicked);
			this._boardModel.addEventListener(BoardEvent.BOARD_REVEAL_TILE, this.onBoardRevealClicked);
			this._boardModel.addEventListener(BoardEvent.BOARD_BOMB_CLICKED, this.onBoardBombClicked);
			this._boardModel.addEventListener(BoardEvent.BOARD_CLEAR_DATA, this.onBoardClearData);
			this._boardModel.addEventListener(BoardEvent.BOARD_BUILD_COMPLETE, this.onBoardBuildComplete);
			GameController.gameController.addEventListener(GameEvent.GAME_BOARD_WIN, this.onBoardGameWin);
		}
		
		
		private function onBoardGameWin(inEvent:GameEvent):void
		{
			this.addAlert(true);
		}		
		
		private function onBoardBuildComplete(inEvent:BoardEvent):void
		{
			this._tilesVector = inEvent.command;
			this.addTiles();
			this.touchable = true;
		}
		
		private function onBoardClearData(inEvent:BoardEvent):void
		{
			this.clearBoard();
		}
		
		private function onBoardBombClicked(inEvent:BoardEvent):void
		{
			var tempTileDataItem:TileDataItem;
			var tempTile:Tile;
			
			tempTile = this._tilesVector[inEvent.command];
			tempTile.showHighLite();
			
			for(var i:int=0; i<this._tilesVector.length; i++)
			{
				tempTile = Tile(this._tilesVector[i]);
				tempTileDataItem = tempTile.tileDataItem;
				if(tempTileDataItem.isBomb) tempTile.hideCover();
			}
			this.touchable = false;
			this.addAlert(false);
		}
		
		private function addAlert(inWin:Boolean=false):void
		{
			var messageText:String = this._boardModel.getAlertText(inWin);
			var alert:Alert = Alert.show( messageText, "", this._boardModel.getAlertListCollection());
			
			alert.width = this._boardWidth/5;
			alert.height = this._boardWidth/5;
		}
		
		
		private function onBoardRevealClicked(inEvent:BoardEvent):void
		{
			var tempIndex:int = inEvent.command;
			Tile(this._tilesVector[tempIndex]).hideCover();
		}
		
		private function onBoardBuildView(inEvent:BoardEvent):void
		{
			this.init();
		}		
		
		public function set boardHeight(inHeight:int):void
		{
			this._boardHeight = inHeight;
		}
		
		public function set boardWidth(inWidth:int):void
		{
			this._boardWidth = inWidth;
		}
		
	}
}