package bombdodger.models
{
	import bombdodger.assets.Assets;
	import bombdodger.controllers.BoardController;
	import bombdodger.controllers.GameController;
	import bombdodger.controllers.TileController;
	import bombdodger.data.TileDataItem;
	import bombdodger.enumerations.Enums;
	import bombdodger.events.BoardEvent;
	import bombdodger.events.GameEvent;
	import bombdodger.events.TileEvent;
	import bombdodger.interfaces.IBoardSpace;
	import bombdodger.views.tiles.Tile;
	import bombdodger.views.tiles.TileBomb;
	import bombdodger.views.tiles.TileEmpty;
	
	import feathers.controls.Alert;
	import feathers.data.ListCollection;
	
	import starling.display.Image;
	import starling.events.EventDispatcher;
	
	public class BoardModel extends EventDispatcher
	{
		private var _tilesVector:Vector.<Tile>;
		private var _tileDataItems:Vector.<TileDataItem>;
		private var _numberOfTiles:int = 640;
		private var _remainingTiles:int = 640
		private var _diffcultyLevel:int = 1;
		private var _gameLevel:String;
		private var _boardWidth:int = 800;
		private var _boardHeight:int = 500;
		private var _tileWidth:int = 25;
		private var _tileHeight:int = 25;
		private var _boardBackground:Image;
		private var _tileModel:TileModel;
		private var _tileController:TileController;
		private var _boardController:BoardController;
		private var _boardMap:Array;
		private var _alertListCollection:ListCollection;
		
		
		public function BoardModel( inBoardController:BoardController,inModel:TileModel, inController:TileController)
		{
			this._boardController = inBoardController;
			this._tileModel = inModel;
			this._tileController = inController;
			this.addEventListeners();
		}
		
		private function init():void
		{
			this._boardController.dispatchEvent(new BoardEvent(BoardEvent.BOARD_DATA_SETUP_COMPLETE, null));
		}
		
		private function determineDiffucltyLevel(inGameLevel:String):void
		{
			switch (inGameLevel) {
				case Enums.MENU_GAME_LEVEL_EASY:
						this._diffcultyLevel = 1.95;
					break;
				case Enums.MENU_GAME_LEVEL_MEDIUM:
						this._diffcultyLevel = 2;
					break;
				case Enums.MENU_GAME_LEVEL_HARD:
						this._diffcultyLevel = 3;
					break;
				default:
					this._diffcultyLevel = 1;
			}
		}
		
		public function getAlertListCollection():ListCollection
		{
			this._alertListCollection =  new ListCollection(
				[
					{ label: Enums.BOARD_ALERT_PLAY, triggered: this._boardController.onBoardAlertRestart },
					{ label: Enums.BOARD_ALERT_QUIT, triggered: this._boardController.onBoardAlertQuit }
				]);
			
			return this._alertListCollection;
		}
		
		public function getAlertText(inWin:Boolean=false):String
		{
			var alertMessage:String;
			inWin ? alertMessage = Enums.BOARD_ALERT_MESSAGE_WIN:alertMessage = Enums.BOARD_ALERT_MESSAGE_LOSE;
			return alertMessage;
		}
		
		
		private function addEventListeners():void
		{
			this._boardController.addEventListener(BoardEvent.BOARD_DATA_SETUP_INIT, this.onBoardDataSetupInit);
			GameController.gameController.addEventListener(GameEvent.GAME_BUILD_VIEWS, this.onGameBuildViews);
			this._tileController.addEventListener(BoardEvent.BOARD_TILE_CLICK, this.onBoardTileClick);
			GameController.gameController.addEventListener(GameEvent.GAME_MENU_RESTART, this.onGameRestart);
			GameController.gameController.addEventListener(GameEvent.GAME_MENU_LEVEL_SELECTED, this.onGameLevelSelected);
		}
		
		private function onGameLevelSelected(inEvent:GameEvent):void
		{
			this._gameLevel = inEvent.command;
			this.determineDiffucltyLevel(this._gameLevel);
			this.buildNewBoardMapAndSetupBoardData();
		}
		
		private function onGameRestart(inEvent:GameEvent):void
		{
			this.clearBoardMapData();
			this.dispatchEvent(new BoardEvent(BoardEvent.BOARD_CLEAR_DATA, null));
		}
		
		private function calculateRemainingTiles():void
		{
			var remainingTiles:int = 0;
			var tempTileDataItem:TileDataItem;
			var tempTile:Tile
			for(var i:int=0; i<this._tilesVector.length; i++)
			{
				tempTile = this._tilesVector[i];
				tempTileDataItem = tempTile.tileDataItem;
				if(!tempTileDataItem.isBomb && !tempTileDataItem.revealed)
				{
					remainingTiles++
				}
			}
			
			this._remainingTiles = remainingTiles;
			
			this._boardController.dispatchEvent(new BoardEvent(BoardEvent.BOARD_UPDATE_REMANING_TILES, this._remainingTiles));
			
			if(this._remainingTiles == 0)
			{
				this._boardController.dispatchEvent(new BoardEvent(BoardEvent.BOARD_GAME_WIN, null));
			}
		}
		
		
		private function onBoardTileClick(inEvent:BoardEvent):void
		{
			var tempTileDataItem:TileDataItem = inEvent.command;
			if(tempTileDataItem.isBomb)
			{
				this.dispatchEvent(new BoardEvent(BoardEvent.BOARD_BOMB_CLICKED, tempTileDataItem.tileIndex));
			}
			else
			{
				this.dispatchEvent(new BoardEvent(BoardEvent.BOARD_REVEAL_CLICKED_TILE, tempTileDataItem.tileIndex));
				tempTileDataItem.revealed = true;
				if(tempTileDataItem.neighborBombs == 0)
				{
					this.determineEmptyNeighbors(tempTileDataItem.rowIndex, tempTileDataItem.columnIndex);
				}
				this.calculateRemainingTiles();
			}
		}
		
		
		private function onGameBuildViews(inView:GameEvent):void
		{
			this.dispatchEvent(new BoardEvent(BoardEvent.BOARD_BUILD_VIEW, null));
		}
		
		private function onBoardDataSetupInit(inEvent:BoardEvent):void
		{
			this.init();
		}
		
		private function clearBoardMapData():void
		{
			while(this._boardMap!= null && this._boardMap.length > 0)
			{
				this._boardMap.pop();
			}
			while(this._tilesVector!= null && this._tilesVector.length > 0)
			{
				this._tilesVector.pop();
			}
			while(this._tileDataItems != null && this._tileDataItems.length > 0)
			{
				this._tileDataItems.pop();
			}
		}
		
		private function buildNewBoardMapAndSetupBoardData():void
		{
			var columnsNumber:int = this._boardHeight/this._tileHeight;
			var tempArray:Array = new Array();
			this._boardMap = tempArray;
			
			for(var i:int=0; i<columnsNumber; i++)
			{
				this._boardMap.push(new Array());
			}
			
			this.setupBoardData();
			this.determineTileBombNeighborNumbers();
			this.calculateRemainingTiles();
			this.dispatchEvent(new BoardEvent(BoardEvent.BOARD_BUILD_COMPLETE, this._tilesVector));
		}
		

		private function setupBoardData():void
		{
			this._tilesVector = new Vector.<Tile>(this._numberOfTiles, false);
			this._tileDataItems = new Vector.<TileDataItem>(this._numberOfTiles, false);
			
			var tempColumnIndex:int = 0;
			var tempRowIndex:int = 0;
			var yPos:int = 0;
			var xPos:int = 0;
			var bombValue:int = 0;
			var tempColIndex:int = 0;
			
			for(var i:int=0; i<this._tilesVector.length; i++)
			{
				var tempTile:Tile = new Tile(this._tileModel, this._tileController);
				var isBomb:Boolean = false;
				var randomVal:Number = Math.random() * this._diffcultyLevel;
				var mineValue:Number = ((this._diffcultyLevel * this._diffcultyLevel) *.03) * this._diffcultyLevel;
				mineValue > randomVal ? isBomb = true:isBomb = false;
				
				if (isBomb)
				{
					bombValue++;
					tempTile = new TileBomb(this._tileModel, this._tileController);
				}
				else
				{
					tempTile = new Tile(this._tileModel, this._tileController);
				}
				
				if(i == 0) xPos = 0-this._tileWidth;
				if((xPos + this._tileWidth) > this._boardWidth - this._tileWidth)
				{
					yPos = yPos + this._tileHeight;
					xPos = 0;
					tempRowIndex++;
				}
				else
				{
					xPos = xPos + this._tileWidth;
				}
				
				tempColIndex = this._boardMap[tempRowIndex].length;
				new TileDataItem(isBomb,tempColIndex,tempRowIndex,i,xPos,yPos);

				this._boardMap[tempRowIndex].push(new TileDataItem(isBomb,tempColIndex,tempRowIndex,i,xPos,yPos))	
				
				tempTile.rowIndex = tempRowIndex;
				tempTile.columnIndex = tempColIndex;
				tempTile.tileDataItem = this._boardMap[tempRowIndex][tempColIndex] as TileDataItem;
				this._tilesVector[i] = tempTile as Tile;
			}
		}
		

		
		private function determineTileBombNeighborNumbers():void
		{		
			for(var i:int=0; i<this._tilesVector.length; i++)
			{
				var tempTileDataItem:TileDataItem = Tile(this._tilesVector[i]).tileDataItem;
				var neigborBombs:int = this.checkForNeighbors(tempTileDataItem.rowIndex, tempTileDataItem.columnIndex);
				tempTileDataItem.neighborBombs = neigborBombs;
			}
		}
		
		private function checkForNeighbors(inRowIndex:int, inTileIndex:int):int
		{
			 var tileNeighbors:int = 0;
			try
			{
				if(this._boardMap[inRowIndex-1] && this._boardMap[inRowIndex-1][inTileIndex-1] && TileDataItem(this._boardMap[inRowIndex-1][inTileIndex-1]).isBomb) tileNeighbors++ ;
				if(this._boardMap[inRowIndex-1] && this._boardMap[inRowIndex-1][inTileIndex] && TileDataItem(this._boardMap[inRowIndex-1][inTileIndex]).isBomb) tileNeighbors++ ;
				if(this._boardMap[inRowIndex-1] && this._boardMap[inRowIndex-1][inTileIndex+1] && TileDataItem(this._boardMap[inRowIndex-1][inTileIndex+1]).isBomb) tileNeighbors++ ;
				
				if(this._boardMap[inRowIndex][inTileIndex-1] && TileDataItem(this._boardMap[inRowIndex][inTileIndex-1]).isBomb) tileNeighbors++ ;
				if(this._boardMap[inRowIndex][inTileIndex+1] && TileDataItem(this._boardMap[inRowIndex][inTileIndex+1]).isBomb) tileNeighbors++ ;

				if(this._boardMap[inRowIndex+1] && this._boardMap[inRowIndex+1][inTileIndex-1] && TileDataItem(this._boardMap[inRowIndex+1][inTileIndex-1]).isBomb) tileNeighbors++ ;
				if(this._boardMap[inRowIndex+1] && this._boardMap[inRowIndex+1][inTileIndex] && TileDataItem(this._boardMap[inRowIndex+1][inTileIndex]).isBomb) tileNeighbors++ ;
				if(this._boardMap[inRowIndex+1] && this._boardMap[inRowIndex+1][inTileIndex+1] && TileDataItem(this._boardMap[inRowIndex+1][inTileIndex+1]).isBomb) tileNeighbors++ ;

			}
			catch(caughtError:Error)
			{
				//no logic for now
			}
			return tileNeighbors;
		}
		
		/**
		 * Calls methods to check for neighboring empty frames
		 * @param inRowIndex
		 * @param inTileIndex
		 * 
		 */		
		private function determineEmptyNeighbors(inRowIndex:int, inColIndex:int):void
		{
			this.topCenterNeighborIsClear(inRowIndex, inColIndex);
			this.leftNeighborIsClear(inRowIndex, inColIndex);
			this.rightNeighborIsClear(inRowIndex, inColIndex);
			this.bottomCenterNeighborIsClear(inRowIndex, inColIndex);
		}
		
		
		/**
		 * Recursive method to expose all empty frames next to the supplied index's  TOP Center
		 * @param inRowIndex
		 * @param inTileIndex
		 * 
		 */		
		private function topCenterNeighborIsClear(inRowIndex:int, inTileIndex:int):void
		{
			try
			{
				var tempTileDataItem:TileDataItem = this._boardMap[inRowIndex-1][inTileIndex];
				
				if(tempTileDataItem && !tempTileDataItem.revealed && tempTileDataItem.neighborBombs == 0  && !tempTileDataItem.isBomb)
				{
					tempTileDataItem.revealed = true;
					this.dispatchEvent(new BoardEvent(BoardEvent.BOARD_REVEAL_TILE, tempTileDataItem.tileIndex));
					this.determineEmptyNeighbors(tempTileDataItem.rowIndex, tempTileDataItem.columnIndex);
					
				}
				else if(tempTileDataItem && !tempTileDataItem.isBomb)
				{
					tempTileDataItem.revealed = true;
					this.dispatchEvent(new BoardEvent(BoardEvent.BOARD_REVEAL_TILE, tempTileDataItem.tileIndex));;
				}
			}
			catch(caughtError:Error)
			{
			}
		}
		
		
	
		private function leftNeighborIsClear(inRowIndex:int, inTileIndex:int):void
		{
			try
			{	
				var tempTileDataItem:TileDataItem = this._boardMap[inRowIndex][inTileIndex-1];
				if(tempTileDataItem && !tempTileDataItem.revealed && tempTileDataItem.neighborBombs == 0 && !tempTileDataItem.isBomb)
				{
					tempTileDataItem.revealed = true;
					this.dispatchEvent(new BoardEvent(BoardEvent.BOARD_REVEAL_TILE, tempTileDataItem.tileIndex));
					this.determineEmptyNeighbors(tempTileDataItem.rowIndex, tempTileDataItem.columnIndex);
				}
				else if(tempTileDataItem && !tempTileDataItem.isBomb)
				{
					tempTileDataItem.revealed = true;
					this.dispatchEvent(new BoardEvent(BoardEvent.BOARD_REVEAL_TILE, tempTileDataItem.tileIndex));;
				}
			}
			catch(caughtError:Error)
			{
			}
		}
		
		
	
		private function rightNeighborIsClear(inRowIndex:int, inTileIndex:int):void
		{
			try
			{	
				var tempTileDataItem:TileDataItem = this._boardMap[inRowIndex][inTileIndex+1];
				if(tempTileDataItem && !tempTileDataItem.revealed && tempTileDataItem.neighborBombs == 0  && !tempTileDataItem.isBomb)
				{
					tempTileDataItem.revealed = true;
					this.dispatchEvent(new BoardEvent(BoardEvent.BOARD_REVEAL_TILE, tempTileDataItem.tileIndex));
					this.determineEmptyNeighbors(tempTileDataItem.rowIndex, tempTileDataItem.columnIndex);
				}
				else if(tempTileDataItem && !tempTileDataItem.isBomb)
				{
					tempTileDataItem.revealed = true;
					this.dispatchEvent(new BoardEvent(BoardEvent.BOARD_REVEAL_TILE, tempTileDataItem.tileIndex));;
				}
			}
			catch(caughtError:Error)
			{
			}
		}
		
		
		/**
		 * Recursive method to expose all empty frames next to the supplied index's  bottom Center
		 * @param inRowIndex
		 * @param inTileIndex
		 * 
		 */
		private function bottomCenterNeighborIsClear(inRowIndex:int, inTileIndex:int):void
		{
			try
			{
				var tempTileDataItem:TileDataItem = this._boardMap[inRowIndex+1][inTileIndex];
				if(tempTileDataItem && !tempTileDataItem.revealed && tempTileDataItem.neighborBombs == 0  && !tempTileDataItem.isBomb)
				{
					tempTileDataItem.revealed = true;
					this.dispatchEvent(new BoardEvent(BoardEvent.BOARD_REVEAL_TILE, tempTileDataItem.tileIndex));
					this.determineEmptyNeighbors(tempTileDataItem.rowIndex, tempTileDataItem.columnIndex);
				}
				else if(tempTileDataItem && !tempTileDataItem.isBomb)
				{
					tempTileDataItem.revealed = true;
					this.dispatchEvent(new BoardEvent(BoardEvent.BOARD_REVEAL_TILE, tempTileDataItem.tileIndex));;
				}
			}
			catch(caughtError:Error)
			{
			}
		}
		
		
		public function get numberOfTiles():int
		{
			return this._numberOfTiles;
		}
		
		public function get tiles():Vector.<Tile>
		{
			return this._tilesVector;
		}
		
		public function get tileDataItems():Vector.<TileDataItem>
		{
			return this._tileDataItems;
		}
		
		public function get boardWidth():int
		{
			return this._boardWidth;
		}
		
		public function get boardHeight():int
		{
			return this._boardHeight;
		}
		
		public function get backgroundImage():Image
		{
			return new Image(Assets.assets.getBoardBackgroundTexture());
		}
		
		public function get tileModel():TileModel
		{
			return this._tileModel;
		}
		
		public function get tileController():TileController
		{
			return this._tileController;
		}
		
	}
}

