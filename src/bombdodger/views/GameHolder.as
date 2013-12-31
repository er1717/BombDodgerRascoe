package bombdodger.views
{
	import bombdodger.controllers.GameController;
	import bombdodger.models.GameModel;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameHolder extends Sprite
	{
		private var _game:Game;
		private var _gameModel:GameModel;
		private var _gameController:GameController;
		
		
		public function GameHolder()
		{
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
		}
		
		
		/**
		 * creates and arranges all necessary pieces to create this view 
		 */		
		private function init():void
		{			
			this._game = new Game(GameModel.gameModel, GameController.gameController);
			this.addChild(this._game);
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