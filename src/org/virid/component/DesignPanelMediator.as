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
	import org.syncon.Customizer.model.ViridConstants;
	import org.syncon.Customizer.view.ui.Toolbar;
	import org.syncon.Customizer.vo.ColorLayerVO;
	import org.syncon.Customizer.vo.ImageLayerVO;
	import org.syncon.Customizer.vo.ImageVO;
	import org.syncon.Customizer.vo.LayerBaseVO;
	import org.syncon.popups.controller.ShowPopupEvent;
	
	public class  DesignPanelMediator extends Mediator 
	{
		[Inject] public var ui : design_panel;
		[Inject] public var model : NightStandModel;
		/**
		 * will not allow creation of new layers.... weill resuse prompt layers
		 * */
		private var inViridMode:Boolean=true;
		private var loadIntoAndSelectImageLayer:ImageLayerVO;
		
		override public function onRegister():void
		{
			this.ui.addEventListener( design_panel.ADD_IMAGE,  this.onAddClipArtImage);	
			this.ui.addEventListener( design_panel.ADD_UPLOAD_IMAGE,  this.onAddUploadImage);	
			
			this.ui.addEventListener( design_panel.CHANGE_COLOR,  this.onChangeColor);			
			
			eventMap.mapListener(eventDispatcher, NightStandModelEvent.SHOW_EMPTY_LAYER, 
				this.onShowingNullLayer);	
			
			//set default color if defined ... do not make na undo fo rthis ....
			this.model.blockUndoAdding = true; 
			this.setColorFromLayer(); 
			this.model.blockUndoAdding = false; 
		}
		
		//use Object b/c uint does not like null...
		protected function onChangeColor(event:CustomEvent, color_ :  Object = null ):void
		{
			if ( color_ ==null ) 
				var color : uint = uint(event.data ) 
			else
				color = uint(color_ )
			var colorLayerName :  String =  'Mask'; 
			colorLayerName =  'Color Layer';
			this.dispatch( new EditProductCommandTriggerEvent (
				EditProductCommandTriggerEvent.CHANGE_LAYER_COLOR,color, colorLayerName ) ) ; 
		}
		/**
		 * normally this layer would be pullsed down intially ..., 
		 * but UI is out of sync on startup 
		 * */
		protected function setColorFromLayer(  ):void
		{
			//this.onChangeColor(null, this.ui.getSelectedColor ) ;
			var colorLayerName :  String =  'Mask'; 
			colorLayerName =  'Color Layer';
			var colorLayer : ColorLayerVO = this.model.getLayerByName( colorLayerName ) as ColorLayerVO
			if(colorLayer == null)return;
			this.ui.selectedColorSwatch.color = colorLayer.color

		}
		
		protected function onAddUploadImage(e:CustomEvent):void
		{
			/*	var obj : Object = e.data
			var event_ : ShowPopupEvent = new ShowPopupEvent(ShowPopupEvent.SHOW_POPUP, 
			'PopupPickImage', [this.onPickedImage], 'done' ) 		
			this.dispatch( event_ ) */
			var event_ : ShowPopupEvent = new ShowPopupEvent(ShowPopupEvent.SHOW_POPUP,
				'PopupUploadImage', [onUploadedImage], 'done' ) 		
			this.dispatch( event_ ) 
		}
		/**
		 * for teh virid player we will have to resuse existing layers if they are definied 
		 * */
		private function onUploadedImage( e : ImageVO ) : void
		{
			var currentLayer :  LayerBaseVO = this.model.currentLayer; 
			if ( inViridMode ) 
			{
				//rather than create a new layer, use one of the prompts 
				if (currentLayer == null ||  currentLayer.type != ImageLayerVO.Type ) 
				{
					var imgLayer  : ImageLayerVO = this.model.getEmptyImageLayer(ViridConstants.IMAGE_SOURCE_UPLOAD)
					//seems wrong to do this here , make intention ... 
					imgLayer.visible = true
					imgLayer.update(); 
					
					this.model.currentLayer = imgLayer; 
				}
			}
			if (  this.ui.layer == this.model.currentLayer ) 
			{
				this.dispatch( new EditProductCommandTriggerEvent (
					EditProductCommandTriggerEvent.CHANGE_IMAGE_URL, e.url) ) ; 
				return; 
			}
			this.dispatch( new EditProductCommandTriggerEvent (
				EditProductCommandTriggerEvent.ADD_IMAGE_LAYER, e.url) ) ; 
		}
		private function onAddText(e:  CustomEvent): void
		{
			var obj : Object = e.data
			this.dispatch( new EditProductCommandTriggerEvent (
				EditProductCommandTriggerEvent.ADD_TEXT_LAYER, e) ) ; 
		}		
		
		private function onAddClipArtImage(e:  CustomEvent): void
		{
			//var obj : Object = e.data
			var event_ : ShowPopupEvent = new ShowPopupEvent(ShowPopupEvent.SHOW_POPUP, 
				'PopupPickImage', [this.onPickedImage], 'done' ) 		
			this.dispatch( event_ ) 
		}		
		
		/**
		 * for teh virid player we will have to resuse existing layers if they are definied 
		 * */
		private function onPickedImage( e : ImageVO ) : void
		{
			
			if ( this.loadIntoAndSelectImageLayer  != null ) 
			{
				this.model.showLayer( loadIntoAndSelectImageLayer  ); 
				this.model.currentLayer =   this.loadIntoAndSelectImageLayer ;// != null ) ; 
				this.loadIntoAndSelectImageLayer = null; 
			}
			
			var currentLayer :  LayerBaseVO = this.model.currentLayer; 
			

			
			if ( inViridMode ) 
			{
				//rather than create a new layer, use one of the prompts 
				if (currentLayer == null ||  currentLayer.type != ImageLayerVO.Type ) 
				{
					var imgLayer  : ImageLayerVO = this.model.getEmptyImageLayer(ViridConstants.IMAGE_SOURCE_CLIPART)
					//seems wrong to do this here , make intention ... 
					imgLayer.visible = true
					imgLayer.update(); 
					
					this.model.currentLayer = imgLayer; 
				}
			}
			//if a prompt layer, change the source, do not add a new one 
			//08-29-11 ,even if it ws not a prompt layer you would still not add a new one ..
			// reuse what ever is loaded if it is valid
			//if ( this.model.currentLayer.prompt_layer && this.ui.layer == this.model.currentLayer ) 
			if (  this.ui.layer == this.model.currentLayer ) 
			{
				this.dispatch( new EditProductCommandTriggerEvent (
					EditProductCommandTriggerEvent.CHANGE_IMAGE_URL, e.url) ) ; 
				return; 
			}
			this.dispatch( new EditProductCommandTriggerEvent (
				EditProductCommandTriggerEvent.ADD_IMAGE_LAYER, e.url) ) ; 
		}
		
		
		public function onShowingNullLayer( e : NightStandModelEvent ) : void
		{
			
			var layer : LayerBaseVO = e.data as LayerBaseVO; 
			if ( layer is ImageLayerVO ) 
			{
				var imgLayer : ImageLayerVO = layer as ImageLayerVO
			}
			if ( imgLayer == null ) 
				return; 
			
			e.preventDefault(); 
			
			this.loadIntoAndSelectImageLayer = imgLayer; 
			
			this.onAddClipArtImage(null)
		}
	}
}