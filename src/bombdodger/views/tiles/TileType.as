package bombdodger.views.tiles
{
	import bombdodger.interfaces.IBoardSpace;
	
	import starling.display.Sprite;
	
	public class TileType extends Sprite implements IBoardSpace
	{
		protected var _boardSpace:IBoardSpace;
		
		public function TileType(inBoardSpace:IBoardSpace)
		{
			this._boardSpace = inBoardSpace;
		}
		
		public function onClick():void
		{
		}

	}
}