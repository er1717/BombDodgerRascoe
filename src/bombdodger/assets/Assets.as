package bombdodger.assets
{
	import bombdodger.enumerations.Enums;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	
	
	public class Assets
	{
		private static var _instance:Assets;
		private var _textures:Dictionary = new Dictionary(true);
		private var _tileDimension:int = 25;
		private var _tileBackGroundColor:uint = 0x888888;
		private var _tileBackGroundStrokeColor:uint = 0x444444;
		private var _tileCoverColor:uint = 0x444444;
		private var _tileCoverStrokeColor:uint = 0x000000;
		private var _tileBombStrokeColor:uint = 0xFF6633;
		private var _tileBombColor:uint = 0x000000;
		private var _tileHighLiteColor:uint = 0xCC0000;
		private var _tileMarkColor:uint = 0xFFFFFF;
		private var _boardBackgroundColor:uint = 0x333333;
		private var _boardBackgroundWidth:int = 800;
		private var _boardBackgroundHeight:int = 600;
		private var _menuBackgroundColor:uint = 0x777777;
		private var _menuBackgroundWidth:int = 800;
		private var _menuBackgroundHeight:int = 100;

		
		public function Assets(inSingletonEnforcer:SingletonEnforcer)
		{
		}
		
		
		public static function  get assets():Assets
		{
			if (_instance == null) 
			{ 
				_instance = new Assets(new SingletonEnforcer()); 
			}
			return _instance;
		}
		
		public function getMenuBackgroundTexture():Texture
		{
			if(this._textures[Enums.MENU_BACKGROUND] == undefined)
			{
				var tempSpriteFlash:Shape = new Shape();
				tempSpriteFlash.graphics.beginFill(this._menuBackgroundColor,1);
				tempSpriteFlash.graphics.drawRect(0,0,this._menuBackgroundWidth, this._menuBackgroundHeight);
				tempSpriteFlash.graphics.endFill();
				
				var tempBData:BitmapData = new BitmapData(this._menuBackgroundWidth,this._menuBackgroundHeight,false);
				tempBData.draw(tempSpriteFlash);
				this._textures[Enums.MENU_BACKGROUND] = Texture.fromBitmapData(tempBData);
			}
			return this._textures[Enums.MENU_BACKGROUND];
		}
		
		public function getBoardBackgroundTexture():Texture
		{
			if(this._textures[Enums.BOARD_BACKGROUND] == undefined)
			{
				var tempSpriteFlash:Shape = new Shape();
				tempSpriteFlash.graphics.beginFill(this._boardBackgroundColor,1);
				tempSpriteFlash.graphics.drawRect(0,0,this._boardBackgroundWidth, this._boardBackgroundHeight);
				tempSpriteFlash.graphics.endFill();
				
				var tempBData:BitmapData = new BitmapData(this._boardBackgroundWidth,this._boardBackgroundHeight,false);
				tempBData.draw(tempSpriteFlash);
				this._textures[Enums.BOARD_BACKGROUND] = Texture.fromBitmapData(tempBData);
			}
			return this._textures[Enums.BOARD_BACKGROUND];
		}
		
		
		public function getTileBackgroundTexture():Texture
		{
			if(this._textures[Enums.TILE_BACKGROUND] == undefined)
			{
				var tempSpriteFlash:Shape = new Shape();
				tempSpriteFlash.graphics.lineStyle(2,this._tileBackGroundStrokeColor,1);
				tempSpriteFlash.graphics.beginFill(this._tileBackGroundColor,1);
				tempSpriteFlash.graphics.drawRect(0,0, this._tileDimension, this._tileDimension);
				tempSpriteFlash.graphics.endFill();
				
				var tempBData:BitmapData = new BitmapData(this._tileDimension,this._tileDimension,false);
				tempBData.draw(tempSpriteFlash);
				this._textures[Enums.TILE_BACKGROUND] = Texture.fromBitmapData(tempBData);
			}
			return this._textures[Enums.TILE_BACKGROUND];
		}
		
		
		public function getTileCoverTexture():Texture
		{
			if(this._textures[Enums.TILE_COVER] == undefined)
			{
				var tempSpriteFlash:Shape = new Shape();
				tempSpriteFlash.graphics.lineStyle(2,this._tileCoverStrokeColor,1);
				tempSpriteFlash.graphics.beginFill(this._tileCoverColor,1);
				tempSpriteFlash.graphics.drawRect(0,0, this._tileDimension, this._tileDimension);
				tempSpriteFlash.graphics.endFill();
				
				var tempBData:BitmapData = new BitmapData(this._tileDimension,this._tileDimension,false);
				tempBData.draw(tempSpriteFlash);
				
				Texture.fromColor(this._tileDimension,this._tileDimension, this._tileHighLiteColor);
				this._textures[Enums.TILE_COVER] = Texture.fromBitmapData(tempBData);
			}
			return this._textures[Enums.TILE_COVER];
		}
		
		
		public function getBombHighLiteTexture():Texture
		{
			if(this._textures[Enums.TILE_HIGH_LITE] == undefined)
			{
				var tempSpriteFlash:Shape = new Shape();
				tempSpriteFlash.graphics.lineStyle(2,this._tileCoverStrokeColor,1);
				tempSpriteFlash.graphics.beginFill(this._tileHighLiteColor,1);
				tempSpriteFlash.graphics.drawRect(0,0, this._tileDimension, this._tileDimension);
				tempSpriteFlash.graphics.endFill();
				
				var tempBData:BitmapData = new BitmapData(this._tileDimension,this._tileDimension,false);
				tempBData.draw(tempSpriteFlash);
				this._textures[Enums.TILE_HIGH_LITE] = Texture.fromBitmapData(tempBData);
			}
			return this._textures[Enums.TILE_HIGH_LITE];
		}
		
		
		public function getBombTexture():Texture
		{
			if(this._textures[Enums.TILE_BOMB] == undefined)
			{
				var tempSpriteFlash:Shape = new Shape();
				tempSpriteFlash.graphics.lineStyle(2,this._tileBombStrokeColor,1);
				tempSpriteFlash.graphics.beginFill(this._tileBombColor,1);
				tempSpriteFlash.graphics.drawCircle(this._tileDimension/2,this._tileDimension/2, (this._tileDimension/3));//    drawRect(0,0, this._tileDimension, this._tileDimension);
				tempSpriteFlash.graphics.endFill();
				
				var tempBData:BitmapData = new BitmapData(this._tileDimension,this._tileDimension,true,0x000000);
				tempBData.draw(tempSpriteFlash);
				this._textures[Enums.TILE_BOMB] = Texture.fromBitmapData(tempBData);
			}
			return this._textures[Enums.TILE_BOMB];
		}
		
		public function getMarkTexture():Texture
		{
			if(this._textures[Enums.TILE_MARK] == undefined)
			{
				var tempSpriteFlash:Shape = new Shape();
				tempSpriteFlash.graphics.lineStyle(2,this._tileMarkColor,1);
				tempSpriteFlash.graphics.beginFill(this._tileMarkColor,1);
				tempSpriteFlash.graphics.moveTo(18,6);
				tempSpriteFlash.graphics.lineTo(18,18);
				tempSpriteFlash.graphics.lineTo(6,12);
				tempSpriteFlash.graphics.lineTo(18,6);
				tempSpriteFlash.graphics.endFill();
				
				var tempBData:BitmapData = new BitmapData(this._tileDimension,this._tileDimension,true,0x000000);
				tempBData.draw(tempSpriteFlash);
				this._textures[Enums.TILE_MARK] = Texture.fromBitmapData(tempBData);
			}
			return this._textures[Enums.TILE_MARK];
		}
	}
}

class SingletonEnforcer
{
	public function SingletonEnforcer()
	{
	}
}