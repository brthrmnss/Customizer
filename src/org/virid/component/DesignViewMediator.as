package  org.virid.component
{
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	import org.syncon.Customizer.model.CustomEvent;
	import org.syncon.Customizer.model.NightStandModel;
	import org.syncon.Customizer.model.NightStandModelEvent;
	
	public class DesignViewMediator extends Mediator 
	{
		[Inject] public var ui : DesignView;
		[Inject] public var model : NightStandModel;
		
		override public function onRegister():void
		{
			/*eventMap.mapListener(eventDispatcher, NightStandModelEvent.BASE_ITEM_CHANGED, 
				this.onBaseItemChanged);	
			this.onBaseItemChanged( null ) 
			*/
			eventMap.mapListener(eventDispatcher, NightStandModelEvent.FACE_CHANGED, 
				this.onFaceChanged);	
			this.onFaceChanged( null ) 
			eventMap.mapListener(eventDispatcher, NightStandModelEvent.LAYERS_CHANGED, 
				this.onLayersChanged);				
			
			this.model.viewer = this.ui.viewer22
			this.ui.viewer22.groupBg.visible = false; 
			this.ui.viewer22.bgBorder.alpha = 0; // = false; 
			this.ui.viewer22.scroller.addEventListener(MouseEvent.CLICK, this.onClickBg ) ; 
		}
		
		protected function onClickBg(event:MouseEvent):void
		{
			if ( event.target != this.ui.viewer22.workspace ) 
				return; 
			if ( this.model.allowSelectingBgToClearSelection == false ) 
				return; 
			this.model.objectHandles.selectionManager.clearSelection()
				//desleect from list ...
				this.model.currentLayer = null; 
		}
		
		private function onLayersChanged(e:Object):void
		{
			// TODO Auto Generated method stub
			//this.onBaseItemChanged(null); 
			this.ui.viewer22.controller.displayDp(); 
		}
		/*
		private function onBaseItemChanged(param0:Object):void
		{
			this.ui.viewer22.controller.dataProvider  = this.model.baseItem; 
			//this.ui.list.dataProvider = this.model.layers; 
		}
 		*/
		private function onFaceChanged(param0:Object):void
		{
			this.ui.viewer22.controller.dataProvider  = this.model.currentFace; 
			//this.ui.list.dataProvider = this.model.layers; 
			this.ui.viewer22.maskBg.alpha = this.model.currentFace.image_mask_alpha; 
		}
		
		
	}
}