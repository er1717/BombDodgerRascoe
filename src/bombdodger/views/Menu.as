package bombdodger.views
{
	import bombdodger.controllers.MenuController;
	import bombdodger.enumerations.Enums;
	import bombdodger.events.MenuEvent;
	import bombdodger.models.MenuModel;
	import bombdodger.themes.MetalWorksMobileThemeCustom;
	
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.Header;
	import feathers.controls.Radio;
	import feathers.core.ToggleGroup;
	import feathers.data.ListCollection;
	
	import flash.text.TextFormat;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class Menu extends Sprite
	{
		private var _menuModel:MenuModel;
		private var _menuController:MenuController;
		private var _backGround:Image;
		private var _currentState:String;
		private var _menuHeader:Header;
		private var _levelButtons:ButtonGroup;
		private var _headerTextField:TextField;
		private var _restartButton:Button;
		private var _instructionsField:TextField;
		private var _remainingTiles:TextField;
		private var _clickModeGroup:ToggleGroup;
		private var _radioReg:Radio;
		private var _radioMark:Radio

		
		public function Menu(inModel:MenuModel, inController:MenuController)
		{
			this._menuModel = inModel;
			this._menuController = inController;
			this.addEventListeners();
		}
		
		private function init():void
		{
			new MetalWorksMobileThemeCustom(this.stage);
			this.makeBackground();
			this.makeLevelsButton();
			this.addHeaderTextfield();
			this.addIndicatorButton();
			this.addRemTilesLabelAndField();
			this.addClickModeGroup();
			this.updateState(this._currentState);
		}
		
		private function addClickModeGroup():void
		{
			this._clickModeGroup = new ToggleGroup();
			
			this._radioReg = new Radio();
			this._radioReg.label = Enums.MENU_RADIO_HIT; 
			this._radioReg.toggleGroup = this._clickModeGroup;
			this._radioReg.x = 400;
			this._radioReg.y 150;
			this._radioReg.height = 130;
			this.addChild( this._radioReg );
			
			this._radioMark = new Radio();
			this._radioMark.label = Enums.MENU_RADIO_MARK;
			this._radioMark.toggleGroup = this._clickModeGroup;
			this._radioMark.x = 600;
			this._radioMark.y 150;
			this._radioMark.height = 130;
			this.addChild(this._radioMark);
			
			this._clickModeGroup.addEventListener( Event.CHANGE, this.groupChangeHandler );
		}
		
		private function groupChangeHandler(inEvent:Event):void
		{
			var group:ToggleGroup = ToggleGroup( inEvent.currentTarget );
			this._menuController.dispatchEvent(new MenuEvent(MenuEvent.MENU_CLICK_MODE_CHANGE, group.selectedIndex));
		}
		
		private function addIndicatorButton():void
		{	
			this._restartButton = new Button();
			this._restartButton.label = this._menuModel.menuReturnButtonText;
			this._restartButton.nameList.add( Button.ALTERNATE_NAME_BACK_BUTTON );
			this._restartButton.addEventListener( Event.TRIGGERED, this.onBackClick);
			this._restartButton.width = 100;
			this._restartButton.height = 30;
			this._restartButton.x = 12;
			this._restartButton.y = 30;
			this.addChild(this._restartButton);
		}
		
		
		private function addRemTilesLabelAndField():void
		{
			this._instructionsField = new TextField(400, 30, "label")
			this._instructionsField.text = this._menuModel.menuPlayInstructions;
			this._instructionsField.x = 350;
			this._instructionsField.y = 10;
			this._instructionsField.fontSize = 24;
			this._instructionsField.autoScale = true;
			this._instructionsField.color = 0x444444;
			this.addChild(this._instructionsField);
			
			
			this._remainingTiles =  new TextField(120, 80, "")
			this._remainingTiles.text = "000";
			this._remainingTiles.x = 150;
			this._remainingTiles.y = 20;
			this._remainingTiles.fontSize = 48;
			this._remainingTiles.bold = true;
			this._remainingTiles.autoScale = true;
			this._remainingTiles.color = 0xFF8000;
			this.addChild(this._remainingTiles);
		}
		
		
		private function addHeaderTextfield():void
		{
			this._headerTextField = new TextField(this._backGround.width, this._backGround.height/2,"");
			this._headerTextField.text = this._menuModel.begineHeaderText;
			this._headerTextField.fontSize = 32;
			this._headerTextField.color = 0x444444;
			this._headerTextField.bold = true;
			this.addChild(this._headerTextField);
		}
		
		
		private function makeLevelsButton():void
		{
			this._levelButtons = new ButtonGroup();
			this._levelButtons.dataProvider = this._menuModel.levelsButtonData;
			this._levelButtons.width = this._backGround.width/1.075;
			this._levelButtons.height = this._backGround.height/3;
			this._levelButtons.gap = 50;
			this._levelButtons.direction = ButtonGroup.DIRECTION_HORIZONTAL;
			this._levelButtons.horizontalAlign = ButtonGroup.HORIZONTAL_ALIGN_JUSTIFY;
			this._levelButtons.x = this._backGround.width/2 - this._levelButtons.width/2
			this._levelButtons.y = 60;
			this.addChild( this._levelButtons );
		}

		
		private function makeBackground():void
		{
			this._backGround = this._menuModel.menuBackGround;
			this.addChild(this._backGround);
		}
		
		
		private function onBackClick(inEvent:Event):void
		{
			this._menuController.dispatchEvent(new MenuEvent(MenuEvent.MENU_RESTART, this._currentState));
		}
		
		private function addEventListeners():void
		{
			this._menuModel.addEventListener(MenuEvent.MENU_BUILD_VIEW, this.onMenuBuildView);
			this._menuModel.addEventListener(MenuEvent.MENU_UPDATE_DATA, this.onUpdateData);
			this._menuModel.addEventListener(MenuEvent.MENU_CHANGE_STATE, this.onChangeState);
		}

		
		private function onChangeState(inEvent:MenuEvent):void
		{
			this.updateState(inEvent.command);
		}
		
		private function onUpdateData(inEvent:MenuEvent):void
		{
			this._remainingTiles.text = inEvent.command;
		}
		
		private function onMenuBuildView(inEvent:MenuEvent):void
		{
			this._currentState = inEvent.command;
			this.init();
		}
		
		private function displayBeginView():void
		{
			this._restartButton.visible = false;
			this._instructionsField.visible = false;
			this._remainingTiles.visible = false;
			this._radioReg.visible = false;
			this._radioMark.visible = false;
				
			this._levelButtons.visible = true;
			this._headerTextField.visible = true;
		}
		
		
		private function displayPlayView():void
		{
			this._levelButtons.visible = false;
			this._headerTextField.visible = false;
			
			this._restartButton.visible = true;
			this._instructionsField.visible = true;
			this._remainingTiles.visible = true;
			this._radioReg.visible = true;
			this._radioMark.visible = true;
		}
		
		private function updateState(inState:String):void
		{
			this._currentState = inState;
			this._currentState == Enums.MENU_BEGIN_VIEW ? this.displayBeginView():this.displayPlayView();
			var val:int = 0;
			this._clickModeGroup.selectedIndex = 0;
		}
	}
}