package bombdodger.views.tiles
{
	import bombdodger.controllers.TileController;
	import bombdodger.data.TileDataItem;
	import bombdodger.events.TileEvent;
	import bombdodger.interfaces.IBoardSpace;
	import bombdodger.models.GameModel;
	import bombdodger.models.TileModel;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class Tile extends Sprite implements IBoardSpace
	{
		private var _backGround:Image;
		private var _highLite:Image;
		private var _cover:Image;
		private var _tileDimension:int = 25;
		private var _tileBackGroundColor:uint = 0x888888;
		private var _tileBackGroundStrokeColor:uint = 0x444444;
		private var _tileCoverColor:uint = 0x444444;
		private var _tileCoverStrokeColor:uint = 0x000000;
		private var _rowIndex:int;
		private var _columnIndex:int;
		private var _tileIndex:int;
		public var _tileDataItem:TileDataItem;
		protected var _tileModel:TileModel;
		protected var _tileController:TileController;
		protected var _markImage:Image;
		public var _textField:TextField;
		
		
		public function Tile(inModel:TileModel, inController:TileController)
		{
			this._tileModel = inModel;
			this._tileController = inController;
			this.init();
		}
		
		 public function init():void
		 {
			 this.drawLayers();
		 }
		 
		 protected function drawLayers():void
		 {
			 this.makeBackground();
			 this.makeHighLite();
			 this.makeTextField();
			 this.makeCover();
			 this.makeMark();
			 this.addEventListeners();
		 }
		 
		 protected function makeTextField():void
		 {
			 this._textField = new TextField(25,25,"2");
			 this.addChild(this._textField);
		 }
		
		public function makeBackground():void
		{	
			this._backGround = this._tileModel.tileBackGround;
			this.addChild(this._backGround);
		}
		
		public function makeMark():void
		{	
			this._markImage = this._tileModel.markCover
			this.addChild(this._markImage);
			this._markImage.visible = false;
		}
		
		protected function makeHighLite():void
		{
			this._highLite = this._tileModel.tileHighLite;
			this.addChild(this._highLite);
			this.hideHighLite();
		}
		
		 
		public function makeCover():void
		{	
			this._cover = this._tileModel.tileCover;
			this.addChild(this._cover);
		}
		
		public function addEventListeners():void
		{
			this.addEventListener(starling.events.TouchEvent.TOUCH, this.onTouch);
		}
	
		
		public function onTouch(inTouchEvent:TouchEvent):void
		{
			var touch:Touch = inTouchEvent.getTouch(this.stage);
			var touches:Vector.<Touch> = inTouchEvent.getTouches(this,TouchPhase.BEGAN);
			if(touches.length == 0)
			{	
				return;
			}
			else
			{
				this.handleTileClick();
			}
		}
		
		
		private function handleTileClick():void
		{
			if(this._tileModel.clickMode == 0)
			{
				this._tileController.dispatchEvent(new TileEvent(TileEvent.TILE_CLICK_EVENT, this._tileDataItem));
			}
			else if(this._tileModel.clickMode == 1)
			{
				this.handleMarking();
			}
		}
		
		
		private function handleMarking():void
		{
			if(this.tileDataItem.isMarked == true)
			{
				this.unMarkTile();
			}
			else if(this.tileDataItem.isMarked == false)
			{
				this.markTile();
			}
		}
		
		private function markTile():void
		{
			this.tileDataItem.isMarked = true;
			this._markImage.visible = true;
		}
		
		private function unMarkTile():void
		{
			this.tileDataItem.isMarked = false;
			this._markImage.visible = false;
		}
		
		
		public function hideHighLite():void
		{
			this._highLite.visible = false;
		}
		
		public function showHighLite():void
		{
			this._highLite.visible = true;
		}
		
		public function set tileText(inString:String):void
		{
			this._textField.text = inString;
			var tempColor:uint = this._tileModel.getValueBasedTextColor(inString);
			this._textField.color = tempColor;
		}
		
		public function set tileDataItem(inTileDataItem:TileDataItem):void
		{
			this._tileDataItem = inTileDataItem;
		}
		
		public function set tileDimension(inTileDimension:int):void
		{
			this._tileDimension = inTileDimension;
		}
		
		public function set tileIndex(inIndex:int):void
		{
			this._tileIndex = inIndex;
		}
		
		
		public function set rowIndex(inRowIndex:int):void
		{
			this._rowIndex = inRowIndex;
		}
		
		public function set columnIndex(inColIndex:int):void
		{
			this._columnIndex = inColIndex;
		}
		
		/**
		 *Returns the rowIndex 
		 * @return 
		 * 
		 */		
		public function get rowIndex():int
		{
			return this._rowIndex;
		}
		
		public function get columnIndex():int
		{
			return this._columnIndex;
		}
		
		/**
		 *Returns the tileIndex 
		 * @return 
		 * 
		 */		
		public function get tileIndex():int
		{
			return this._tileIndex;
		}
		
		
		public function get tileDataItem():TileDataItem
		{
			return this._tileDataItem;
		}
		
		public function update():void
		{
			var tempint:int = this._tileDataItem.neighborBombs;
			var tempString:String = String(this._tileDataItem.neighborBombs);
			
			if(tempint == 0)
			{
				tempString = "";
			}
			this._textField.text = tempString;

			var tempColor:uint = this._tileModel.getValueBasedTextColor(tempString);
			this._textField.color = tempColor;
		}
		
		public function hideCover():void
		{
			this._cover.visible = false;
			this._markImage.visible = false;
		}
	}
}