package  org.virid.component
{
	import flash.events.Event;
	
	import flashx.undo.IOperation;
	
	import mx.collections.ArrayList;
	
	import org.robotlegs.mvcs.Mediator;
	import org.syncon.Customizer.controller.EditProductCommandTriggerEvent;
	import org.syncon.Customizer.model.CustomEvent;
	import org.syncon.Customizer.model.NightStandModel;
	import org.syncon.Customizer.model.NightStandModelEvent;
	import org.syncon.Customizer.view.ui.Toolbar;
	import org.syncon.Customizer.vo.ImageVO;
	import org.syncon.popups.controller.ShowPopupEvent;
	
	public class  DesignPanelMediator extends Mediator 
	{
		[Inject] public var ui : design_panel;
		[Inject] public var model : NightStandModel;
		
		override public function onRegister():void
		{
			this.ui.addEventListener( design_panel.ADD_IMAGE,  this.onAddImage);	
			this.ui.addEventListener( design_panel.ADD_UPLOAD_IMAGE,  this.onAddUploadImage);	
			
			this.ui.addEventListener( design_panel.CHANGE_COLOR,  this.onChangeColor);			
			
			//set default color if defined ... do not make na undo fo rthis ....
			this.model.blockUndoAdding = true; 
			this.onChangeColor(null, this.ui.getSelectedColor ) ;
			this.model.blockUndoAdding = false; 
		}
		
		//use Object b/c uint does not like null...
		protected function onChangeColor(event:CustomEvent, color_ :  Object = null ):void
		{
			if ( color_ ==null ) 
			var color : uint = uint(event.data ) 
			else
				color = uint(color_ ) 
			this.dispatch( new EditProductCommandTriggerEvent (
				EditProductCommandTriggerEvent.CHANGE_LAYER_COLOR,color, 'Mask') ) ; 
		}
		
		protected function onAddUploadImage(e:CustomEvent):void
		{
			/*	var obj : Object = e.data
			var event_ : ShowPopupEvent = new ShowPopupEvent(ShowPopupEvent.SHOW_POPUP, 
			'PopupPickImage', [this.onPickedImage], 'done' ) 		
			this.dispatch( event_ ) */
			var event_ : ShowPopupEvent = new ShowPopupEvent(ShowPopupEvent.SHOW_POPUP,
				'PopupUploadImage', [null], 'done' ) 		
			this.dispatch( event_ ) 
		}
		
		private function onAddText(e:  CustomEvent): void
		{
			var obj : Object = e.data
			this.dispatch( new EditProductCommandTriggerEvent (
				EditProductCommandTriggerEvent.ADD_TEXT_LAYER, e) ) ; 
		}		
		
		private function onAddImage(e:  CustomEvent): void
		{
			var obj : Object = e.data
			var event_ : ShowPopupEvent = new ShowPopupEvent(ShowPopupEvent.SHOW_POPUP, 
				'PopupPickImage', [this.onPickedImage], 'done' ) 		
			this.dispatch( event_ ) 
		}		
		
		private function onPickedImage( e : ImageVO ) : void
		{
			//if a prompt layer, change the source, do not add a new one 
			if ( this.model.currentLayer.prompt_layer && this.ui.layer == this.model.currentLayer ) 
			{
				this.dispatch( new EditProductCommandTriggerEvent (
					EditProductCommandTriggerEvent.CHANGE_IMAGE_URL, e.url) ) ; 
				return; 
			}
			this.dispatch( new EditProductCommandTriggerEvent (
				EditProductCommandTriggerEvent.ADD_IMAGE_LAYER, e.url) ) ; 
		}
		
	}
}