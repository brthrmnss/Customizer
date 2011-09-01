package org.syncon.Customizer.controller
{
	import org.robotlegs.mvcs.Command;
	import org.syncon.Customizer.model.NightStandModel;
	import org.syncon.Customizer.model.NightStandModelEvent;
	import org.syncon.Customizer.vo.ColorLayerVO;
	import org.syncon.Customizer.vo.FaceVO;
	import org.syncon.Customizer.vo.ImageLayerVO;
	import org.syncon.Customizer.vo.LayerBaseVO;
	import org.syncon.Customizer.vo.StoreItemVO;
	import org.syncon.Customizer.vo.TextLayerVO;
	import org.syncon.onenote.onenotehelpers.impl.viewer2_store;
	
	public class EditProductCommand extends Command 
	{
		[Inject] public var model:NightStandModel;
		[Inject] public var event:EditProductCommandTriggerEvent
		
		private var debugUndos : Boolean = true; 
		
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
						//if first param is a string 
						if ( event.data is String  ) 
						{
							var imgLayer : ImageLayerVO = new ImageLayerVO(); 
							imgLayer.name = 'Image ' +( this.model.getLayersByType(ImageLayerVO).length+1) 
							imgLayer.url = event.data.toString(); 
						}
						//if first paramt imagelayerVO, clone it 
						if ( event.data is ImageLayerVO  ) 
						{
							imgLayer = event.data as ImageLayerVO
							imgLayer = imgLayer.clone() as ImageLayerVO
							/*	if ( imgLayer.prompt_layer )
							imgLayer.visible = false; */
						}
						event.oldData = imgLayer; 
						
						this.model.addLayer( imgLayer ); 
						/*
						imgLayer.x = 0; 
						imgLayer.y = 100; 
						*/
						/*imgLayer.x = 0; 
						imgLayer.y = 0; */
						//imgLayer.y = 100; 
						
						if (  imgLayer.visible ) //prompts are not by default visible ...
							this.model.currentLayer = imgLayer; 
						
						
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
					imgLayer.layerRemoved()
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
					//why the first time, ADD_IMAGE_LAYER image layer does not have it ? 
					if ( event.firstTime ) 
					{
						//if first param is a string 
						if ( event.data is String  ) 
						{
							var txtLayer : TextLayerVO = new TextLayerVO(); 
							txtLayer.name = 'Text ' + (this.model.getLayersByType(TextLayerVO).length+1); ; 
							txtLayer.text =  event.data.toString() ; //'Enter Text Here';
							/*
							txtLayer.y = 100; 
							txtLayer.x = 0; 
							txtLayer.y = 100; 
							*/
						}
						//if first param TextLayerVO, clone it 
						if ( event.data is TextLayerVO  ) 
						{
							txtLayer = event.data as TextLayerVO
							txtLayer = txtLayer.clone() as TextLayerVO
						}
						/*
						txtLayer.x = 0; 
						txtLayer.y = 100; 
						*/
						//txtLayer.fontFamily =  event.data2.toString() ; //font ... what should default be? ...
						this.model.addLayer( txtLayer ); 
						event.oldData = txtLayer; 
						//this.model.currentPage.name = newName 
						
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
			
			if ( event.type == EditProductCommandTriggerEvent.CHANGE_IMAGE_URL ) 
			{
				if ( event.undo == false )
				{
					imgLayer = this.model.currentLayer as ImageLayerVO; 
					
					event.oldData = imgLayer.url;
					//upload sends bitmapdata bytes, otherwise we have strings
					if ( event.data  != null  ) 
					{
					imgLayer.url  =   event.data.toString()
					}
					if ( event.data2 != null ) 
					{
						imgLayer.url  = ''
						imgLayer.source = event.data2; 
					}
					imgLayer.update(ImageLayerVO.SOURCE_CHANGED)//'fontSize'); 
					imgLayer.horizStartAlignment  = 'center'  
					imgLayer.vertStartAlignment  = 'center'  //need better way to refresh this 
					this.model.currentLayer = imgLayer; 
					event.data2 = imgLayer ; //don't like this feel like storing old layer should be automatic ...
				}
				else
				{
					imgLayer = event.data2 as ImageLayerVO; 
					imgLayer.url = event.oldData.toString() 
					imgLayer.update()
				}		
				//this.model.currentPage.updated();
				//this.model.layersChanged(); 
				this.dispatch( new EditProductCommandTriggerEvent(
					EditProductCommandTriggerEvent.IMAGE_URL_CHANGED, event, null ) ) 
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
			if ( event.type == EditProductCommandTriggerEvent.CHANGE_LAYER_COLOR  	)  
			{
				if ( event.undo == false )
				{
					//if ( event.data2 != null ) 
					//this.model.getColorLayer(event.data2 )
					colorLayer = this.model.layerColor; //this.model.currentLayer as ColorLayerVO; 
					//can specify layer  name as well
					if ( event.data2 != null && event.data2 != ''  ) 
					{
						var layerName : String = event.data2.toString()
						colorLayer = this.model.getLayerByName( layerName  ) as ColorLayerVO; 
					}
					if ( colorLayer == null ) 
					{
						trace('EditProductCommand','warning:', 
							EditProductCommandTriggerEvent.CHANGE_LAYER_COLOR, 
							'cannot set color, color layer not defined'); 
						return; 
					}
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
			
			
			
			//try to grab first face and load it 
			if ( event.type == EditProductCommandTriggerEvent.LOAD_PRODUCT ) 
			{
				if ( event.undo == false )
				{
					//event.oldData = this.model.cur
					var product : StoreItemVO = event.data as StoreItemVO; 
					var face : FaceVO = event.data2 as FaceVO //use data2 to load a specific face
					if ( face == null ) 
						face = product.faces.getItemAt( 0 ) as FaceVO
					if ( face == null ) 
						throw 'EditProductCommand', 'LOAD_PRODUCT', 'create face first' 
					
					//load in product stuff 
					
					//load in face
					this.dispatch( new EditProductCommandTriggerEvent(
						EditProductCommandTriggerEvent.LOAD_FACE, face, null ) ) 
					/*	
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
					
					//if layers are not predefied, add default, for testing purposes 
					if ( product.layers  == null )
					{
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
					else //add from layers 
					{
					//disable adding undos 
					this.model.blockUndoAdding = true; 
					
					if ( product.image_color_overlay != null &&  product.image_color_overlay != ''  ) 
					{
					colorLayer  = new ColorLayerVO(); 
					colorLayer.name = 'Color Base Image';
					colorLayer.url = product.image_color_overlay; 
					colorLayer.locked = true; 
					colorLayer.showInList = false; 
					this.model.addLayer( colorLayer ) ;
					if ( event.firstTime ) 
					{
					colorLayer.x = 0; 
					colorLayer.y = 100; 
					}
					this.model.layerColor = colorLayer; 
					}		
					
					
					for each ( layer in product.layers ) 
					{
					if ( layer is ImageLayerVO ) 
					{
					imgLayer = layer as ImageLayerVO
					this.dispatch( new EditProductCommandTriggerEvent(
					EditProductCommandTriggerEvent.ADD_IMAGE_LAYER, imgLayer.url ) ) ; 
					}
					if ( layer is TextLayerVO ) 
					{
					txtLayer = layer as TextLayerVO
					this.dispatch( new EditProductCommandTriggerEvent(
					EditProductCommandTriggerEvent.ADD_TEXT_LAYER, txtLayer.text ) ) ; 
					}								
					}	
					
					if ( product.image_mask !=null && product.image_mask != ''   ) 
					{
					//use mask layer as well ..
					imgLayer = new ImageLayerVO(); 
					imgLayer.name = 'Mask  Image';
					imgLayer.url = product.image_mask; 
					//imgLayer.url = 'assets/images/img.jpg'
					imgLayer.locked = true; 
					imgLayer.showInList = false; 
					imgLayer.mask = true; 
					this.model.addLayer( imgLayer ) ;
					//	this.model.currentLayer = imgLayer; 
					this.model.layerMask = imgLayer; 
					}	
					
					this.model.blockUndoAdding = false; 
					
					}
					}
					this.model.undo.clearAll(); 
					this.model.layersChanged(); */
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
					EditProductCommandTriggerEvent.PRODUCT_LOADED, event, null ) ) 
			}
			
			
			//try to grab first face and load it 
			if ( event.type == EditProductCommandTriggerEvent.LOAD_FACE ) 
			{
				undoable = false 
				if ( event.undo == false )
				{
					
					//event.oldData = this.model.cur
					face  = event.data as FaceVO
					if ( face == null ) 
						throw 'EditProductCommand', 'LOAD_FACE', 'face is null'// face first' 
					this.model.currentFace  = face; 
					//load in product stuff 
					//maybe save layers on the face?...
					//this.model.layers.removeAll();
					/*this.model.layers.source = face.layers.source; 
					this.model.layers.refresh(); */
					this.model.baseLayer = null; 
					this.model.layerMask = null; 
					this.model.layerColor = null; 
					this.model.waitForBaseLayer = [] 
					this.model.layers = face.layers; 
					var dbg : Array = [this.model.layers.length, this.model.layers.toArray() ] 
					//no need to remove? ... no b/c no is allowed to bind to thise, they bind to layersVisible...
					//reset masking ...					
					var v : viewer2_store = this.model.viewer as viewer2_store
					if ( v != null ) //the first time it might not have been set yet
					{	
						v.workspace.mask = null;//v.maskLayer_
						v.maskBg.alpha = this.model.currentFace.image_mask_alpha; 
					}
					if ( face.imported ) 
					{
						//no need to import again
						
						
						for each ( layer in face.layers.toArray() ) 
						{
							if ( layer is ImageLayerVO ) 
							{
								imgLayer = layer as ImageLayerVO
								if ( imgLayer.mask == true ) 
									this.model.layerMask = layer; 
							}
							if ( layer is ColorLayerVO ) 
							{
								colorLayer = layer as ColorLayerVO
								this.model.layerColor = layer as ColorLayerVO; 
							}
							if ( layer is ImageLayerVO ) 
							{
								imgLayer = layer as ImageLayerVO
								if ( imgLayer.name == 'Base Image' ) //this is  not safe ..
									this.model.baseLayer = imgLayer; 
							}
						}	
						
						
					}
					else
					{
						
						this.model.baseLayer = null; 
						if ( face.base_image_url != null ) 
						{
							imgLayer = new ImageLayerVO(); 
							imgLayer.name = 'Base Image';
							imgLayer.base_layer = true; 
							imgLayer.url = face.base_image_url; 
							imgLayer.locked = true; 
							imgLayer.showInList = false; 
							this.model.addLayer( imgLayer ) ;
							/*if ( event.firstTime ) 
							{
							imgLayer.x = 0; 
							imgLayer.y = 100; 
							}*/
							//this.model.currentLayer = imgLayer; 
							this.model.baseLayer = imgLayer; 
						}	
						//if layers are not predefied, add default, for testing purposes 
						if ( face.layersToImport  == null )// || face.layersToImport.length == 0  )
						{
							var colorLayer : ColorLayerVO = new ColorLayerVO(); 
							colorLayer.name = 'Color Base Image';
							colorLayer.url = face.base_image_url; 
							colorLayer.locked = true; 
							colorLayer.showInList = false; 
							this.model.addLayer( colorLayer ) ;
							/*if ( event.firstTime ) 
							{
							colorLayer.x = 0; 
							colorLayer.y = 100; 
							}*/
							this.model.layerColor = colorLayer; 
							
							//order doesn't matter as it doesn't appear ...
							imgLayer = new ImageLayerVO(); 
							imgLayer.name = 'Mask  Image';
							imgLayer.url = face.base_image_url; 
							//imgLayer.url = 'assets/images/img.jpg'
							imgLayer.locked = true; 
							imgLayer.showInList = false; 
							imgLayer.mask = true; 
							this.model.addLayer( imgLayer ) ;
							/*if ( event.firstTime ) 
							{
							imgLayer.x = 0; 
							imgLayer.y = 100; 
							}*/
							//	this.model.currentLayer = imgLayer; 
							this.model.layerMask = imgLayer; 
							
							//this.model.currentLayer = colorLayer; 
						}
						else //add from layers 
						{
							//disable adding undos 
							this.model.blockUndoAdding = true; 
							
							if ( face.image_color_overlay != null &&  face.image_color_overlay != ''  ) 
							{
								colorLayer  = new ColorLayerVO(); 
								colorLayer.name = 'Color Base Image';
								colorLayer.url = face.image_color_overlay; 
								colorLayer.locked = true; 
								colorLayer.showInList = false; 
								this.model.addLayer( colorLayer ) ;
								/*if ( event.firstTime ) 
								{
								colorLayer.x = 0; 
								colorLayer.y = 100; 
								}*/
								this.model.layerColor = colorLayer; 
							}		
							
							
							if ( face.image_mask !=null && face.image_mask != ''   ) 
							{
								//use mask layer as well ..
								imgLayer = new ImageLayerVO(); 
								imgLayer.name = 'Mask  Image';
								imgLayer.url = face.image_mask; 
								//imgLayer.url = 'assets/images/img.jpg'
								imgLayer.locked = true; 
								imgLayer.showInList = false; 
								imgLayer.mask = true; 
								this.model.addLayer( imgLayer ) ;
								//	this.model.currentLayer = imgLayer; 
								this.model.layerMask = imgLayer; 
							}	
							
							
							for each ( layer in face.layersToImport ) 
							{
								this.importLayer(layer); 
								if ( layer is ImageLayerVO ) 
								{
									imgLayer = layer as ImageLayerVO
									this.dispatch( new EditProductCommandTriggerEvent(
										EditProductCommandTriggerEvent.ADD_IMAGE_LAYER, imgLayer ) ) ; 
								}
								if ( layer is TextLayerVO ) 
								{
									txtLayer = layer as TextLayerVO
									this.dispatch( new EditProductCommandTriggerEvent(
										EditProductCommandTriggerEvent.ADD_TEXT_LAYER, txtLayer ) ) ; 
								}	
								if ( layer is ColorLayerVO ) 
								{
									colorLayer = layer as ColorLayerVO
									colorLayer = colorLayer.clone() as ColorLayerVO ; 
									this.model.addLayer( colorLayer )
								}	
							}	
							
							this.model.blockUndoAdding = false; 
							
						}
						face.imported = true
					}
					dbg  = [this.model.layers.length, this.model.layers.toArray() ] 
					this.model.undo.clearAll(); 
					this.model.recreateDisplayableLayers(); 
					this.model.currentLayer = this.model.getNextLayer()
					//this.model.layersChanged(); 
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
					EditProductCommandTriggerEvent.FACE_LOADED, event, null ) ) 
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
					/*	if ( layer.x == event.data && layer.y == event.data2 ) 
					return; */
					if ( event.data3 != null ) 
						layer = event.data3 as LayerBaseVO
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
					//specific target laery is store on 3
					if ( event.data3 != null ) 
						layer = event.data3 as LayerBaseVO
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
			
			if ( event.type == EditProductCommandTriggerEvent.ROTATE_LAYER ) 
			{
				if ( event.undo == false )
				{
					layer = this.model.currentLayer as LayerBaseVO; 
			 
					if ( event.data3 != null ) 
						layer = event.data3 as LayerBaseVO
					event.oldData = layer.rotation; 
					this.model.blockUndos=true
					layer.rotation = Number( event.data )
					layer.update(); 
					event.data3 = layer ; 
					this.model.blockUndos=false
					//trace('go', event.data, event.data2 )
				}
				else
				{
					this.model.blockUndos=true
					layer = event.data3 as LayerBaseVO; 
					layer.rotation = Number( event.oldData )
					layer.update(); 
					//trace('redo', event.data, event.data2 )
					this.model.blockUndos=false
				}		
				this.dispatch( new EditProductCommandTriggerEvent(
					EditProductCommandTriggerEvent.LAYER_ROTATED, event, null ) ) 
			}	
			
			
			if ( event.type == EditProductCommandTriggerEvent.REMOVE_LAYER ) 
			{
				if ( event.undo == false )
				{
					layer = event.data as LayerBaseVO; 
					var layerIndex : int = this.model.layers.getItemIndex( layer ) ; 
					
					//var nextLayerIndex : int = layerIndex+1
					
					if ( layer.prompt_layer == true && 
						this.model.currentFace.can_remove_prompt_layers == false ) 
					{
						layer.visible = false; 
						layer.update(); 
						//return;
					}		
					else
					{
						this.model.removeLayer( layer ) ; 
						layer.layerRemoved()
					}
					//if ( nextLayerIndex >= this.model.layers.length ) 
					//	nextLayerIndex = 0
					//var nextLayer : LayerBaseVO = this.model.layers.getItemAt(   nextLayerIndex) as LayerBaseVO;
					var nextLayer : LayerBaseVO =  this.model.getNextLayer() ;
					this.model.currentLayer =nextLayer
				}
				else
				{
					layer = event.data as LayerBaseVO; 
					if ( layer.prompt_layer == true && 
						this.model.currentFace.can_remove_prompt_layers == false ) 
					{
						layer.visible = true; 
						layer.update(); 
						this.model.currentLayer = layer; 
						return;
					}		
					else
					{
						this.model.addLayer( layer ) ; 
						this.model.currentLayer = layer; 
					}
					//layer.update(); 
				}		
				//this.model.currentPage.updated();
				this.model.layersChanged(); 
				this.dispatch( new EditProductCommandTriggerEvent(
					EditProductCommandTriggerEvent.LAYER_REMOVED, event, null ) ) 
			}	
			
			if ( event.firstTime && undoable && this.model.blockUndoAdding == false) 
			{
				var lastUndo : EditProductCommandTriggerEvent = this.model.lastUndo
				if ( lastUndo != null && lastUndo.type == event.type ) 
				{
					if ( event.type == EditProductCommandTriggerEvent.MOVE_LAYER
						&& event.data3 == lastUndo.data3) //check for time
					{
						if ( debugUndos ) trace('merging', event, event.type); 
						this.model.lastUndo.data = event.data; 
						this.model.lastUndo.data2 = event.data2
						//this.model.lastUndo.time = new Date()
						return; 
					}
					if ( event.type == EditProductCommandTriggerEvent.RESIZE_LAYER
						&& event.data3 == lastUndo.data3) //check for time
					{
						if ( debugUndos ) trace('merging', event, event.type); 
						this.model.lastUndo.data = event.data; 
						this.model.lastUndo.data2 = event.data2
						//this.model.lastUndo.time = new Date()
						return; 
					}
				}
				if ( debugUndos )   trace('addeded one', event.type)
				this.model.lastUndo = event; 
				this.model.undo.pushUndo( event ) ;
				this.dispatch( new NightStandModelEvent(NightStandModelEvent.UNDOS_CHANGED) ) 
			}
		}
		
		/***
		 * Store import x's for later
		 * */
		private function importLayer(layer:LayerBaseVO):void
		{
			if ( !  isNaN( layer.x ) )
			{
				layer.importX = layer.x;
				layer.horizStartAlignment = ''; 
			}
			if ( !  isNaN( layer.y ) )
			{
				layer.importY = layer.y;
				layer.horizStartAlignment = ''; 
			}
			
		}		
		
	}
}