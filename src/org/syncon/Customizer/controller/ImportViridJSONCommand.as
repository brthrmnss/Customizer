package  org.syncon.Customizer.controller
{
	import com.adobe.serialization.json.JSON;
	
	import org.robotlegs.mvcs.Command;
	import org.syncon.Customizer.model.NightStandModel;
	import org.syncon.Customizer.model.ViridConstants;
	import org.syncon.Customizer.vo.FaceVO;
	import org.syncon.Customizer.vo.ImageLayerVO;
	import org.syncon.Customizer.vo.LayerBaseVO;
	import org.syncon.Customizer.vo.StoreItemVO;
	import org.syncon.Customizer.vo.TextLayerVO;
	
	
	
	public class ImportViridJSONCommand extends Command
	{
		[Inject] public var model:NightStandModel;
		[Inject] public var event:ImportViridJSONCommandTriggerEvent;
		
		
		
		override public function execute():void
		{
			if ( event.type == ImportViridJSONCommandTriggerEvent.IMPORT_JSON ) 
			{
				this.importProduct()
				
			}	
			
			
		}
		
		
		private function importProduct():void
		{
			event.str;
			var json:Object = JSON.decode(event.str);
			trace();	
			var product:StoreItemVO = new StoreItemVO;
			product.name = json.name;
			
			for each( var faceImport:Object in json.Faces  )
			{
				var face : FaceVO = new FaceVO()
				product.faces.addItem( face ) 
				face.base_image_url = faceImport.image
				for each(var layerImport:Object in faceImport.Layers)
				{
					
					
					if(layerImport.type == "color")
					{
						face.color_overlay_layer = layerImport.Media.source;
					}
					else if(layerImport.type == "image")
					{
						var imageLayer: ImageLayerVO = new ImageLayerVO;
						imageLayer.url = layerImport.Media.source;
						face.layersToImport.push(imageLayer);
					}
					else if(layerImport.type == "monogram" || layerImport.type == "engrave")
					{
						var textLayer: TextLayerVO = new TextLayerVO;
						
						textLayer.subType = ViridConstants.SUBTYPE_ENGRAVE;
						textLayer.locked = true;
						this.copyBasics(textLayer, layerImport );
						textLayer.text = 'Add Text' 
						textLayer.name = layerImport.name;
						textLayer.width = layerImport.transform.width;
						textLayer.height = layerImport.transform.height;
						textLayer.x = layerImport.transform.x;
						textLayer.y = layerImport.transform.y;
						textLayer.maxChars = layerImport.Media.max;
						
						textLayer.orientation = layerImport.orientation;
						
						
						textLayer.fontSize = 20//for engraving
						
						if(layerImport.type == "engrave"){						
							textLayer.sizingSettings = TextLayerVO.SIZING_AUTO_SIZE; //'get smaller' 
							textLayer.maxFontSize = 35
							textLayer.minFontSize = 12
						}
						
						textLayer.prompt_layer = true; 
						textLayer.required = layerImport.required;
						
						textLayer.text = layerImport.Media.source;
						face.layersToImport.push(textLayer);
						
					}
					else if(layerImport.type == "text")
					{
						var textLayer: TextLayerVO = new TextLayerVO;
						textLayer.text = layerImport.Media.source;
						face.layersToImport.push(textLayer);
					}
					else if(layerImport.type == "clipart")
					{
						imageLayer  = new ImageLayerVO;
						imageLayer.url = layerImport.Media.source;
						face.layersToImport.push(imageLayer);
					}
				}
			}
			
			this.model.baseItem = product;
			
		}
		
		private function copyBasics(layer:LayerBaseVO, layerImport:Object):void
		{
			// TODO Auto Generated method stub
			layer.name = layerImport.name; 
			layer.cost = layerImport.price; 
			if ( layerImport.hasOwnProperty( 'required' ) ) 
				layer.required = layerImport.required
		}
		
	}
}