package  org.syncon.Customizer.controller
{
	import com.adobe.serialization.json.JSON;
	
	import org.robotlegs.mvcs.Command;
	import org.syncon.Customizer.model.NightStandModel;
	import org.syncon.Customizer.vo.ImageLayerVO;
	import org.syncon.Customizer.vo.LayerBaseVO;
	import org.syncon.Customizer.vo.ProductVO;
	import org.syncon.Customizer.vo.StoreItemVO;
	import org.syncon.Customizer.vo.TextLayerVO;
	
	
	
	public class ImportJSONCommand extends Command
	{
		[Inject] public var model:NightStandModel;
		[Inject] public var event:ImportJSONCommandTriggerEvent;
		
		
		
		override public function execute():void
		{
			if ( event.type == ImportJSONCommandTriggerEvent.IMPORT_JSON ) 
			{
				event.str;
				var json:Object = JSON.decode(event.str);
				trace();	
				var product:StoreItemVO = new StoreItemVO;
				product.name = json.name;
				
				for each( var faceImport:Object in json.Faces  ){
					product.base_image_url = faceImport.image
					for each(var layerImport:Object in faceImport.Layers){
						if(layerImport.type == "color"){
							product.color_overlay_layer = layerImport.Media.source;
						}
						else if(layerImport.type == "image"){
							var imageLayer: ImageLayerVO = new ImageLayerVO;
							imageLayer.url = layerImport.Media.source;
							product.layers.push(imageLayer);
						}
						else if(layerImport.type == "text"){
							var textLayer: TextLayerVO = new TextLayerVO;
							textLayer.text = layerImport.Media.source;
							product.layers.push(textLayer);
						}
						else if(layerImport.type == "clipart"){
							var imageLayer: ImageLayerVO = new ImageLayerVO;
							imageLayer.url = layerImport.Media.source;
							product.layers.push(imageLayer);
						}
					}
				}
				
				this.model.baseItem = product;
				
			}	
			
			
		}
/*		
		private function loadSound():void
		{
			
		}*/
		
		
	}
}