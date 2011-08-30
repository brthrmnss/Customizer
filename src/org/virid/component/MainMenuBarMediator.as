package  org.virid.component
{
	import flash.events.Event;
	
	import flashx.undo.IOperation;
	
	import mx.collections.ArrayList;
	
	import org.robotlegs.mvcs.Mediator;
	import org.syncon.Customizer.controller.EditProductCommandTriggerEvent;
	import org.syncon.Customizer.controller.ExportJSONCommandTriggerEvent;
	import org.syncon.Customizer.model.CustomEvent;
	import org.syncon.Customizer.model.NightStandModel;
	import org.syncon.Customizer.model.NightStandModelEvent;
	import org.syncon.Customizer.view.ui.Toolbar;
	import org.syncon.Customizer.vo.ColorLayerVO;
	import org.syncon.Customizer.vo.ImageLayerVO;
	import org.syncon.Customizer.vo.ImageVO;
	import org.syncon.Customizer.vo.LayerBaseVO;
	import org.syncon.Customizer.vo.TextLayerVO;
	import org.syncon.popups.controller.ShowPopupEvent;
	
	public class  MainMenuBarMediator extends Mediator 
	{
		[Inject] public var ui : MainMenuBar;
		[Inject] public var model : NightStandModel;
		
		override public function onRegister():void
		{
			this.ui.addEventListener( MainMenuBar.ADD_TEXT,  this.onAddText);	
			this.ui.addEventListener( MainMenuBar.ADD_IMAGE,  this.onAddImage);	
			this.ui.addEventListener( MainMenuBar.UNDO,  this.onUndo);	
			this.ui.addEventListener( MainMenuBar.REDO,  this.onRedo);	
			this.ui.addEventListener( MainMenuBar.EXPORTJSON, this.onJSONEXPORT);
			this.ui.addEventListener( MainMenuBar.GO_TO_BACKGROUND_PANEL, this.onGoToBackgroundPanel );
			this.ui.addEventListener( MainMenuBar.GO_TO_ENGRAVE_PANEL, this.onGoToEngravePanel );
			
			
			eventMap.mapListener(eventDispatcher, NightStandModelEvent.UNDOS_CHANGED, 
				this.checkUndoButtons);	
			this.checkUndoButtons(); 
			
			eventMap.mapListener(eventDispatcher, NightStandModelEvent.FACE_CHANGED, 
				this.onFaceChanged);	
			this.onFaceChanged(); 
			eventMap.mapListener(eventDispatcher, NightStandModelEvent.LAYERS_CHANGED, 
				this.onLayersChanged);	
			this.onLayersChanged(); 			
		}
		/**
		 * if specific layer added ... do the thing ...
		 * */
		private function onLayersChanged(e:Event=null):void
		{
			this.rebuildMainMenuBar()

		}
		
		protected function onGoToBackgroundPanel(event:Event):void
		{
			var colorLayer : LayerBaseVO = this.model.getLayerByName( 'Color Layer'); 
			var layers : Array =  this.model.getLayersByType( ColorLayerVO  ) 
			if ( layers.length >  0 ) 
				colorLayer  = layers[0] as LayerBaseVO
			this.model.currentLayer = colorLayer 
			//this.ui.parentDocument.currentState = "normal" ;
		}
		protected function onGoToEngravePanel(event:Event):void
		{
			var engraveLayer : LayerBaseVO = this.model.getLayerByName( 'Color Layer'); 
			engraveLayer = this.model.getNextLayer(0, true, this.model.fxIsEngraveLayer ) ; 
			this.model.currentLayer = engraveLayer 
			//this.ui.parentDocument.currentState = "normal" ;
		}
		
		
		/**
		 * regieerate menu bar
		 * */
		private function onFaceChanged(e:Object=null):void
		{
	 
			this.rebuildMainMenuBar()
		}
		
		private function rebuildMainMenuBar():void
		{
			// TODO Auto Generated method stub
			this.ui.btnText.includeInLayout = false; 
			this.ui.btnBackground.includeInLayout = false; 
			this.ui.btnEngrave.includeInLayout = false;
			this.ui.btnText.visible = false; 
		
			this.ui.btnBackground.visible = false; 
			this.ui.btnEngrave.visible = false; 			
			//return
			var layers : Array = this.model.layersVisible.toArray()
			for ( var i : int =0 ; i < layers.length; i++ )
			{
				var layer : LayerBaseVO = layers[ i] as LayerBaseVO; 
				if ( this.model.fxIsEngraveLayer( layer ) ) 
				{
					this.ui.btnEngrave.includeInLayout = true; 
					this.ui.btnEngrave.visible = true; 
					continue; 
				}
				if ( layer.type == TextLayerVO.Type ) 
				{
					this.ui.btnText.includeInLayout = true; 
					this.ui.btnText.visible = true; 	
					continue; 
				}
				if ( layer.type == ImageLayerVO.Type  ) //&& subtype != null 
				{
					this.ui.btnBackground.includeInLayout = true; 
					this.ui.btnBackground.visible = true; 
					continue; 
				}
				if ( layer.type == ColorLayerVO.Type ) 
				{
					this.ui.btnBackground.includeInLayout = true; 
					this.ui.btnBackground.visible = true; 
					continue; 
				}

			}
			
		}
		
		protected function onJSONEXPORT(event:Event):void
		{
			// TODO Auto-generated method stub
			var trgevent : ExportJSONCommandTriggerEvent = new ExportJSONCommandTriggerEvent(ExportJSONCommandTriggerEvent.EXPORT_JSON, '');
			this.dispatch(trgevent);
			
		}
		
		protected function onRedo(event:Event):void
		{
			// TODO Auto-generated method stub
			if ( this.model.undo.canRedo() == false ) 
				return; 
			var op : IOperation = this.model.undo.popRedo()
			op.performRedo()
			this.model.undo.pushUndo( op ) ; 
			//this.model.undo.redo(); 
			this.checkUndoButtons()
		}
		
		protected function onUndo(event:Event):void
		{
			if ( this.model.undo.canUndo() == false ) 
				return; 
			var op : IOperation = this.model.undo.popUndo()
			op.performUndo()
			this.model.undo.pushRedo( op ) ; 
			this.checkUndoButtons()
		}
		
		private function checkUndoButtons(e:Event=null):void
		{
			var dbg : Array = [this.model.undo.canUndo()] 
			//this.ui.btnRedo.enabled = this.model.undo.canRedo() 
			this.ui.btnUndo.enabled = this.model.undo.canUndo() 
		}
		
		private function onAddText(e:  Event): void
		{
			//blocked by default 
			var txtLayer  : TextLayerVO = this.model.getEmptyTextLayer();
			
			//seems wrong to do this here , make intention ... 
			if(txtLayer != null){//m:added check to avoid nullrefrence
				txtLayer.visible = true
				txtLayer.update(); 
				
				this.model.currentLayer = txtLayer; 
				return; 
				var obj : Object = e.data
				this.dispatch( new EditProductCommandTriggerEvent (
					EditProductCommandTriggerEvent.ADD_TEXT_LAYER, e) ) ; 
			}
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
			this.dispatch( new EditProductCommandTriggerEvent (
				EditProductCommandTriggerEvent.ADD_IMAGE_LAYER, e.url) ) ; 
		}
		
	}
}