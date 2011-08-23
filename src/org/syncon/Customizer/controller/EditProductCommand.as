package org.syncon.Customizer.controller
{
	import org.robotlegs.mvcs.Command;
	import org.syncon.Customizer.model.NightStandModel;
	import org.syncon.Customizer.model.NightStandModelEvent;
	import org.syncon.Customizer.vo.ColorLayerVO;
	import org.syncon.Customizer.vo.ImageLayerVO;
	import org.syncon.Customizer.vo.LayerBaseVO;
	import org.syncon.Customizer.vo.StoreItemVO;
	import org.syncon.Customizer.vo.TextLayerVO;
	
	public class EditProductCommand extends Command 
	{
		[Inject] public var model:NightStandModel;
		[Inject] public var event:EditProductCommandTriggerEvent
		
		private var debugUndos : Boolean = false; 
		
		override public function execute():void
		{
			if ( this.model.blockUndos )
			{
				trace('block undo'); 
				return;
			}
			/*if ( event.undo == false && event.redo == false )
			{
			event.oldFocus = onenote_lister_partialF4.SelectedObject
			}
			*/
			var undoable: Boolean = true
			if ( event.type == EditProductCommandTriggerEvent.ADD_IMAGE_LAYER ) 
			{
				//var oldName : String = this.model.currentPage.name
				//var newName : String = event.data.toString(); 
				if ( event.undo == false )
				{
					if ( event.firstTime ) 
					{
						var imgLayer : ImageLayerVO = new ImageLayerVO(); 
						imgLayer.name = 'Image ' +( this.model.getLayersByType(ImageLayerVO).length+1) 
						this.model.addLayer( imgLayer ); 
						
						imgLayer.x = 0; 
						imgLayer.y = 100; 
						
						this.model.currentLayer = imgLayer; 
						imgLayer.url = event.data.toString(); 
						event.oldData = imgLayer; 
						//event.oldData = oldName; 
						//this.model.currentPage.name = newName 
						
						
					}	
					else
					{
						//if it exists just add it back to the stage ....
						imgLayer = event.oldData as ImageLayerVO; 
						this.model.addLayer( imgLayer ); 
						imgLayer.layerReAdded(); 
					}
					
				}
				else
				{
					imgLayer = event.oldData as ImageLayerVO; 
					this.model.removeLayer( imgLayer ) ; 
					txtLayer.layerRemoved()
					//oldName = event.oldData.toString(); 
					//this.model.currentPage.name = oldName
				}		
				//this.model.currentPage.updated();
				this.model.layersChanged(); 
				this.dispatch( new EditProductCommandTriggerEvent(
					EditProductCommandTriggerEvent.IMAGE_LAYER_ADDED, event, null ) ) 
			}
			
			if ( event.type == EditProductCommandTriggerEvent.ADD_TEXT_LAYER ) 
			{
				//var oldName : String = this.model.currentPage.name
				//var newName : String = event.data.toString(); 
				if ( event.undo == false )
				{
					if ( event.firstTime ) 
					{
						var txtLayer : TextLayerVO = new TextLayerVO(); 
						txtLayer.name = 'Text ' + (this.model.getLayersByType(TextLayerVO).length+1); ; 
						txtLayer.text =  event.data.toString() ; //'Enter Text Here';
						//txtLayer.fontFamily =  event.data2.toString() ; //font ... what should default be? ...
						this.model.addLayer( txtLayer ); 
						event.oldData = txtLayer; 
						//this.model.currentPage.name = newName 
						txtLayer.y = 100; 
						
						txtLayer.x = 0; 
						txtLayer.y = 100; 
					}	
					else
					{
						//if it exists just add it back to the stage ....
						txtLayer = event.oldData as TextLayerVO; 
						this.model.addLayer( txtLayer ); 
						txtLayer.layerReAdded(); 
					}
					this.model.currentLayer = txtLayer; 
				}
				else
				{
					txtLayer = event.oldData as TextLayerVO; 
					this.model.removeLayer( txtLayer ) ; 
					txtLayer.layerRemoved()
				}		
				//this.model.currentPage.updated();
				this.model.layersChanged(); 
				this.dispatch( new EditProductCommandTriggerEvent(
					EditProductCommandTriggerEvent.TEXT_LAYER_ADDED, event, null ) ) 
			}
			
			
			
			
			
			if ( event.type == EditProductCommandTriggerEvent.CHANGE_FONT_SIZE ) 
			{
				if ( event.undo == false )
				{
					txtLayer = this.model.currentLayer as TextLayerVO; 
					if ( event.firstTime ) 
					{
						/*txtLayer.x = 0; 
						txtLayer.y = 100; */
					}		
					event.oldData = txtLayer.fontSize; 
					txtLayer.fontSize = int( event.data ); 
					txtLayer.update('fontSize'); 
					this.model.currentLayer = txtLayer; 
					event.data2 = txtLayer ; //don't like this feel like storing old layer should be automatic ...
				}
				else
				{
					txtLayer = event.data2 as TextLayerVO; 
					txtLayer.fontSize = int( event.oldData ); 
					txtLayer.update('fontSize'); 
				}		
				//this.model.currentPage.updated();
				//this.model.layersChanged(); 
				this.dispatch( new EditProductCommandTriggerEvent(
					EditProductCommandTriggerEvent.FONT_SIZE_CHANGED, event, null ) ) 
			}
			if ( event.type == EditProductCommandTriggerEvent.CHANGE_FONT_FAMILY ) 
			{
				if ( event.undo == false )
				{
					txtLayer = this.model.currentLayer as TextLayerVO; 
					if ( event.firstTime ) 
					{
						/*txtLayer.x = 0; 
						txtLayer.y = 100; */
					}		
					event.oldData = txtLayer.fontFamily; 
					txtLayer.fontFamily = event.data.toString() 
					txtLayer.update('fontFamily'); 
					this.model.currentLayer = txtLayer; 
					event.data2 = txtLayer ; //don't like this feel like storing old layer should be automatic ...
				}
				else
				{
					txtLayer = event.data2 as TextLayerVO; 
					txtLayer.fontFamily = event.oldData.toString() 
					txtLayer.update('fontFamily'); 
				}		
				//this.model.currentPage.updated();
				//this.model.layersChanged(); 
				this.dispatch( new EditProductCommandTriggerEvent(
					EditProductCommandTriggerEvent.FONT_SIZE_CHANGED, event, null ) ) 
			}
			if ( event.type == EditProductCommandTriggerEvent.CHANGE_COLOR 
				&& this.model.currentLayer is ColorLayerVO ) 
			{
				if ( event.undo == false )
				{
					colorLayer = this.model.currentLayer as ColorLayerVO; 
					if ( event.firstTime ) 
					{
						/*txtLayer.x = 0; 
						txtLayer.y = 100; */
					}		
					event.oldData = colorLayer.color; 
					colorLayer.color = ( event.data ); 
					colorLayer.update('color'); 
					this.model.currentLayer = colorLayer; 
					event.data2 = colorLayer ; //don't like this feel like storing old layer should be automatic ...
				}
				else
				{
					colorLayer = event.data2 as ColorLayerVO; 
					colorLayer.color = ( event.oldData ); 
					colorLayer.update('color'); 
				}		
				//this.model.currentPage.updated();
				//this.model.layersChanged(); 
				this.dispatch( new EditProductCommandTriggerEvent(
					EditProductCommandTriggerEvent.COLOR_CHANGED, event, null ) ) 
			}
			
			if ( event.type == EditProductCommandTriggerEvent.CHANGE_COLOR 
				&& this.model.currentLayer is TextLayerVO )  
			{
				if ( event.undo == false )
				{
					txtLayer = this.model.currentLayer as TextLayerVO; 
					if ( event.firstTime ) 
					{
						/*txtLayer.x = 0; 
						txtLayer.y = 100; */
					}		
					event.oldData = txtLayer.color; 
					txtLayer.color = ( event.data ); 
					txtLayer.update('color'); 
					this.model.currentLayer = txtLayer; 
					event.data2 = txtLayer ; //don't like this feel like storing old layer should be automatic ...
				}
				else
				{
					txtLayer = event.data2 as TextLayerVO; 
					txtLayer.color = ( event.oldData ); 
					txtLayer.update('color'); 
				}		
				//this.model.currentPage.updated();
				//this.model.layersChanged(); 
				this.dispatch( new EditProductCommandTriggerEvent(
					EditProductCommandTriggerEvent.COLOR_CHANGED, event, null ) ) 
			}
			
			
			//how to map this? ... use a string for layer association
			if ( event.type == EditProductCommandTriggerEvent.CHANGE_LAYER_COLOR 
				  )  
			{
				if ( event.undo == false )
				{
					//if ( event.data2 != null ) 
					//this.model.getColorLayer(event.data2 )
					colorLayer = this.model.layerColor; //this.model.currentLayer as ColorLayerVO; 
			 	
					event.oldData = colorLayer.color; 
					colorLayer.color = ( event.data ); 
					colorLayer.update('color'); 
					event.data3 = colorLayer ; 
				}
				else
				{
					colorLayer = event.data3 as ColorLayerVO; 
					colorLayer.color = ( event.oldData ); 
					colorLayer.update('color'); 
				}		
				//this.model.currentPage.updated();
				//this.model.layersChanged(); 
				this.dispatch( new EditProductCommandTriggerEvent(
					EditProductCommandTriggerEvent.LAYER_COLOR_CHANGED, event, null ) ) 
			}
			
			
			
			
			if ( event.type == EditProductCommandTriggerEvent.LOAD_PRODUCT ) 
			{
				if ( event.undo == false )
				{
					//event.oldData = this.model.cur
					var product : StoreItemVO = event.data as StoreItemVO; 
					this.model.layers.removeAll();
					this.model.baseLayer = null; 
					if ( product.base_image_url != null ) 
					{
						imgLayer = new ImageLayerVO(); 
						imgLayer.name = 'Base Image';
						imgLayer.url = product.base_image_url; 
						imgLayer.locked = true; 
						imgLayer.showInList = false; 
						this.model.addLayer( imgLayer ) ;
						if ( event.firstTime ) 
						{
							imgLayer.x = 0; 
							imgLayer.y = 100; 
						}
						//this.model.currentLayer = imgLayer; 
						this.model.baseLayer = imgLayer; 
						 
						
						var colorLayer : ColorLayerVO = new ColorLayerVO(); 
						colorLayer.name = 'Color Base Image';
						colorLayer.url = product.base_image_url; 
						colorLayer.locked = true; 
						colorLayer.showInList = false; 
						this.model.addLayer( colorLayer ) ;
						if ( event.firstTime ) 
						{
							colorLayer.x = 0; 
							colorLayer.y = 100; 
						}
						this.model.layerColor = colorLayer; 
						
						//order doesn't matter as it doesn't appear ...
						imgLayer = new ImageLayerVO(); 
						imgLayer.name = 'Mask  Image';
						imgLayer.url = product.base_image_url; 
						//imgLayer.url = 'assets/images/img.jpg'
						imgLayer.locked = true; 
						imgLayer.showInList = false; 
						imgLayer.mask = true; 
						this.model.addLayer( imgLayer ) ;
						if ( event.firstTime ) 
						{
							imgLayer.x = 0; 
							imgLayer.y = 100; 
						}
						//	this.model.currentLayer = imgLayer; 
						this.model.layerMask = imgLayer; 
						
						//this.model.currentLayer = colorLayer; 
						
						
					}
					//this.model.undo.clearAll(); 
					this.model.layersChanged(); 
				}
				else
				{
					undoable = false 
					//oldName = event.oldData.toString(); 
					//this.model.currentPage.name = oldName
				}		
				//this.model.currentPage.updated();
				this.model.layersChanged(); 
				this.dispatch( new EditProductCommandTriggerEvent(
					EditProductCommandTriggerEvent.IMAGE_LAYER_ADDED, event, null ) ) 
			}
			/*	if ( event.type == EditProductCommandTriggerEvent.MOVE_LAYER ) 
			{
			
			//var oldName : String = this.model.currentPage.name
			//var newName : String = event.data.toString(); 
			if ( event.undo == false )
			{
			layer = this.model.currentLayer
			event.oldData = layer.x; 
			event.oldData2 = layer.y 
			var x : Number = event.data as Number
			var y : Number =event.data2 as Number
			layer.x = x
			layer.y = y 
			event.data3 = layer
			}
			else
			{
			layer = event.data3 as LayerBaseVO ;
			layer.x =event.oldData as Number 
			layer.y = event.oldData2 as Number 
			}		
			//this.model.currentPage.updated();
			this.model.layersChanged(); 
			this.dispatch( new EditProductCommandTriggerEvent(
			EditProductCommandTriggerEvent.LAYER_MOVED, event, null ) ) 
			}*/
			if ( event.type == EditProductCommandTriggerEvent.MOVE_LAYER ) 
			{
				if ( event.undo == false )
				{
					var layer : LayerBaseVO = this.model.currentLayer as LayerBaseVO; 
					if ( event.firstTime ) 
					{
						/*txtLayer.x = 0; 
						txtLayer.y = 100; */
					}		
					event.oldData = layer.x; 
					event.oldData2 = layer.y; 
					this.model.blockUndos=true
					layer.setXY( event.data, event.data2 ) ; 
					layer.update(); 
					event.data3 = layer ; 
					this.model.blockUndos=false
					if ( debugUndos )   trace('go', event.data, event.data2 )
				}
				else
				{
					this.model.blockUndos=true
					layer = event.data3 as LayerBaseVO; 
					layer.setXY( event.oldData, event.oldData2 ) ; 
					layer.update(); 
					if ( debugUndos )  trace('redo', event.data, event.data2 )
					this.model.blockUndos=false
				}		
				//this.model.currentPage.updated();
				//this.model.layersChanged(); 
				this.dispatch( new EditProductCommandTriggerEvent(
					EditProductCommandTriggerEvent.LAYER_MOVED, event, null ) ) 
			}	
			
			if ( event.type == EditProductCommandTriggerEvent.RESIZE_LAYER ) 
			{
				if ( event.undo == false )
				{
					layer = this.model.currentLayer as LayerBaseVO; 
					if ( event.firstTime ) 
					{
						/*txtLayer.x = 0; 
						txtLayer.y = 100; */
					}		
					event.oldData = layer.width; 
					event.oldData2 = layer.height; 
					this.model.blockUndos=true
					layer.setWH( event.data, event.data2 ) ; 
					layer.update(); 
					event.data3 = layer ; 
					this.model.blockUndos=false
					//trace('go', event.data, event.data2 )
				}
				else
				{
					this.model.blockUndos=true
					layer = event.data3 as LayerBaseVO; 
					layer.setWH( event.oldData, event.oldData2 ) ; 
					layer.update(); 
					//trace('redo', event.data, event.data2 )
					this.model.blockUndos=false
				}		
				//this.model.currentPage.updated();
				//this.model.layersChanged(); 
				this.dispatch( new EditProductCommandTriggerEvent(
					EditProductCommandTriggerEvent.LAYER_RESIZED, event, null ) ) 
			}	
			if ( event.firstTime && undoable) 
			{
				var lastUndo : EditProductCommandTriggerEvent = this.model.lastUndo
				if ( lastUndo != null && lastUndo.type == event.type ) 
				{
					if ( event.type == EditProductCommandTriggerEvent.MOVE_LAYER
						&& event.data3 == lastUndo.data3)
					{
						if ( debugUndos ) trace('merging'); 
						this.model.lastUndo.data = event.data; 
						this.model.lastUndo.data2 = event.data2
						return; 
					}
				}
				if ( debugUndos ) trace('merging');  trace('addeded one')
				this.model.lastUndo = event; 
				this.model.undo.pushUndo( event ) ;
				this.dispatch( new NightStandModelEvent(NightStandModelEvent.UNDOS_CHANGED) ) 
			}
		}
		
		
	}
}