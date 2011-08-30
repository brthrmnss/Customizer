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
	import org.syncon.Customizer.vo.ColorLayerVO;
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
		private var createUndos:Boolean=true;
		/**
		 * when repositing make suer to update handle width adn ehgiht 
		 * */
		private var repositioning:Boolean;
		/**
		 * if true, clicking a layer will not select it
		 * */
		private var disableClickSelection:Boolean=true;
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
			
			this.ui.addEventListener( layer_item_renderer.REPOSITION, 
				this.onReposition ) ; 
			
			/*
			eventMap.mapListener(eventDispatcher, NightStandModelEvent.CURRENT_LAYER_CHANGED, 
			this.onLayerChanged);	
			this.onLayerChanged( null ) 
			*/	
		}
		
		private function onLayerSelected(param0:Object):void
		{
			this.model.objectHandles.selectionManager.setSelected( this.model.currentLayer.model ) ; 
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
			if ( this.model.objectHandles == null ) 
			{
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
				
				this.model.objectHandles.enableMultiSelect = false; 
				this.model.objectHandles.disableHandleSelection = true; 
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
			if ( this.layer.locked && ['x', 'y', ].indexOf(event.property ) != -1 ) 
			{
				return;
			}
			switch( event.property )
			{
				
				case "x":
					this.ui.x = event.newValue as Number;
					this.layer.x = this.ui.x
					if ( createUndos == false )
						this.dispatch( new EditProductCommandTriggerEvent ( 
							EditProductCommandTriggerEvent.MOVE_LAYER, this.ui.x, this.ui.y
						) ) 
					break;
				case "y":
					this.ui.y = event.newValue as Number; 
					this.layer.y = this.ui.y
					if ( createUndos == false )
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
					/*	var ddbg : Array = [ this.ui.width, this.ui.image.width, this.ui.image.visible, this.ui.image.alpha, 
					this.ui.x, this.ui.image.x, this.ui.image.img.x] */
					if ( this.isImage ) 
					{
						this.ui.image.img.width = this.ui.width; 
					}
					if ( createUndos == false )
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
					if ( createUndos == false )
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
		
		public function onResize(event:ResizeEvent):void
		{
			if ( this.layer == null ) //why is this necessary? 
				return; 
			if ( this.ui.resetting ) 
				return; 
			/**
			 * if this is not the base layer and one exists, ... 
			 * go wait for later
			 * */
			if ( this.model.baseLayer != null &&
				this.model.baseLayer.repositionedOnce == false && this.layer != this.model.baseLayer )
			{
				this.model.waitForBaseLayer.push( [this, event] )
				this.ui.removeEventListener(ResizeEvent.RESIZE, this.onResize ) 
				//this.silent = false  //not sure about this one ...
				//silent means no undos ... this is on till reposition is finished ..
				return; 
			}
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
				//clone baselayer height if possible ...
				if ( this.layer != this.model.baseLayer && this.model.baseLayer != null )
				{
					if ( this.ui.width > this.model.baseLayer.width ) 
					{
						var wH : Number = this.ui.image.img.height/this.ui.image.img.width
						this.flexModel1.width = this.model.baseLayer.width - 40; 
						
						this.ui.image.img.width = this.flexModel1.width; 
						this.flexModel1.height =this.ui.image.img.width *wH
						this.ui.image.img.height = this.flexModel1.height; 						
					}
				}
			}	
			
			if ( this.layer.vertStartAlignment == LayerBaseVO.ALIGNMENT_CENTER) 
			{
				this.layer.vertStartAlignment = null
				this.ui.layer.y = this.ui.y = this.model.viewer.height/2 - this.ui.height/2
			}
			else if  ( this.layer.vertStartAlignment == '' ) 
			{
				this.layer.vertStartAlignment = ''
				this.ui.y   = this.model.baseLayer.y + this.ui.layer.y; 
				this.layer.y   = this.model.baseLayer.y + this.ui.layer.y; 
				//this.ui.layer.x = this.model.baseLayer.x + this.ui.layer.x; 
				
				//this.ui.layer.y = this.ui.y = this.model.viewer.height/2 - this.ui.height/2
			} 
			if ( this.layer.horizStartAlignment ==  LayerBaseVO.ALIGNMENT_CENTER) 
			{
				
				this.ui.layer.x = this.ui.x = this.model.viewer.width/2 - this.ui.width/2
				this.layer.horizStartAlignment = null 
			}
			else if  ( this.layer.horizStartAlignment == '' ) 
			{
				this.layer.horizStartAlignment = ''
				//this.ui.layer.y = this.model.baseLayer.y + this.ui.layer.y; 
				this.ui.x  = this.model.baseLayer.x + this.ui.layer.x; 
				this.layer.x  = this.model.baseLayer.x + this.ui.layer.x; 
				//this.ui.layer.y = this.ui.y = this.model.viewer.height/2 - this.ui.height/2
			}
			if ( this.isText ) 
			{
				trace('asd'); 
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
					v.img_.source = this.ui.image.layer.url; 
					v.img_.x = this.ui.x; 
					v.img_.y = this.ui.y; 
					/*
					this.ui.image.removeElement( this.ui.image.img ) ; 
					this.model.viewer.mask = this.ui.image.img
					*/	
					//v.mask = v.maskLayer;
					v.workspace.mask = v.maskLayer_
					v.workspace.maskType = MaskType.ALPHA
					//http://franto.com/inverse-masking-disclosed/
					//searched for inverse mask ...
				}
			}
			this.copyLayerToModel();
			if ( this.repositioning ) 
			{
				repositioning = false; 
			}
			this.ui.removeEventListener(ResizeEvent.RESIZE, this.onResize ) 
			this.createUndos = false 
			this.layer.repositionedOnce = true
			if (   this.layer == this.model.baseLayer && this.model.waitForBaseLayer.length > 0  )
			{
				
				for each ( var params : Array in this.model.waitForBaseLayer ) 
				{
					params[0].onResize(params[1]);//.push( [this, event] )
				}
				this.model.waitForBaseLayer = []; 
				return; 
			}
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
			if ( this.layer.height == 16 ) 
				trace('setting to 16'); 
			this.flexModel1.height = this.layer.height; 
		}
		
		/**
		 * Dispatched when itemRender's data is changed. 
		 * will regenerate all handles depending on layer properties 
		 * first step is to clear any old event listeners to refresh component 
		 * */
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
				this.layer.model = null; //? good idea 
				this.removeLayerListeners()
			}
			
			this.returnUIToDefaultState()
			
			this.layer = this.ui.layer; 
			this.layer.addEventListener(LayerBaseVO.LAYER_REDD, this.onLayerReAdd ) 
			this.layer.addEventListener(LayerBaseVO.LAYER_REMOVED, this.onLayerRemoved ) 
			this.layer.addEventListener(LayerBaseVO.LAYER_SELEECTED, this.onLayerSelected ) ; 
			
			this.layer.addEventListener(LayerBaseVO.UPDATED, this.onLayerUpdated ) 
			this.layer.model = this.flexModel1; 
			this.model.objectHandles.unregisterComponent( this.ui ) ; 
			this.ui.visible = this.layer.visible; //masking turns this off ... ... or just turn of mask layer here too
			this.ui.alpha = 1; 
			//this.model.objectHandles.unregisterModel( this.model ) ; 
			//this.registered = false
			//unlock any layre automatically
			if ( this.layer.locked ) 
			{
				this.ui.buttonMode=false 
				this.ui.useHandCursor=false
			}
			else //recreate the layers 
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
				
				var itemSizeConstraint : SizeConstraint = new SizeConstraint()
				itemSizeConstraint.minWidth = 16
				itemSizeConstraint.minHeight = 10
				constraints.push( itemSizeConstraint ) 
				
				if ( this.isText ) 
				{
					this.ui.text.layer.setFontSize(); 
					var handleDesc : Array = [];///this.model.objectHandles.defaultHandles.concat(); 
					handleDesc.push(new HandleDescription(HandleRoles.MOVE, new Point(50, 50), new Point(0, 0)));
					
					handleDesc.push(new HandleDescription(HandleRoles.MOVE, new Point(0, 0), new Point(0, 0)));
					handleDesc.push(new HandleDescription(HandleRoles.MOVE, new Point(100, 0), new Point(0, 0)));
					
					handleDesc.push(new HandleDescription(HandleRoles.MOVE, new Point(0, 100), new Point(0, 0)));
					
					handleDesc.push(new HandleDescription(HandleRoles.MOVE, new Point(100, 100), new Point(0, 0)));
					
					// We need a zero point a lot, so lets not re-create it all the time.
					var zero:Point = new Point(0,0);
					
					handleDesc.push( new HandleDescription( HandleRoles.ROTATE,
						new Point(100,50) , 
						new Point(20,0) ) ); 
					
					
					var defaultHandles : Array = handleDesc
					
					defaultHandles.push( new HandleDescription( HandleRoles.RESIZE_UP + HandleRoles.RESIZE_LEFT, 
						zero ,
						zero ) ); 
					
					defaultHandles.push( new HandleDescription( HandleRoles.RESIZE_UP ,
						new Point(50,0) , 
						zero ) ); 
					
					defaultHandles.push( new HandleDescription( HandleRoles.RESIZE_UP + HandleRoles.RESIZE_RIGHT,
						new Point(100,0) ,
						zero ) ); 
					
					defaultHandles.push( new HandleDescription( HandleRoles.RESIZE_RIGHT,
						new Point(100,50) , 
						zero ) ); 
					
					defaultHandles.push( new HandleDescription( HandleRoles.RESIZE_DOWN + HandleRoles.RESIZE_RIGHT,
						new Point(100,100) , 
						zero ) ); 
					
					defaultHandles.push( new HandleDescription( HandleRoles.RESIZE_DOWN ,
						new Point(50,100) ,
						zero ) ); 
					
					defaultHandles.push( new HandleDescription( HandleRoles.RESIZE_DOWN + HandleRoles.RESIZE_LEFT,
						new Point(0,100) ,
						zero ) ); 
					
					defaultHandles.push( new HandleDescription( HandleRoles.RESIZE_LEFT,
						new Point(0,50) ,
						zero ) ); 
					
					
					defaultHandles.push( new HandleDescription( HandleRoles.ROTATE,
						new Point(100,50) , 
						new Point(20,0) ) ); 
					
					
					
					
					//handleDesc.push(new HandleDescription(HandleRoles.MOVE, new Point(50, 50), new Point(0, 0)));
					handleDesc = null
					
					handleDesc   = this.model.objectHandles.defaultHandles.concat(); 
					handleDesc.pop(); 
					handleDesc.pop(); 
					handleDesc.pop(); 
					handleDesc = []
					
					handleDesc.push( new HandleDescription( HandleRoles.ROTATE,
						new Point(100,50) , 
						new Point(20,0) ) ); 
					//why must one add with no role? 
					//handleDesc.push(new HandleDescription(HandleRoles.NO_ROLE, new Point(50, 50), new Point(0, 0)));
					
					/* handleDesc.push(new HandleDescription(HandleRoles.NO_ROLE, new Point(0, 0), new Point(0, 0)));
					handleDesc.push(new HandleDescription(HandleRoles.NO_ROLE, new Point(100, 0), new Point(0, 0)));
					
					handleDesc.push(new HandleDescription(HandleRoles.NO_ROLE, new Point(0, 100), new Point(0, 0)));
					
					handleDesc.push(new HandleDescription(HandleRoles.NO_ROLE, new Point(100, 100), new Point(0, 0)));*/
					
					handleDesc.push( new HandleDescription( HandleRoles.NO_ROLE,
						new Point(0,50) , 
						new Point(-10,0) ) ); 
					
				}
				this.model.objectHandles.registerComponent( flexModel1, this.ui ,handleDesc, true, constraints);
				if ( this.layer.visible) //dont' select invisible layers
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
			
			//try to copy back the x's and y's ...
			if ( layer.repositionedOnce ) 
			{
				this.onReturnToPreviousSize(); 
			}
			
			//always resize the mask layers so they switch between faces
			if ( this.isImage && this.ui.image.layer.mask ) 
			{
				this.ui.addEventListener(ResizeEvent.RESIZE, this.onResize )
			}
			//if ingrave layer turn on the background
			if ( this.isText ) 
			{
				this.ui.text.bg.visible = false; 
				this.ui.text.bg.height = 0; this.layer.height; 
				this.ui.text.bg.width =0;// this.layer.width; 
				/*this.ui.text.height = NaN; //this.layer.height; 
				this.ui.text.width =NaN;// this.layer.width; 
				*/
				this.ui.text.height = NaN; //this.layer.height; 
				this.ui.text.width =NaN;
				if ( this.model.fxIsEngraveLayer( this.layer ) ) 
				{
					this.ui.text.bg.visible = true; 
					if ( this.layer.locked ) 
					{
						this.ui.text.txt.height = this.layer.height; ; //this.layer.height; 
						this.ui.text.txt.width =this.layer.width;
						this.ui.text.bg.height = this.layer.height; 
						this.ui.text.bg.width = this.layer.width; 
					}
				}
			}
		}
		
		private function onReturnToPreviousSize():void
		{
			this.copyLayerToModel(); 
			if (  this.isImage ) 
			{
				this.ui.image.img.width = this.layer.width; 
				this.ui.image.img.height = this.layer.height; 
			}
			if (  this.isColor ) 
			{
				this.ui.colorR.img.width = this.layer.width; 
				this.ui.colorR.img.height = this.layer.height; 
			}
			trace('return to place', this.layer.x ) ; 
			trace('return to place', this.layer.y ) ; 
			this.layer.update()
			this.layer.updateVisibility(); 
			return;
		}
		
		/**
		 * will setup the repositioing listener again  again ...
		 * */
		private function onReposition(e:Event):void
		{
			this.repositioning = true; 
			this.ui.addEventListener(ResizeEvent.RESIZE, this.onResize )
		}
		
		private function returnUIToDefaultState():void
		{
			this.ui.buttonMode=true 
			this.ui.useHandCursor=true
		}
		
		protected function onLayerUpdated(event:Event):void
		{
			//remove sleection if not supposed to be selected
			if (this.layer != null && this.layer.visible == false && this.model.currentLayer == this.layer) 
			{
				this.model.objectHandles.selectionManager.clearSelection()
			}
		}
		
		protected function onLayerRemoved(event:Event):void
		{
			this.model.objectHandles.unregisterComponent( this.ui ) ; 
			this.ui.removeEventListener(ResizeEvent.RESIZE, this.onResize ) 
			if ( this.layer != null ) 
			{
				this.removeLayerListeners()
			}
			this.ui.layer.loadedIntoLister = null;//key it will recreate from scratch
			this.ui.layer = null; 
			this.ui.data = null; 
		}
		
		private function removeLayerListeners() : void
		{
			this.layer.removeEventListener(LayerBaseVO.LAYER_REMOVED, this.onLayerRemoved ) 
			this.layer.removeEventListener(LayerBaseVO.LAYER_REDD, this.onLayerReAdd )
			this.layer.removeEventListener(LayerBaseVO.UPDATED, this.onLayerUpdated ) 
			this.layer.removeEventListener(LayerBaseVO.LAYER_SELEECTED, this.onLayerSelected ) 
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
			
			if ( this.disableClickSelection ) 
				return; 
			
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
		
		private function get isColor() : Boolean
		{
			return this.layer.type == ColorLayerVO.Type; 
		}
		
		
	}
}