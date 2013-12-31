package bombdodger.models
 {
	import bombdodger.assets.Assets;
	import bombdodger.controllers.GameController;
	import bombdodger.controllers.TileController;
	import bombdodger.events.GameEvent;
	import bombdodger.events.TileEvent;
	import bombdodger.views.tiles.Tile;
	
	import flash.utils.Dictionary;
	
	import starling.display.Image;
	import starling.events.EventDispatcher;
	import starling.textures.Texture;
	
	public class TileModel extends EventDispatcher
	{
		private var _tilesVector:Vector.<Tile>;
 		private var _tileDimension:int = 25;
		private var _tileBackGroundTexture:Texture;
		private var _tileHighLiteTexture:Texture;
		private var _tileCoverTexture:Texture;
		private var _tileBomb:Texture;
		private var _tileMark:Texture;
		private var _tileController:TileController;
		private var _textColorDictionary:Dictionary;
		private var _clickMode:int;
		
		
		public function TileModel(inTileController:TileController)
		{
			this._tileController = inTileController;
			this.addEventListeners();
		}


		private function init():void
		{
			this.setupColorDictionary();
			this._tileBackGroundTexture = Assets.assets.getTileBackgroundTexture();
			this._tileHighLiteTexture = Assets.assets.getBombHighLiteTexture();
			this._tileCoverTexture = Assets.assets.getTileCoverTexture();
			this._tileBomb = Assets.assets.getBombTexture();
			this._tileController.dispatchEvent(new TileEvent(TileEvent.TILE_DATA_SETUP_COMPLETE, null));
			this._tileMark = Assets.assets.getMarkTexture();
		}
		
		private function setupColorDictionary():void
		{
			this._textColorDictionary = new Dictionary();
			this._textColorDictionary["1"] = 0x0000FF;
			this._textColorDictionary["2"] = 0x33CC33;
			this._textColorDictionary["3"] = 0xCC0000;
			this._textColorDictionary["4"] = 0xFF6600;
			this._textColorDictionary["5"] = 0xFFFF00;
			this._textColorDictionary["6"] = 0x00FFFF;
			this._textColorDictionary["7"] = 0x9933FF;
			this._textColorDictionary["8"] = 0xFFCC00;
		}
		
		public function getValueBasedTextColor(inString:String):uint
		{
			return this._textColorDictionary[inString];
		}
		
		
		private function addEventListeners():void
		{
			this._tileController.addEventListener(TileEvent.TILE_DATA_SETUP_INIT, this.onDataSetupInit);
			GameController.gameController.addEventListener(GameEvent.GAME_MENU_CLICK_MODE_CHANGE, this.onGameMenuClickModeChange);
		}
		
		private function onGameMenuClickModeChange(inEvent:GameEvent):void
		{
			this._clickMode = inEvent.command;
		}
		
		private function onDataSetupInit(inEvent:TileEvent):void
		{
			this.init();
		}
		
		public function set tiles(inVector:Vector.<Tile>):void
		{
			this._tilesVector = inVector;
		}
		
		public function get tileBackGround():Image
		{
			return new Image(this._tileBackGroundTexture);	
		}
		
		public function get tileHighLite():Image
		{
			return new Image(this._tileHighLiteTexture);
		}
		
		public function get tileCover():Image
		{
			return new Image(this._tileCoverTexture);
		}
		
		public function get markCover():Image
		{
			return new Image(this._tileMark);
		}
		
		public function get tileBomb():Image
		{
			return new Image(this._tileBomb);
		}
		
		public function get clickMode():int
		{
			return this._clickMode;
		}
	}
}