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
	
	public class  TextPanelMediator extends Mediator 
	{
		[Inject] public var ui : text_panel;
		[Inject] public var model : NightStandModel;
		
		override public function onRegister():void
		{
			this.ui.addEventListener( text_panel.ADD_TEXT,  this.onAddText);	
			this.ui.addEventListener( text_panel.CHANGED_TEXT, this.onTextChanged);
		}
		
		protected function onTextChanged(event:Event):void
		{
			this.model.calculateProductPrice();
			
		}
		
		private function onAddText(e:  CustomEvent): void
		{
			var obj : Object = e.data
			/*this.dispatch( new EditProductCommandTriggerEvent (
				EditProductCommandTriggerEvent.ADD_TEXT_LAYER, e.data[0], e.data[1] ) ) ; */
			this.dispatch( new EditProductCommandTriggerEvent (
				EditProductCommandTriggerEvent.ADD_TEXT_LAYER, e.data  ) ) ; 
		}		
	 
		
	}
}