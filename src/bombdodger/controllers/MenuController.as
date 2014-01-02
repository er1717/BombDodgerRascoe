package bombdodger.controllers
{
	import bombdodger.controllers.GameController;
	import bombdodger.events.GameEvent;
	import bombdodger.events.MenuEvent;
	
	import feathers.controls.Button;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	public class MenuController extends EventDispatcher
	{
		public function MenuController()
		{
			this.init();
		}
		
		private function init():void
		{
			this.addEventListeners();
		}
		
		private function addEventListeners():void
		{
			this.addEventListener(MenuEvent.MENU_DATA_SETUP_COMPLETE, this.onMenuDataSetupComplete);
			GameController.gameController.addEventListener(GameEvent.GAME_MENU_DATA_START, this.onMenuDataStart);
			this.addEventListener(MenuEvent.MENU_RESTART, this.onMenuRestart);
			this.addEventListener(MenuEvent.MENU_CLICK_MODE_CHANGE, this.onClickModeChange);
			this.addEventListener(MenuEvent.MENU_OUT_OF_TIME, this.onMenuOutOfTime);
		}
		
		private function onMenuOutOfTime(inEvent:MenuEvent):void
		{
			GameController.gameController.dispatchEvent(new MenuEvent(MenuEvent.MENU_OUT_OF_TIME, inEvent.command));
		}
		
		private function onClickModeChange(inEvent:MenuEvent):void
		{
			GameController.gameController.dispatchEvent(new MenuEvent(MenuEvent.MENU_CLICK_MODE_CHANGE, inEvent.command));
		}
		
		private function onMenuRestart(inEvent:MenuEvent):void
		{
			GameController.gameController.dispatchEvent(new MenuEvent(MenuEvent.MENU_RESTART, inEvent.command));
		}		
		
		private function onMenuDataStart(inEvent:GameEvent):void
		{
			this.dispatchEvent(new MenuEvent(MenuEvent.MENU_DATA_SETUP_INIT,inEvent.command));
		}
		
		private function onMenuDataSetupComplete(inEvent:MenuEvent):void
		{
			GameController.gameController.dispatchEvent(new GameEvent(GameEvent.GAME_MENU_DATA_COMPLETE, inEvent.command));
		}
		
		public function onLevelSelectionClick(inEvent:Event):void
		{
			var tempLevel:String = feathers.controls.Button(inEvent.target).label;
			GameController.gameController.dispatchEvent(new MenuEvent(MenuEvent.MENU_GAME_LEVEL_SELECTION, tempLevel));
			
		}
	}
}