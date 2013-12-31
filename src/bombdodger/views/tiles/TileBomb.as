package bombdodger.views.tiles
{
	import starling.display.Image;
	import bombdodger.models.TileModel;
	import bombdodger.controllers.TileController;
	import bombdodger.models.GameModel;

	public class TileBomb extends Tile
	{
		private var _tileBomb:Image;
		
		
		public function TileBomb(inModel:TileModel, inController:TileController)
		{
			super(inModel, inController);
		}
		
		protected override function drawLayers():void
		{
			this.makeBackground();
			this.makeHighLite();
			this.makeTextField();
			this.makeBomb();
			this.makeCover();
			this.makeMark();
			this.addEventListeners();
		}
		
		private function makeBomb():void
		{
			this._tileBomb = this._tileModel.tileBomb;
			this.addChild(this._tileBomb);
		}
	}
}