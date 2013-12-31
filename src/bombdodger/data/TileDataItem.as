package bombdodger.data
{
	public class TileDataItem
	{
		private var _rowIndex:int;
		private var _tileIndex:int;
		private var _columnIndex:int;
		private var _isBomb:Boolean;
		private var _setXPos:int;
		private var _setYPos:int;
		private var _revealed:Boolean = false;
		private var _neighborBombs:int;
		private var _isMarked:Boolean;
		
		public function TileDataItem(isBomb:Boolean, inColIndex:int, inRowIndex:int, inTileIndex:int, inXPos:int, inYPos:int)
		{
			this._isBomb = isBomb;
			this._tileIndex = inTileIndex;
			this._columnIndex = inColIndex;
			this._rowIndex = inRowIndex;
			this._setXPos = inXPos;
			this._setYPos = inYPos;
		}
		
		
		public function get rowIndex():int
		{
			return this._rowIndex;
		}
		
		public function get tileIndex():int
		{
			return this._tileIndex;
		}
		
		public function get columnIndex():int
		{
			return this._columnIndex;
		}
		
		public function get isBomb():Boolean
		{
			return this._isBomb;
		}
		
		public function get revealed():Boolean
		{
			return this._revealed;
		}
		
		public function get setXPos():int
		{
			return this._setXPos;
		}
		
		public function get setYPos():int
		{
			return this._setYPos;
		}
		
		public function get neighborBombs():int
		{
			return this._neighborBombs;
		}
		
		public function get isMarked():Boolean
		{
			return this._isMarked;
		}
		
		public function set neighborBombs(inInt:int):void
		{
			this._neighborBombs = inInt
		}
		
		public function set revealed(inBoolean:Boolean):void
		{
			this._revealed = inBoolean;	
		}
		
		public function set isMarked(inBoolean:Boolean):void
		{
			this._isMarked = inBoolean;
		}
		

	}
}