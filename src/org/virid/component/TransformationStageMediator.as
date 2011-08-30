package  org.virid.component
{
	import org.robotlegs.mvcs.Mediator;
	import org.syncon.Customizer.controller.EditProductCommandTriggerEvent;
	import org.syncon.Customizer.model.NightStandModel;
	import org.syncon.Customizer.model.NightStandModelEvent;
	import org.syncon.Customizer.vo.FaceVO;
	
	public class TransformationStageMediator extends Mediator 
	{
		[Inject] public var ui : transformation_stage;
		[Inject] public var model : NightStandModel;
		
		override public function onRegister():void
		{
			//possible combine design view mediator stuff here?
			this.ui.addEventListener( transformation_stage.SWITCH_FACE, this.onSwitchFaces ) ; 
			//listen for product change to determine faces ... 
			eventMap.mapListener(eventDispatcher, NightStandModelEvent.BASE_ITEM_CHANGED,
				this.onBaseItemChanged);	
			this.onBaseItemChanged( null ) 
		}
		
		/**
		 * Hide switch button if only 1 face exists ...
		 * */
		/**
		 * Change product display name to match baseStoreItem ...
		 * */
		private function onBaseItemChanged(param0:Object):void
		{
			this.ui.btnSwitchSide.visible = true; 
			this.ui.txtProductName.text = this.model.baseItem.name;
			if ( this.model.baseItem.faces.length == 1 ) 
			{
				this.ui.btnSwitchSide.visible = false; 
				return; 
			}
			
			
			

		}		
		
		
		private function onSwitchFaces(e:Object):void
		{
			var currentFace : FaceVO = this.model.currentFace
			var index : int = this.model.baseItem.faces.getItemIndex( currentFace ) ; 
			
			if ( this.model.baseItem.faces.length == 1 ) 
			{
				//there are no other faces ...
				return; 
			}
			this.model.currentFace
			var nextIndex : int = index; 
			if ( index >= this.model.baseItem.faces.length - 1 )
			{
				nextIndex =-1 
			}
			nextIndex++
			
			var face : FaceVO = this.model.baseItem.faces.getItemAt( nextIndex ) as FaceVO; 

			this.dispatch( new EditProductCommandTriggerEvent(
				EditProductCommandTriggerEvent.LOAD_FACE, face, null ) ) 
		}
		
	}
}