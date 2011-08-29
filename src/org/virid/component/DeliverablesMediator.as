package  org.virid.component
{
	import org.robotlegs.mvcs.Mediator;
	import org.syncon.Customizer.model.CustomEvent;
	import org.syncon.Customizer.model.NightStandModel;
	import org.syncon.Customizer.model.NightStandModelEvent;
	import org.syncon.Customizer.view.apps.Deliverable;
	import org.syncon.Customizer.view.ui.LayerInspector;
	import org.syncon.Customizer.vo.ProductVO;
	
	public class DeliverablesMediator extends Mediator 
	{
		[Inject] public var ui : Deliverable;
		[Inject] public var model : NightStandModel;
		
		override public function onRegister():void
		{
			/*this.ui.addEventListener( PriceList.UPDATE_JSON, 
				this.onUpdateJSON);	*/
			eventMap.mapListener(eventDispatcher, NightStandModelEvent.CURRENT_LAYER_CHANGED, 
				this.onLayersChanged);	
			this.onLayersChanged( null ) 
		}
		
		private function onLayersChanged(param0:Object):void
		{
			if ( this.model.currentLayer == null ) 
			{
				this.ui.currentState = 'normal' 
				//this.ui.designPanel.hideImageOptions();//overkill
			}
			this.ui.layer = this.model.currentLayer; 
		}
		
		private function onUpdateJSON(e:  CustomEvent): void
		{
			 
			//var product :  ProductVO = e.data as ProductVO()
			//	product.name = 'foo'; 
		}		
		
		
		
	}
}