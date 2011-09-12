package  org.syncon.Customizer.controller
{
	import com.adobe.serialization.json.JSON;
	
	import org.robotlegs.mvcs.Command;
	import org.syncon.Customizer.model.NightStandModel;
	import org.syncon.Customizer.model.ViridConstants;
	import org.syncon.Customizer.vo.ColorLayerVO;
	import org.syncon.Customizer.vo.FaceVO;
	import org.syncon.Customizer.vo.FontVO;
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
			
			product.sku = json.sku; 
			if(json.hasOwnProperty( 'price' )) 
				product.price = json.price;
			else
				product.price = 0;
			for each( var faceImport:Object in json.Faces  )
			{
				var face : FaceVO = new FaceVO()
				face.name = faceImport.name;
				/*if ( faceImport.image.indexOf( '/customize/' ) == 0 ) 
				faceImport.image = faceImport.image.replace('/customize/', ''  ) ;*/
				face.base_image_url = faceImport.image;
				
				face.image_mask_alpha = .9;
				///face.base_image_url = 'assets/images/imgbase.png'
				if(faceImport.mask == null || faceImport.mask == "null")
					face.image_mask ="";
				else
					face.image_mask = faceImport.mask;
				
				product.faces.addItem( face );
				face.layersToImport = []; 
				for each(var layerImport:Object in faceImport.Layers)
				{
					
					//continue; 
					if(layerImport.type == "color")
					{
						//this.copyBasics(face.color_overlay_layer, layerImport );
						face.color_overlay_layer = '0x' +layerImport.Media.color;///TODO: wth are we doing here?
						var colorLayer  : ColorLayerVO = new ColorLayerVO;
						colorLayer.name = layerImport.name;
						colorLayer.name = 'Color Layer';
						colorLayer.cost = layerImport.price;
						colorLayer.url = faceImport.mask;
						colorLayer.showInList = true;
						colorLayer.prompt_layer = true;
						colorLayer.color = '0x'+layerImport.Media.color;
						
						colorLayer.locked = true; //all masks should be locked by default 
						if ( layerImport.hasOwnProperty( 'required' ) ) 
							colorLayer.required = layerImport.required;
						
						face.layersToImport.push(colorLayer);
						
					}
					else if(layerImport.type == "image")
					{
						var imageLayer: ImageLayerVO = new ImageLayerVO;
						
						imageLayer.prompt_layer = true; 
						//imageLayer.locked = true;
						
						imageLayer.image_source = ViridConstants.IMAGE_SOURCE_UPLOAD
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
						//TODO: orientation has been removed
						textLayer.verticalText = layerImport.orientation=='vertical';
						textLayer.fontSize = layerImport.Fonts[0].size;//for engraving
						
						
						if(layerImport.type == "engrave"){						
							textLayer.sizingSettings = TextLayerVO.SIZING_AUTO_SIZE; //'get smaller' 
							textLayer.maxFontSize = 35
							textLayer.minFontSize = 8
						}
						
						//go through each font
						var fonts:Array = [];
						for each(var fontIncoming:Object in layerImport.Fonts)
						{
							var font:FontVO = new FontVO();
							font.name = fontIncoming.name;
							font.swf_name = fontIncoming.swfname;
							font.defaultSize = fontIncoming.size;
							font.weight = fontIncoming.weight;
							
							fonts.push(font);
							
						}
						textLayer.fonts = fonts;
						if(fonts.length > 0 )
							textLayer.fontFamily = ( fonts[0].swf_name != null )?fonts[0].swf_name : fonts[0].name;
						
						textLayer.vertStartAlignment="";
						textLayer.horizStartAlignment="";
						
						textLayer.text = layerImport.Media.source;

						face.layersToImport.push(textLayer);
						
					}
					else if(layerImport.type == "text")
					{
						textLayer  = new TextLayerVO;
						
						this.copyBasics(textLayer, layerImport );
						
						textLayer.prompt_layer = true; 
						this.copyBasics(textLayer, layerImport );
						//TODO: orientation has been removed
						textLayer.verticalText = layerImport.orientation=='vertical';
						textLayer.maxChars = layerImport.Media.max
						textLayer.fontSize = 20
						if( layerImport.Media.hasOwnProperty( 'color' ) && layerImport.Media.color != null && layerImport.Media.color != '' )
							textLayer.color = '0x'+layerImport.Media.color
						var fonts:Array = [];
						for each(var fontIncoming:Object in layerImport.Fonts)
						{
							var font:FontVO = new FontVO();
							font.name = fontIncoming.name;
							font.swf_name = fontIncoming.swfname;
							font.defaultSize = fontIncoming.size;
							font.weight = fontIncoming.weight;
							
							fonts.push(font);
							
						}
						textLayer.fonts = fonts;
						if(fonts.length > 0 )
							textLayer.fontFamily = ( fonts[0].swf_name != null )?fonts[0].swf_name : fonts[0].name;
						
						
						textLayer.text = layerImport.Media.source;
						
						face.layersToImport.push(textLayer);
						
					}
					else if(layerImport.type == "clipart")
					{
						imageLayer  = new ImageLayerVO;
						imageLayer.prompt_layer = true;
						
						this.copyBasics(imageLayer, layerImport );
						imageLayer.url = layerImport.Media.source;
						imageLayer.image_source = ViridConstants.IMAGE_SOURCE_CLIPART	
						if(imageLayer.url == null || imageLayer.url == "" )
							imageLayer.visible = false;
						face.layersToImport.push(imageLayer);
						
						
					}
				}
			}
			//face.layersToImport = [];
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
			if( layerImport.transform.hasOwnProperty( 'width' ) && layerImport.transform.width != null ){		
				layer.width = layerImport.transform.width;
				layer.horizStartAlignment = "";
				layer.vertStartAlignment = "";
			}
			if( layerImport.transform.hasOwnProperty( 'height' )  ){
				layer.height = layerImport.transform.height;
				layer.horizStartAlignment = "";
				layer.vertStartAlignment = "";
			}
			if( layerImport.transform.hasOwnProperty( 'x' )  ){
				layer.x = layerImport.transform.x;	
				layer.horizStartAlignment = "";
				layer.vertStartAlignment = "";
				
			}			
			if( layerImport.transform.hasOwnProperty( 'y' )  ){
				layer.y = layerImport.transform.y;
				layer.horizStartAlignment = "";
				layer.vertStartAlignment = "";
			}
			if( layerImport.transform.hasOwnProperty( 'rotation' )  )
				layer.rotation = layerImport.transform.rotation;
		}
		
	}
}