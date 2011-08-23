package org.syncon.Customizer.view.ui
{
	import com.roguedevelopment.objecthandles.Flex4ChildManager;
	import com.roguedevelopment.objecthandles.Flex4HandleFactory;
	import com.roguedevelopment.objecthandles.HandleDescription;
	import com.roguedevelopment.objecthandles.HandleRoles;
	import com.roguedevelopment.objecthandles.ObjectHandles;
	import com.roguedevelopment.objecthandles.constraints.MaintainProportionConstraint;
	import com.roguedevelopment.objecthandles.constraints.MovementConstraint;
	import com.roguedevelopment.objecthandles.constraints.SizeConstraint;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.events.PropertyChangeEvent;
	import mx.events.ResizeEvent;
	
	import org.robotlegs.mvcs.Mediator;
	import org.syncon.Customizer.controller.EditProductCommandTriggerEvent;
	import org.syncon.Customizer.model.CustomEvent;
	import org.syncon.Customizer.model.NightStandModel;
	import org.syncon.Customizer.vo.ImageLayerVO;
	import org.syncon.Customizer.vo.LayerBaseVO;
	import org.syncon.Customizer.vo.TextLayerVO;
	import org.syncon.onenote.onenotehelpers.impl.layer_item_renderer;
	import org.syncon.onenote.onenotehelpers.impl.viewer2_store;
	
	import spark.core.MaskType;
	
	/**
	 * click it make it the model layer 
	 * 
	 * @author user3
	 * 
	 */
	public class LayerItemRendererMediator extends Mediator 
	{
		[Inject] public var ui : layer_item_renderer;
		[Inject] public var model : NightStandModel;
		private var layer : LayerBaseVO ; 
		protected var flexModel1:SimpleDataModel = new SimpleDataModel();
		private var registered:Boolean;
		/**
		 * do not log undo events ...
		 * */
		private var silent:Boolean=true;
		override public function onRegister():void
		{
			this.ui.addEventListener( layer_item_renderer.ON_CLICK, 
				this.onClick);	
			this.ui.addEventListener( layer_item_renderer.DATA_CHANGED, 
				this.onDataChanged ) ; 
			this.ui.addEventListener( layer_item_renderer.MOVED, 
				this.onMoved ) ; 
			this.ui.addEventListener( layer_item_renderer.RESIZED_MANIALY, 
				this.onResizedManually ) ; 
			this.initHandles()
		}
		
		/**
		 * when user does an action that cuases a resize 
		 * this is broken out so it is not confused with 
		 * event driving actions
		 * */
		protected function onResizedManually(event:Event):void
		{
			this.flexModel1.x = this.layer.x ; 
			this.flexModel1.y = this.layer.y ; 
			this.layer.width; 
			this.flexModel1.width = this.layer.nonChromeWidth;//this.ui.width; 
			this.flexModel1.height = this.layer.nonChromeHeight;//this.ui.height; 
			//copyLayerToModel()
		}
		
		private function initHandles():void
		{
			if ( this.model.objectHandles == null ) {
				this.model.objectHandles = new ObjectHandles( this.model.viewer as Sprite, null, new Flex4HandleFactory(), 
					new Flex4ChildManager() ) 
				//this.model.objectHandles.defaultHandles
				var m : MovementConstraint = new MovementConstraint()
				m.maxX = this.model.viewer.width; 
				m.maxY = this.model.viewer.height; 
				m.minX = 0; 
				m.minY = 0; 
				//this.model.objectHandles.addDefaultConstraint( m )
				var sZ : SizeConstraint = new SizeConstraint()
				sZ.maxHeight = this.model.viewer.height; 
				sZ.maxWidth = this.model.viewer.width; 
				sZ.minHeight = 20
				sZ.minWidth = 30
				//this.model.objectHandles.addDefaultConstraint( sZ )
			}
			//this.model.objectHandles.addDefaultConstraint(
			//this.model.objectHandles
			/*flexModel1.x = 50;
			flexModel1.y = 150;
			flexModel1.width = 50;
			flexModel1.height = 50;
			flexModel1.isLocked = true;*/
			var constraints : Array = new Array()
			//if baseLayer is Around 
			
			var handleDesc : Array = this.model.objectHandles.defaultHandles.concat(); 
			handleDesc.push(new HandleDescription(HandleRoles.MOVE, new Point(50, 50), new Point(0, 0)));
			handleDesc = null
			this.model.objectHandles.registerComponent( flexModel1, this.ui, handleDesc , true, constraints);
			this.registered = true ;
			this.flexModel1.addEventListener( PropertyChangeEvent.PROPERTY_CHANGE, this.onModelChange ) ; 
		}
		
		/**
		 * Set new sizes from simplemodel on layerVO
		 * */
		protected function onModelChange( event:PropertyChangeEvent):void
		{
			if ( this.isText && ['width', 'height', ].indexOf(event.property ) != -1 ) 
			{
				return;
			}
			switch( event.property )
			{
				
				case "x":
					this.ui.x = event.newValue as Number;
					this.layer.x = this.ui.x
					if ( silent == false )
						this.dispatch( new EditProductCommandTriggerEvent ( 
							EditProductCommandTriggerEvent.MOVE_LAYER, this.ui.x, this.ui.y
						) ) 
					break;
				case "y":
					this.ui.y = event.newValue as Number; 
					this.layer.y = this.ui.y
					if ( silent == false )
						this.dispatch( new EditProductCommandTriggerEvent ( 
							EditProductCommandTriggerEvent.MOVE_LAYER, this.ui.x, this.ui.y
						) ) 
					break;
				case "rotation":
					this.ui.rotation = event.newValue as Number;
					//this.layer.x = this.ui.x
					break;
				case "width": 
					this.ui.width = event.newValue as Number;
					this.layer.width = this.ui.width
					if ( this.isImage ) 
					{
						this.ui.image.img.width = this.ui.width; 
					}
					if ( silent == false )
						this.dispatch( new EditProductCommandTriggerEvent ( 
							EditProductCommandTriggerEvent.RESIZE_LAYER, this.ui.width, this.ui.height
						) ) 					
					break;
				case "height": 
					this.ui.height = event.newValue as Number;
					this.layer.height = this.ui.height
					if ( this.isImage ) 
					{
						this.ui.image.img.height = this.ui.height; 
					}
					if ( silent == false )
						this.dispatch( new EditProductCommandTriggerEvent ( 
							EditProductCommandTriggerEvent.RESIZE_LAYER, this.ui.width, this.ui.height
						) ) 					
					break;
				default: return;
			}
			
			this.layer.update(); 
			//redraw();
		}
		protected function onMoved(event:CustomEvent):void
		{
			this.dispatch( new EditProductCommandTriggerEvent(
				EditProductCommandTriggerEvent.MOVE_LAYER, this.layer, event.data[0], event.data[1] 
			) ) ; 
		}
		
		protected function onResize(event:ResizeEvent):void
		{
			if ( this.layer == null ) //why is this necessary? 
				return; 
			if ( this.ui.resetting ) 
				return; 
			if ( this.layer is ImageLayerVO ) 
			{
				/*if ( this.ui.image == null ) 
				return;
				if ( this.ui.image.resizedOnce == false ) 
				return; */
				/*
				//8-23-11: had to take this out b/c of cache ...
				//for some reason iange resize is distapched isntantly ... wait till it is proper first ... 
				if ( this.ui.image.img.bitmapData == null && this.ui.image.img.source != '' ) 
					return;
				*/
				//this.ui.image.img.sourceHeight
			}			
			if ( this.layer.vertStartAlignment == 'center' ) 
			{
				this.layer.vertStartAlignment = null
				this.ui.layer.y = this.ui.y = this.model.viewer.height/2 - this.ui.height/2
			}
			if ( this.layer.horizStartAlignment == 'center' ) 
			{
				
				this.ui.layer.x = this.ui.x = this.model.viewer.width/2 - this.ui.width/2
				this.layer.horizStartAlignment = null 
			}
			//if image maintain aspect ration
			if ( this.isImage ) 
			{
				/*var itemMovementCons : MaintainProportionConstraint = new MaintainProportionConstraint()
				this.unregister()
				this.register([ itemMovementCons] )*/
			}
			if ( this.isImage )
			{
				//make this a new type ....
				//we are copying the url and sizing to the mask layer that is already laid down 
				if ( this.ui.image.layer.mask )
				{
					this.ui.visible = false;
					//so visible does not work, but alpha does...
					this.ui.alpha = 0.1
					var v : viewer2_store = this.model.viewer as viewer2_store
					v.img.source = this.ui.image.layer.url; 
					v.img.x = this.ui.x; 
					v.img.y = this.ui.y; 
					/*
					this.ui.image.removeElement( this.ui.image.img ) ; 
					this.model.viewer.mask = this.ui.image.img
					*/	
					//v.mask = v.maskLayer;
					v.workspace.mask = v.maskLayer
					v.workspace.maskType = MaskType.ALPHA
					//http://franto.com/inverse-masking-disclosed/
					//searched for inverse mask ...
				}
			}
			this.copyLayerToModel();
			this.ui.removeEventListener(ResizeEvent.RESIZE, this.onResize ) 
			this.silent = false 
		}
		
		private function unregister():void
		{
			this.model.objectHandles.unregisterComponent( this.ui ) ; 
		}
		private function register(constraints:Array):void
		{
			this.model.objectHandles.registerComponent( flexModel1, this.ui ,null, true, constraints);
			this.model.objectHandles.selectionManager.setSelected( this.flexModel1 ) ; 
		}
		
		private function copyLayerToModel():void
		{
			this.flexModel1.x = this.layer.x ; 
			this.flexModel1.y = this.layer.y ; 
			this.flexModel1.width = this.layer.width; 
			this.flexModel1.height = this.layer.height; 
		}
		
		protected function onDataChanged(event:Event):void
		{
			if ( ui.layer == null ) 
			{
				this.ui.removeEventListener(ResizeEvent.RESIZE, this.onResize ) 
				this.layer = null 
				return; 
			}
			if ( this.layer != null ) 
			{
				this.layer.removeEventListener(LayerBaseVO.LAYER_REMOVED, this.onLayerRemoved ) 
				this.layer.removeEventListener(LayerBaseVO.LAYER_REDD, this.onLayerReAdd ) 
			}
			
			this.layer = this.ui.layer; 
			this.layer.addEventListener(LayerBaseVO.LAYER_REDD, this.onLayerReAdd ) 
			this.layer.addEventListener(LayerBaseVO.LAYER_REMOVED, this.onLayerRemoved ) 
			this.layer.model = this.flexModel1; 
			this.model.objectHandles.unregisterComponent( this.ui ) ; 
			this.ui.visible = true; //masking turns this off ... ... or just turn of mask layer here too
			//this.model.objectHandles.unregisterModel( this.model ) ; 
			//this.registered = false
			//unlock any layre automatically
			if ( this.layer.locked ) 
			{
				
			}else
			{
				var constraints : Array = []; 
				constraints 
				/*if ( this.registered == false )
				{
				this.registered = true; */
				
				//contrain new layers to inside main layer ....
				if ( this.model.baseLayer != null ) 
				{
					var itemMovementCons : MovementConstraint = new MovementConstraint()
					itemMovementCons.maxX = this.model.baseLayer.x + this.model.baseLayer.width; 
					itemMovementCons.maxY = this.model.baseLayer.y + this.model.baseLayer.height; 
					itemMovementCons.minX = this.model.baseLayer.x; ; 
					itemMovementCons.minY = this.model.baseLayer.y; ; 
					// constraints.push( itemMovementCons )
				}
				
				
				//need all images to lock aspect ration 
				if ( this.isImage ) 
				{
					var mpCon : MaintainProportionConstraint = new MaintainProportionConstraint()
					constraints.push( mpCon ) 
				}
				
				this.model.objectHandles.registerComponent( flexModel1, this.ui ,null, true, constraints);
				this.model.objectHandles.selectionManager.setSelected( this.flexModel1 ) ; 
				/*		}*/
			}
			
			this.flexModel1.isLocked = this.layer.locked; 
			//this.copyLayerToModel();
			
			if ( this.layer.vertStartAlignment != null || this.layer.horizStartAlignment != null ) 
			{
				this.ui.addEventListener(ResizeEvent.RESIZE, this.onResize )
				//if this is a new layer ... bring it to the front .... 
				//also when clicked in layerlist 
				this.ui.depth = this.ui.parent.numChildren-1
			}
		}
		
		protected function onLayerRemoved(event:Event):void
		{
			this.model.objectHandles.unregisterComponent( this.ui ) ; 
			this.ui.removeEventListener(ResizeEvent.RESIZE, this.onResize ) 
			if ( this.layer != null ) 
			{
				this.layer.removeEventListener(LayerBaseVO.LAYER_REMOVED, this.onLayerRemoved ) 
				this.layer.removeEventListener(LayerBaseVO.LAYER_REDD, this.onLayerReAdd ) 
			}
			this.ui.layer.loadedIntoLister = null;//key it will recreate from scratch
			this.ui.layer = null; 
			this.ui.data = null; 
		}
		/**
		 * dispathec when layer is added back to the screen ...
		 * */
		protected function onLayerReAdd(event:Event):void
		{
			this.model.objectHandles.selectionManager.setSelected( this.model ) ; 
			this.onDataChanged(null); 
		}
		
		private function onClick(e: CustomEvent): void
		{
			//stop pover selecting ....
			/*if ( this.model.currentLayer == this.ui.listData ) 
			return;*/ 
			if ( this.layer.locked ) 
				return
				this.model.currentLayer = this.ui.listData as LayerBaseVO; 
		}		
		
		private function get isText() : Boolean
		{
			return this.layer.type == TextLayerVO.Type; 
		}
		
		private function get isImage() : Boolean
		{
			return this.layer.type == ImageLayerVO.Type; 
		}
		
		
	}
}