package  org.syncon.Customizer.controller
{
	import com.adobe.serialization.json.JSON;
	
	import mx.controls.Alert;
	import mx.controls.Image;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.robotlegs.mvcs.Command;
	import org.syncon.Customizer.model.NightStandModel;
	import org.syncon.Customizer.model.ViridConstants;
	import org.syncon.Customizer.vo.ColorLayerVO;
	import org.syncon.Customizer.vo.FaceVO;
	import org.syncon.Customizer.vo.ImageLayerVO;
	import org.syncon.Customizer.vo.LayerBaseVO;
	import org.syncon.Customizer.vo.TextLayerVO;
	
	
	
	public class ExportJSONCommand extends Command
	{
		[Inject] public var model:NightStandModel;
		[Inject] public var event:ExportJSONCommandTriggerEvent;
		
		private var service:HTTPService;
		private var finalJSON:String;		
		override public function execute():void
		{
			if ( event.type == ExportJSONCommandTriggerEvent.EXPORT_JSON ) 
			{
				//this.loadSound()
				//trace('bigbing');
				var product:Object = new Object;
				var Faces:Array = new Array;
				var Face:Object;
				var layers:Array = new Array;
				
				product.name = this.model.baseItem.name;
				this.model.baseItem.faces;
				product.sku = this.model.baseItem.sku;
				
				
				//just dealign with one face at the moment

				for each(var Surface:FaceVO in this.model.baseItem.faces){
					
					Face = new Object;
					Face.name = Surface.name;
					Face.image = Surface.base_image_url;
					Face.mask = Surface.image_mask;
					
					for each( var layer: LayerBaseVO in this.model. layersVisible){
						
						var jsonLayer:Object = {};
						var jsonMedia:Object = {};
						var jsonTransform:Object = {};
						var jsonFonts:Object = null;
						
						
						jsonLayer.name = layer.name;
						jsonLayer.type = layer.type;
						if(layer.name == "color")
							jsonLayer.type = "color";
						jsonLayer.price = layer.cost;
						
						jsonMedia.source = layer.url;
						jsonMedia.type = layer.type;
						
						jsonTransform.x = layer.x;
						jsonTransform.y = layer.y;
						jsonTransform.width = layer.width;
						jsonTransform.height = layer.height;
						jsonTransform.rotation = layer.rotation.toFixed(2);
						jsonLayer.orientation = "default";
						
						if(layer.type == TextLayerVO.Type)
						{
							var textLayer :  TextLayerVO = layer as TextLayerVO; 
							jsonLayer.fontFamily = textLayer.fontFamily;
							if(layer.subType == ViridConstants.SUBTYPE_ENGRAVE)
							{
								//engrave layer
								textLayer.fontFamily; 
								textLayer.fontSize
							}
							else
							{
								//design text layer	
							
							}
						}
						if(layer.type == ImageLayerVO.Type)
						{
							var imgLayer : ImageLayerVO = layer as ImageLayerVO;
							if(imgLayer.mask == true)
								continue;
							if(imgLayer.image_source == ViridConstants.IMAGE_SOURCE_CLIPART)
							{
								//engrave layer
								
							}
							else if(imgLayer.image_source == ViridConstants.IMAGE_SOURCE_UPLOAD)
							{
								//design text layer	
								
							}
						}
						if(layer.type == ColorLayerVO.Type)
						{
							
						}
						jsonLayer.Media = jsonMedia;
						jsonLayer.Fonts = jsonFonts;
						
						jsonLayer.transform = jsonTransform;
						
						//grab content or specific information off of this layer
						if(layer.type == "TEX"){//TODO: Check subtype for engrave|monogram
							product.type = "engrave";
							var nlayer:TextLayerVO = layer as TextLayerVO;
							jsonLayer.text = nlayer.text;
						}
						layers.push(jsonLayer);
						
					}
					Face.Layers = layers;
					Faces.push(Face);
					product.Faces = Faces;
				}
				
				
				
				var exportObj:Object = new Object;
				
				if(product.type == "engrave"){
					exportObj['ACTION'] = "engrave";
					exportObj['PRODUCTID'] = this.model.baseItem.sku;
					exportObj['FONT'] = this.model.currentLayer;
					try{
					exportObj['TEXT1'] = product.Faces[0].Layers[0].text;
					}catch(e:Error){};
					try{
					exportObj['TEXT2'] = product.Faces[0].Layers[1].text;
					}catch(e:Error){};
					try{
						exportObj['TEXT3'] = product.Faces[1].layer[0].text;
					}catch(e:Error){};
					try{
						exportObj['TEXT4'] = product.Faces[1].layer[1].text;
					}catch(e:Error){};
					
					
	
					
				}
				
				//var exportThis:Object = JSON.encode(exportObj);
				//finalJSON = exportThis;
				trace( exportObj['TEXT1'] );//product.layer);
				for ( var prop: Object in exportObj ) 
				{
					trace( prop, exportObj[prop]  )
				}
				service = new HTTPService();
				service.url = "../save.aspx";
				service.method = "POST";
				service.resultFormat = "text";
				service.addEventListener(ResultEvent.RESULT,httpResult);
				service.addEventListener(FaultEvent.FAULT, httpFault);
				service.send(exportObj);
				
			}				
			
		}
		
		protected function httpResult(event:ResultEvent):void
		{
			Alert.show( event.result.toString() + finalJSON);
			
		}
		
		protected function httpFault(event:FaultEvent):void
		{
			Alert.show(event.fault.faultString);
			
		}
		/*		
		private function loadSound():void
		{
			
		}*/
		
		
	}
}