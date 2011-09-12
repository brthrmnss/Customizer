package  org.syncon.Customizer.controller
{
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.ProgressEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
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
	
	import spark.effects.interpolation.RGBInterpolator;
	
	
	
	public class ExportJSONCommand extends Command
	{
		[Inject] public var model:NightStandModel;
		[Inject] public var event:ExportJSONCommandTriggerEvent;
		
		private var service:HTTPService;
		private var finalJSON:String;		
		private var gotoNextStep:Boolean = false;
		override public function execute():void
		{
			if ( event.type == ExportJSONCommandTriggerEvent.EXPORT_JSON ) 
			{
				if(event.url == "gotoNextStep"){
					gotoNextStep = true;
					
				}
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
					layers = new Array();
					Face.name = Surface.name;
					Face.image = Surface.base_image_url;
					Face.mask = Surface.image_mask;
					
					for each( var layer: LayerBaseVO in Surface.layers){
						if(layer.name == "Base Image")
							continue;						
						if(layer.name == 'Base Layer')
							continue;
						/*if(!layer.visible)
							continue;*/
						var jsonLayer:Object = {};
						var jsonMedia:Object = {};
						var jsonTransform:Object = {};
						var jsonFonts:Object = null;
						
						
						jsonLayer.name = layer.name;
						jsonLayer.type = layer.type;
						jsonLayer.price = layer.cost;
						
						jsonMedia.source = layer.url;
						jsonMedia.type = layer.type;
						///TODO: Why is this next part necessary -23 x - 13.5
						jsonTransform.x = layer.x -23;
						jsonTransform.y = layer.y - 13.5;
						jsonTransform.width = layer.width;
						jsonTransform.height = layer.height;
						jsonTransform.rotation = layer.rotation.toFixed(2);
						jsonLayer.orientation = "default";
						

						if(layer.type == TextLayerVO.Type)
						{		
					
							//convert to text layer
							var textLayer:TextLayerVO = layer as TextLayerVO;
							jsonLayer.text = textLayer.text;///remove
							if( textLayer.text == "" )
								continue;		
							//only if we have content

 							jsonMedia.source = textLayer.text;
							jsonMedia.font = textLayer.fontFamily;
							jsonMedia.fontsize = textLayer.fontSize;
							if(textLayer.color != null )
								jsonMedia.color = String(textLayer.color.toString(16));
							else
								jsonMedia.color = '';
							while( jsonMedia.color.length < 6 )
								jsonMedia.color = '0' + jsonMedia.color;
							
							
							
							
							jsonLayer.fontFamily = textLayer.fontFamily;								//engrave layer
								textLayer.fontFamily; //remove
								textLayer.fontSize //remove
							if(layer.subType == ViridConstants.SUBTYPE_ENGRAVE)
							{
								product.type = "engrave";
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
							if(imgLayer.name == 'Base Layer')
								continue;
							if(imgLayer.url == "")
								continue;
							
							jsonMedia.source = imgLayer.url;
							if(imgLayer.image_source == ViridConstants.IMAGE_SOURCE_CLIPART)
							{
								jsonMedia.type ='clipart';
								
							}
							else if(imgLayer.image_source == ViridConstants.IMAGE_SOURCE_UPLOAD)
							{
								jsonMedia.type ='photo';								
							}
						}
						if(layer.type == ColorLayerVO.Type)
						{
							var colorLayer : ColorLayerVO = layer as ColorLayerVO;
							jsonLayer.type = "color";
							//jsonMedia.color = (colorLayer.color,'000000');
							jsonMedia.source = String(colorLayer.color.toString(16));
							while( jsonMedia.source.length < 6 )
							{
								jsonMedia.source = '0' + jsonMedia.source;
							}
							if( jsonMedia.source == "" )
								jsonMedia.source = 'ffffff';
							jsonLayer.color = jsonMedia.source; //because the backed was built to listen to jsonLayer.color - would love to remove this

						}
						
						
						jsonLayer.Media = jsonMedia;
						//jsonLayer.Fonts = jsonFonts;
						jsonLayer.transform = jsonTransform;

						layers.push(jsonLayer);
						
					}
					Face.Layers = layers;
					Faces.push(Face);
					
				}
				product.Faces = Faces;
				
				
				var exportObj:Object = new Object;
				
				if(product.type == "engrave"){
					exportObj['ACTION'] = "engrave";
					exportObj['PRODUCTID'] = this.model.baseItem.sku;
					try{
					exportObj['FONT'] = product.Faces[0].Layers[0].fontFamily;
					}catch(e:Error){};
					try{
					exportObj['TEXT1'] = product.Faces[0].Layers[0].text;
					}catch(e:Error){};
					try{
					exportObj['TEXT2'] = product.Faces[0].Layers[1].text;
					}catch(e:Error){};
					try{
						exportObj['TEXT3'] = product.Faces[1].Layers[0].text;
					}catch(e:Error){};
					try{
						exportObj['TEXT4'] = product.Faces[1].Layers[1].text;
					}catch(e:Error){};
					
					trace( exportObj['TEXT1'] );//product.layer);
					for ( var prop: Object in exportObj ) 
					{
						trace( prop, exportObj[prop]  )
					}
					service = new HTTPService();
					service.url = "../save.aspx";
					service.method = "POST";
					service.resultFormat = "text";
					service.addEventListener(ResultEvent.RESULT,saveResult);
					service.addEventListener(FaultEvent.FAULT, httpFault);
					service.send(exportObj);
					
				}
				else
				{
					var exportThis:Object = JSON.encode(product);
					/*exportObj['ACTION'] = "engrave";
					exportObj['PRODUCTID'] = this.model.baseItem.sku;
					exportObj['LAYERS'] = JSON.decode(product.Faces); */
					
					service = new HTTPService();
					service.url = "../save.aspx";
					service.method = "POST";
					service.contentType="application/json";
					service.resultFormat = HTTPService.RESULT_FORMAT_TEXT;
					service.addEventListener(ResultEvent.RESULT,saveResult);
					service.addEventListener(FaultEvent.FAULT, httpFault);
					service.send(exportThis);
				}

				
			}	
			
			
			if ( event.type == ExportJSONCommandTriggerEvent.EXPORT_NEW_IMAGE ) 
			{
				

			
				
				imgLayer = this.model.currentLayer as ImageLayerVO; 
				//trace('layer_image_item_renderer', 'source', imgLayer.source ) ;
				imgLayer.source;
				
				
				var req:URLRequest = new URLRequest();
				req.method = URLRequestMethod.POST;
				req.data = imgLayer.source;
				req.contentType='application/octet-stream';
				req.url = "/customize/save_image.aspx";
				
				var loader:URLLoader = new URLLoader;
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				
				loader.addEventListener(FaultEvent.FAULT,httpFault);
				loader.addEventListener(Event.COMPLETE,imageUploadResult);
				loader.addEventListener(HTTPStatusEvent.HTTP_STATUS,uploadResult);
				loader.load(req);				
				
				/*
				var req:HTTPService = new HTTPService();
				req.method = URLRequestMethod.POST;
				req.contentType='application/octet-stream';
				req.url = "/customize/save_image.aspx";				
				req.resultFormat = HTTPService.RESULT_FORMAT_TEXT;
				req.addEventListener(ResultEvent.RESULT,saveResult);
				req.addEventListener(FaultEvent.FAULT, httpFault);
				req.send(imgLayer.source);
				*/
				
			}
			
		}
		

		
		protected function uploadResult(event:HTTPStatusEvent):void
		{
			//Alert.show( event.status.toString() );
			//Alert.show( event..toString() );
		}
		
		protected function imageUploadResult(event:Event):void
		{
			var loader:URLLoader = URLLoader(event.target);
			var resp:Object = JSON.decode(loader.data);
			//Alert.show(loader.data);
			//Alert.show(resp.toString() );
			//Alert.show('test')
			if(resp.hasOwnProperty('SUCCESS') ){
				if(resp.SUCCESS == "true" && resp.hasOwnProperty('imageurl'))
					this.model.currentLayer.url = resp.imageurl;
			}
		}		
		
		
		
		protected function saveResult(event:ResultEvent):void
		{
			//Alert.show( event.result.toString() + finalJSON);
			if(gotoNextStep)
			{
				Alert.show('saved...');
				if(ExternalInterface.available)
				{
					ExternalInterface.call('navigateToNextStep');	
				}
			}
			
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