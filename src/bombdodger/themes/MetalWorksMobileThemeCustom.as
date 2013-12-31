package bombdodger.themes
{
	import feathers.controls.Radio;
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.themes.MetalWorksMobileTheme;
	import feathers.controls.text.TextFieldTextRenderer;
	
	import flash.text.TextFormat;
	
	import starling.display.DisplayObjectContainer;
	import feathers.skins.SmartDisplayObjectStateValueSelector;
	
	public class MetalWorksMobileThemeCustom extends MetalWorksMobileTheme
	{
	
		public function MetalWorksMobileThemeCustom(container:DisplayObjectContainer=null, scaleToDPI:Boolean=true)
		{
			super(container, scaleToDPI);
		}
		
		override protected function itemRendererAccessoryLabelInitializer(renderer:TextFieldTextRenderer):void
		{
			const regularFontNames:String = "SourceSansPro";
			renderer.textFormat = new TextFormat(regularFontNames, 60 * this.scale, LIGHT_TEXT_COLOR);;//this.lightTextFormat;
			renderer.embedFonts = true;
		}
		
		override protected function alertMessageInitializer(renderer:TextFieldTextRenderer):void
		{
			const regularFontNames:String = "SourceSansPro";
			
			renderer.wordWrap = true;
			renderer.textFormat = new TextFormat(regularFontNames, 60 * this.scale, LIGHT_TEXT_COLOR);
			renderer.textFormat.align = "center"
			renderer.embedFonts = true;
		}
		
		
		override protected function baseButtonInitializer(button:Button):void
		{
			button.defaultLabelProperties.textFormat = new TextFormat("SourceSansProSemibold", 60 * this.scale, DARK_TEXT_COLOR, true);
			button.defaultLabelProperties.embedFonts = true;
			button.disabledLabelProperties.textFormat = this.darkUIDisabledTextFormat;
			button.disabledLabelProperties.embedFonts = true;
			button.selectedDisabledLabelProperties.textFormat = this.darkUIDisabledTextFormat;
			button.selectedDisabledLabelProperties.embedFonts = true;
			
			button.paddingTop = button.paddingBottom = 8 * this.scale;
			button.paddingLeft = button.paddingRight = 16 * this.scale;
			button.gap = 12 * this.scale;
			button.minWidth = button.minHeight = 60 * this.scale;
			button.minTouchWidth = button.minTouchHeight = 88 * this.scale;
		}


		override protected function buttonGroupButtonInitializer(button:Button):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonUpSkinTextures;
			skinSelector.defaultSelectedValue = this.buttonSelectedUpSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.setValueForState(this.buttonSelectedDisabledSkinTextures, Button.STATE_DISABLED, true);
			skinSelector.displayObjectProperties =
				{
					width: 76 * this.scale,
						height: 76 * this.scale,
						textureScale: this.scale
				};
			button.stateToSkinFunction = skinSelector.updateValue;
			
			button.defaultLabelProperties.textFormat = new TextFormat("SourceSansProSemibold", 60 * this.scale, DARK_TEXT_COLOR, true);
			button.defaultLabelProperties.embedFonts = true;
			button.disabledLabelProperties.textFormat = this.largeUIDisabledTextFormat;
			button.disabledLabelProperties.embedFonts = true;
			button.selectedDisabledLabelProperties.textFormat = this.largeUIDisabledTextFormat;
			button.selectedDisabledLabelProperties.embedFonts = true;
			
			button.paddingTop = button.paddingBottom = 8 * this.scale;
			button.paddingLeft = button.paddingRight = 16 * this.scale;
			button.gap = 12 * this.scale;
			button.minWidth = button.minHeight = 76 * this.scale;
			button.minTouchWidth = button.minTouchHeight = 88 * this.scale;
		}
		
		
		override protected function radioInitializer(radio:Radio):void
		{
			const iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			iconSelector.defaultValue = this.radioUpIconTexture;
			iconSelector.defaultSelectedValue = this.radioSelectedUpIconTexture;
			iconSelector.setValueForState(this.radioDownIconTexture, Button.STATE_DOWN, false);
			iconSelector.setValueForState(this.radioDisabledIconTexture, Button.STATE_DISABLED, false);
			iconSelector.setValueForState(this.radioSelectedDownIconTexture, Button.STATE_DOWN, true);
			iconSelector.setValueForState(this.radioSelectedDisabledIconTexture, Button.STATE_DISABLED, true);
			iconSelector.displayObjectProperties =
				{
					scaleX: this.scale * 3,
						scaleY: this.scale * 3
				};
			radio.stateToIconFunction = iconSelector.updateValue;
			
			const semiboldFontNames:String = "SourceSansProSemibold";
			
			radio.defaultLabelProperties.textFormat = new TextFormat(semiboldFontNames, 60 * this.scale, LIGHT_TEXT_COLOR, true);
			radio.defaultLabelProperties.embedFonts = true;
			radio.disabledLabelProperties.textFormat = this.lightUIDisabledTextFormat;
			radio.disabledLabelProperties.embedFonts = true;
			radio.selectedDisabledLabelProperties.textFormat = this.lightUIDisabledTextFormat;
			radio.selectedDisabledLabelProperties.embedFonts = true;
			
			radio.gap = 8 * this.scale;
			radio.minTouchWidth = radio.minTouchHeight = 88 * this.scale;
		}
		
	}
}