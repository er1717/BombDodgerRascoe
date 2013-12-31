package
{
	import starling.core.Starling;
	import starling.events.Event;
	
	import bombdodger.views.GameHolder;
	
	import flash.display.Sprite;
	

	
	[SWF(frameRate="60", width="800", height="600", backgroundColor="0x666666")]
	public class BombDodgerRascoe extends flash.display.Sprite
	{
		private var _bombDodgerGame:Starling;
		
		public function BombDodgerRascoe()
		{
			this.init();
		}
		
		
		/**
		 * Init method creates the starling object and starts it
		 */		
		private function init():void
		{
			this._bombDodgerGame = new Starling(GameHolder,this.stage);
			this._bombDodgerGame.antiAliasing = 1;
			this._bombDodgerGame.start();
		}
		
		/**
		 *When the application has been added to the stage the listener is removed and application can be built 
		 */		
		private function onAddedToStage(inEvent:Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
			this.init();
		}
	}
}