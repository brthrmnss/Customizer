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
			product.name = json.name + "  |";
			this.model.tempsku = json.sku; 
			if(json.hasOwnProperty( 'price' )) 
				product.price = json.price;
			else
				product.price = 0;
			for each( var faceImport:Object in json.Faces  )
			{
				var face : FaceVO = new FaceVO()
				product.faces.addItem( face ) 
				face.base_image_url = faceImport.image
				for each(var layerImport:Object in faceImport.Layers)
				{
					
					
					if(layerImport.type == "color")
					{
						//this.copyBasics(face.color_overlay_layer, layerImport );
						face.color_overlay_layer = layerImport.Media.source;
						
					}
					else if(layerImport.type == "image")
					{
						var imageLayer: ImageLayerVO = new ImageLayerVO;
						
						imageLayer.prompt_layer = true; 
						imageLayer.locked = true;
						
						imageLayer.url = layerImport.Media.source;
						this.copyBasics(imageLayer, layerImport );
						
						face.layersToImport.push(imageLayer);
						
						
					}
					else if(layerImport.type == "monogram" || layerImport.type == "engrave")
					{
						var textLayer: TextLayerVO = new TextLayerVO;
						
						textLayer.prompt_layer = true; 
						textLayer.locked = true;
						textLayer.subType = ViridConstants.SUBTYPE_ENGRAVE;
						
						this.copyBasics(textLayer, layerImport );
						textLayer.text = layerImport.Media.source;
						textLayer.maxChars = layerImport.Media.max
						textLayer.orientation = layerImport.orientation;
						textLayer.fontSize = layerImport.Fonts[0].size;//for engraving
							
						
						if(layerImport.type == "engrave"){						
							textLayer.sizingSettings = TextLayerVO.SIZING_AUTO_SIZE; //'get smaller' 
							textLayer.maxFontSize = 35
							textLayer.minFontSize = 8
						}
						
						textLayer.vertStartAlignment="";
						textLayer.horizStartAlignment="";
						
						textLayer.text = layerImport.Media.source;
						
						face.layersToImport.push(textLayer);
						
					}
					else if(layerImport.type == "text")
					{
						var textLayer: TextLayerVO = new TextLayerVO;

						this.copyBasics(textLayer, layerImport );
						
						textLayer.prompt_layer = true; 

						this.copyBasics(textLayer, layerImport );
						textLayer.text = 'AAA' ;
						textLayer.maxChars = layerImport.Media.max
						textLayer.orientation = layerImport.orientation;
						textLayer.fontSize = 20//for engraving
							
						textLayer.text = layerImport.Media.source;
						
						face.layersToImport.push(textLayer);
						
					}
					else if(layerImport.type == "clipart")
					{
						imageLayer  = new ImageLayerVO;
						
						this.copyBasics(textLayer, layerImport );
						imageLayer.prompt_layer = true; 
						
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
			if( layerImport.hasOwnProperty( 'name' )  )
				layer.name = layerImport.name; 
			if( layerImport.hasOwnProperty( 'price' )  )
				layer.cost = layerImport.price; 
			if ( layerImport.hasOwnProperty( 'required' ) ) 
				layer.required = layerImport.required
			if( layerImport.transform.hasOwnProperty( 'width' )  )		
				layer.width = layerImport.transform.width;
			if( layerImport.transform.hasOwnProperty( 'height' )  )
				layer.height = layerImport.transform.height;
			if( layerImport.transform.hasOwnProperty( 'x' )  )
				layer.x = layerImport.transform.x;
			if( layerImport.transform.hasOwnProperty( 'y' )  )
				layer.y = layerImport.transform.y;
			if( layerImport.transform.hasOwnProperty( 'required' )  )
				layer.required = layerImport.required;
		}
		
	}
}