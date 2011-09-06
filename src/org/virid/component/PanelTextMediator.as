package org.virid.component
{
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	import org.syncon.Customizer.controller.EditProductCommandTriggerEvent;
	import org.syncon.Customizer.model.CustomEvent;
	import org.syncon.Customizer.model.NightStandModel;
	import org.syncon.Customizer.view.ui.LayerInspector;
	import org.syncon.Customizer.vo.LayerBaseVO;
	import org.syncon.Customizer.vo.TextLayerVO;
	import org.syncon.onenote.onenotehelpers.impl.layer_item_renderer;
	import org.syncon.Customizer.vo.FontVO;
	
	public class PanelTextMediator extends Mediator 
	{
		[Inject] public var ui : PanelText;
		[Inject] public var model : NightStandModel;
		
		override public function onRegister():void
		{
			/*
			this.ui.addEventListener( design_panel.CHANGE_FONT_SIZE, 
				this.onChangeFontSize);	*/
			this.ui.addEventListener( PanelText.CHANGE_COLOR, 
				this.onChangeColor);				
			this.ui.addEventListener( PanelText.CHANGE_FONT_FAMILY, 
				this.onChangeFontFamily);	
			this.ui.addEventListener( PanelText.CHANGE_TEXT_ALIGN, 
				this.onChangeTextAlign);	
			this.ui.addEventListener( PanelText.CHANGED_TEXT, 
				this.onChangeText );	
			this.ui.addEventListener( PanelText.DATA_CHANGED, 
				this.onDataChanged );	
			onDataChanged(null)
		}
		
		protected function onDataChanged(event:Event):void
		{
			this.ui.txt.prompt = this.layer.default_text; 
			this.onChangeText(null); 
		}
		
		public function get layer () : TextLayerVO 
		{
			return this.ui.layer; 
		}
		protected function onChangeText(event:Event):void
		{
		/*	if ( this.layer.text == '' && this.layer.default_text!= ''  ) 
			{*/
				
	/*		}*/

			
			var e : EditProductCommandTriggerEvent = new EditProductCommandTriggerEvent(
				EditProductCommandTriggerEvent.CHANGE_TEXT, this.ui.txt.text, 
				this.layer ) 
			e.fxPost = this.updateLayer;
			this.dispatch( e )
				; 
		}
		
		
		public function updateLayer() : void
		{
			//update price
			//adjust font size if necessary 
			//transform display text if necessary 
			this.layer.setFontSize(); 
			this.layer.adjustDisplayText()
			this.model.calculateProductPrice();
			
			this.layer.update(); 
		}
		
		
		/**
		 * if check box selected, go to the left
		 * */
		protected function onChangeTextAlign(event:CustomEvent):void
		{
			if ( event.data ==  false ) 
			{
			this.dispatch( new EditProductCommandTriggerEvent ( 
				EditProductCommandTriggerEvent.CHANGE_TEXT_ALIGN, 'left' 
			) )  
			}
			else
			{
			this.dispatch( new EditProductCommandTriggerEvent ( 
				EditProductCommandTriggerEvent.CHANGE_TEXT_ALIGN, 'right' 
			) )  
			}
		}
		
		protected function onChangeFontSize(event:CustomEvent):void
		{
			this.dispatch( new EditProductCommandTriggerEvent ( 
				EditProductCommandTriggerEvent.CHANGE_FONT_SIZE, event.data 
			) )  
			/*		this.ui.layer.fontSize = int(  event.data ); 
			this.ui.layer.update('fontSize'); */
		}
		
		protected function onChangeColor(event:CustomEvent):void
		{
			this.dispatch( new EditProductCommandTriggerEvent ( 
				EditProductCommandTriggerEvent.CHANGE_COLOR, event.data 
			) )  
		}
		
		protected function onChangeFontFamily(event:CustomEvent):void
		{
			
			var font : FontVO= event.data as FontVO
			var fontName : String = font.name; 
			if ( font.swf_name != null && font.swf_name != '' ) 
				fontName = font.swf_name; 
			/*
			this.dispatch( new EditProductCommandTriggerEvent ( 
			EditProductCommandTriggerEvent.CHANGE_FONT_FAMILY, fontName 
			) )  
			*/
			this.ui.txt.setStyle('fontFamily', fontName ) ; 
			
			this.dispatch( new EditProductCommandTriggerEvent ( 
				EditProductCommandTriggerEvent.CHANGE_FONT_FAMILY,fontName
			) )  
		}
		
		
		
		
		
	}
}