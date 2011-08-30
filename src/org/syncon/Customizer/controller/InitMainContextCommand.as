package org.syncon.Customizer.controller
{
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	import org.syncon.Customizer.model.NightStandModel;
	import org.syncon.Customizer.model.ViridConstants;
	import org.syncon.Customizer.vo.ColorLayerVO;
	import org.syncon.Customizer.vo.FaceVO;
	import org.syncon.Customizer.vo.ImageLayerVO;
	import org.syncon.Customizer.vo.ImageVO;
	import org.syncon.Customizer.vo.StoreItemVO;
	import org.syncon.Customizer.vo.TextLayerVO;
	import org.syncon2.utils.MakeVOs;
	
	/**
	 *
	 * */
	public class InitMainContextCommand extends Command
	{
		[Inject] public var model:NightStandModel;
		[Inject] public var event:InitMainContextCommandTriggerEvent;
		
		override public function execute():void
		{
			if ( event.type == InitMainContextCommandTriggerEvent.INIT ) 
			{
				this.model.showAds = event.showAds
				this.model.flex = event.flex; 
				
				if ( this.model.flex == false ) 
				{
					/*	airFeatures = new AirFeaturesClass()*/
					/*	airFeatures.disableKeyLock(); */
				}
			}
			if ( event.type == InitMainContextCommandTriggerEvent.INIT2 ) 
			{
				if ( this.model.flex == false ) 
				{
					/*AirFeaturesClass['stage'] = this.contextView.stage*/
					//airFeatures.goIntoFullscreenMode(); 
				}
			}	
 
			if ( event.type == InitMainContextCommandTriggerEvent.CREATE_CLIP_ART_LIBRARY ) 
			{
				this.createClipArtImages(); 
				
			}	
			if ( event.type == InitMainContextCommandTriggerEvent.INIT3_MAKEUP_FLEX_DATA ) 
			{
				//this.createDefaultProduct() ; 
		
				//this.createDetailedDefaultProduct();
				this.createDetailedDefaultProduct_Engrave()
				
				if ( this.model.flex ) 
				{
					
				}
			}	
			
			if ( event.type == InitMainContextCommandTriggerEvent.EXIT_APP ) 
			{
				if ( this.model.flex == false ) 
				{
				}
			}
			
			
		}
		
		private function createClipArtImages():void
		{
			var names : Array = [] ; 
			for (var i : int = 0 ; i < 150; i++ )
			{
				names.push( 'Title ' + i.toString() ) ; 
			}
			var imgs : Array = MakeVOs.makeObjs( names, ImageVO, 'name' )
			for each ( var img : ImageVO in imgs ) 
			{
				img.url = 'assets/images/img.jpg'; 
			}
			this.model.loadImages( imgs ) ; 
		}
		
		private function createDefaultProduct():void
		{
			var base : StoreItemVO = new StoreItemVO(); 
			base.name = 'Zippo'
			var face : FaceVO = new FaceVO()
			
			face.base_image_url = 'assets/images/imgbase.png'
			base.faces.addItem( face ) 
			this.model.baseItem = base; 
			
			/*var l : Array = [] ; 
			l = MakeVOs.makeObjs(['L1', 'L2'], LessonVO, 'name' )
			var lp : LessonGroupVO = new LessonGroupVO(); 
			lp.lessons = new ArrayList( l ) ; 
			//this.model.loadLessons( l ); 
			
			var firstLesson : LessonVO = lp.lessons.getItemAt( 0 ) as LessonVO
			l = MakeVOs.makeObjs(['Ls1', 'Ls2', 'Ls3'], LessonSetVO, 'name' )
			firstLesson.sets = new ArrayList( l ) ; 
			
			var set : LessonSetVO = firstLesson.sets.getItemAt( 0 ) as LessonSetVO
			l = MakeVOs.makeObjs(['dog', '2', '3','4'], LessonItemVO, 'name' )
			set.items = new ArrayList( l ) ; 					
			
			this.model.currentLessonPlan = lp ; */
		}		
		private function createDetailedDefaultProduct_Engrave():void
		{
			var base : StoreItemVO = new StoreItemVO(); 
			base.name = 'Zippo'
			base.price = 65
			var face : FaceVO = new FaceVO()
			face.name = 'Front Face'; 
			face.base_image_url = 'assets/images/imgbase.png'
			base.faces.addItem( face ) 
			
			face.image_mask = 'assets/images/imgbase.png'
			
			var colorLayer : ColorLayerVO; 
			var imageLayer: ImageLayerVO
			
			colorLayer = new ColorLayerVO;
			colorLayer.name = 'Color Layer'
			colorLayer.url ='assets/images/imgbase.png'
			//colorLayer.mask = true
			colorLayer.showInList = true;
			colorLayer.prompt_layer = true;
			colorLayer.color = 0x166571;
			colorLayer.locked = true; //all masks should be locked by default 
			face.layersToImport.push(colorLayer);
			
			var textLayer: TextLayerVO = new TextLayerVO;
			textLayer.text = 'Add' 
			textLayer.name = 'Text'
			textLayer.maxChars = 3
			textLayer.location = 'front small'; 
			/*textLayer.sizingSettings = TextLayerVO.SIZING_AUTO_SIZE; //'get smaller' 
			textLayer.maxFontSize = 35
			*/
			textLayer.width = 50
			textLayer.height =30 
			textLayer.x = 60
			textLayer.y = 120; 
			textLayer.vertStartAlignment = ''; //no necessary if you lock the layer
			textLayer.horizStartAlignment = ''
			textLayer.locked = true; 
			//textLayer.vertStartAlignment = ''; //no necessary if you lock the layer
			//textLayer.horizStartAlignment = ''
			textLayer.subType = ViridConstants.SUBTYPE_ENGRAVE
			//textLayer.minFontSize = 6
			textLayer.prompt_layer = true; 
			face.layersToImport.push(textLayer);
			
			
			textLayer = new TextLayerVO;
			textLayer.text = 'Add' 
			textLayer.name = 'Text'
			textLayer.maxChars = 3
			/*textLayer.sizingSettings = TextLayerVO.SIZING_AUTO_SIZE; //'get smaller' 
			textLayer.maxFontSize = 35
			*/
			textLayer.width = 20
			textLayer.height = 140 
			textLayer.x = 60
			textLayer.y =60; 
			textLayer.locked = true; 
			textLayer.fontSize = 35
			textLayer.location = 'front Large'; 
			textLayer.vertStartAlignment = ''; //no necessary if you lock the layer
			textLayer.horizStartAlignment = ''
			textLayer.subType = ViridConstants.SUBTYPE_ENGRAVE
			//textLayer.minFontSize = 6
			textLayer.prompt_layer = true; 
			face.layersToImport.push(textLayer);
			
			
			
			
			
			face = new FaceVO()
			face.name = 'Back Face'; 
			face.base_image_url = 'assets/images/imgbase.png'
			base.faces.addItem( face ) 
			
			face.image_mask = 'assets/images/imgbase.png'
			
			colorLayer = new ColorLayerVO;
			colorLayer.name = 'Color Layer'
			colorLayer.url ='assets/images/imgbase.png'
			//colorLayer.mask = true
			colorLayer.showInList = true;
			colorLayer.prompt_layer = true;
			colorLayer.color = 0x166571;
			colorLayer.locked = true; //all masks should be locked by default 
			face.layersToImport.push(colorLayer);
			
			textLayer = new TextLayerVO;
			textLayer.text = 'bac' 
			textLayer.name = 'Text'
			textLayer.maxChars = 3
			/*textLayer.sizingSettings = TextLayerVO.SIZING_AUTO_SIZE; //'get smaller' 
			textLayer.maxFontSize = 35
			*/
			textLayer.width = 50
			textLayer.height =30 
			textLayer.x = 60
			textLayer.y = 120; 
			textLayer.vertStartAlignment = ''; //no necessary if you lock the layer
			textLayer.horizStartAlignment = ''
			textLayer.locked = true; 
			//textLayer.vertStartAlignment = ''; //no necessary if you lock the layer
			//textLayer.horizStartAlignment = ''
			textLayer.subType = ViridConstants.SUBTYPE_ENGRAVE
			//textLayer.minFontSize = 6
			textLayer.prompt_layer = true; 
			face.layersToImport.push(textLayer);
			
			
			textLayer = new TextLayerVO;
			textLayer.text = 'Add' 
			textLayer.name = 'Text'
			textLayer.maxChars = 3
			/*textLayer.sizingSettings = TextLayerVO.SIZING_AUTO_SIZE; //'get smaller' 
			textLayer.maxFontSize = 35
			*/
			textLayer.width = 100
			textLayer.height = 50 
			textLayer.x = 60
			textLayer.y =60; 
			textLayer.locked = true; 
			textLayer.fontSize = 35
			textLayer.location = 'Back Large'; 
			textLayer.vertStartAlignment = ''; //no necessary if you lock the layer
			textLayer.horizStartAlignment = ''
			textLayer.subType = ViridConstants.SUBTYPE_ENGRAVE
			//textLayer.minFontSize = 6
			textLayer.prompt_layer = true; 
			face.layersToImport.push(textLayer);
			
			this.model.baseItem = base; 
		}
		
		private function createDetailedDefaultProduct():void
		{
			var base : StoreItemVO = new StoreItemVO(); 
			base.name = 'Zippo'
			base.price = 65
			var face : FaceVO = new FaceVO()
			face.name = 'Front Face'; 
			face.base_image_url = 'assets/images/imgbase.png'
			base.faces.addItem( face ) 
			/*
			imgLayer = new ImageLayerVO(); 
			imgLayer.name = 'Mask Image';
			imgLayer.url = face.base_image_url; 
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
			*/
			
			face.image_mask = 'assets/images/imgbase.png'
			//just have to get it to the mask layer on the model some how ... if you roll your own 
			/*	
			var colorLayer : ColorLayerVO; 
			colorLayer = new ColorLayerVO;
			colorLayer.name = 'Mask2'
			colorLayer.url ='assets/images/imgbase.png'
			//colorLayer.mask = true
			//imageLayer.showInList = false
			colorLayer.locked = true; //all masks should be locked by default 
			face.layersToImport.push(colorLayer);
			*/
			var colorLayer : ColorLayerVO; 
			
			colorLayer = new ColorLayerVO;
			colorLayer.name = 'Color Layer'
			colorLayer.url ='assets/images/imgbase.png'
			//colorLayer.mask = true
			colorLayer.showInList = true;
			colorLayer.prompt_layer = true;
			colorLayer.color = 0x166571;
			colorLayer.locked = true; //all masks should be locked by default 
			face.layersToImport.push(colorLayer);
			
			var textLayer: TextLayerVO = new TextLayerVO;
			textLayer.text = 'Add Text' 
			textLayer.name = 'Text'
			textLayer.maxChars = 25
			textLayer.sizingSettings = TextLayerVO.SIZING_AUTO_SIZE; //'get smaller' 
			textLayer.maxFontSize = 35
			textLayer.minFontSize = 6
			textLayer.prompt_layer = true; 
			face.layersToImport.push(textLayer);
			var imageLayer: ImageLayerVO
			
			
			imageLayer = new ImageLayerVO;
			imageLayer.name = 'Upload'
			imageLayer.url ='assets/images/pokemon.png'
			imageLayer.default_url ='assets/images/pokemon.png'
			imageLayer.prompt_layer = true; 
			imageLayer.visible = true; 
			imageLayer.cost = 8.95
			imageLayer.image_source = ViridConstants.IMAGE_SOURCE_UPLOAD
			face.layersToImport.push(imageLayer);
			
			imageLayer = new ImageLayerVO;
			imageLayer.url = ''
			imageLayer.name = 'Clip Art 1'
			imageLayer.visible = false; 
			imageLayer.cost = 14.00
			imageLayer.prompt_layer = true; 
			imageLayer.image_source = ViridConstants.IMAGE_SOURCE_CLIPART	
			face.layersToImport.push(imageLayer);
			
			imageLayer = new ImageLayerVO;
			//imageLayer.url = ''
			imageLayer.name = 'Clip Art 2'
			imageLayer.prompt_layer = true; 
			imageLayer.visible = false; 
			imageLayer.cost = 14.00
			imageLayer.image_source = ViridConstants.IMAGE_SOURCE_CLIPART					
			face.layersToImport.push(imageLayer);
			
			imageLayer = new ImageLayerVO;
			imageLayer.prompt_layer = true; 		
			imageLayer.name = 'Clip Art 3'
			imageLayer.cost = 14.00
			imageLayer.image_source = ViridConstants.IMAGE_SOURCE_CLIPART
			imageLayer.url ='assets/images/img.jpg'
			imageLayer.visible = false; 
			face.layersToImport.push(imageLayer);
			
			/*var l : Array = [] ; 
			l = MakeVOs.makeObjs(['L1', 'L2'], LessonVO, 'name' )
			var lp : LessonGroupVO = new LessonGroupVO(); 
			lp.lessons = new ArrayList( l ) ; 
			//this.model.loadLessons( l ); 
			
			var firstLesson : LessonVO = lp.lessons.getItemAt( 0 ) as LessonVO
			l = MakeVOs.makeObjs(['Ls1', 'Ls2', 'Ls3'], LessonSetVO, 'name' )
			firstLesson.sets = new ArrayList( l ) ; 
			
			var set : LessonSetVO = firstLesson.sets.getItemAt( 0 ) as LessonSetVO
			l = MakeVOs.makeObjs(['dog', '2', '3','4'], LessonItemVO, 'name' )
			set.items = new ArrayList( l ) ; 					
			
			this.model.currentLessonPlan = lp ; */
			this.createBackFace(base); 
			this.model.baseItem = base; 
		}		
		
		
		private function createBackFace(base:StoreItemVO):void
		{
			var face : FaceVO = new FaceVO()
			face.name = 'Back Face'
			//face.base_image_url = 'assets/images/imgbase.png'
			face.base_image_url = 'assets/images/lighter_back_base.png'
			base.faces.addItem( face ) 
			/*
			imgLayer = new ImageLayerVO(); 
			imgLayer.name = 'Mask Image';
			imgLayer.url = face.base_image_url; 
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
			*/
			
			face.image_mask = 'assets/images/lighter_back_workarea.png'
			face.image_mask_alpha = 0.4
			//just have to get it to the mask layer on the model some how ... if you roll your own 
			/*	
			var colorLayer : ColorLayerVO; 
			colorLayer = new ColorLayerVO;
			colorLayer.name = 'Mask2'
			colorLayer.url ='assets/images/imgbase.png'
			//colorLayer.mask = true
			//imageLayer.showInList = false
			colorLayer.locked = true; //all masks should be locked by default 
			face.layersToImport.push(colorLayer);
			*/
			var colorLayer : ColorLayerVO; 
			
			colorLayer = new ColorLayerVO;
			colorLayer.name = 'Color Layer'
			colorLayer.url ='assets/images/lighter_back_workarea.png'
			//colorLayer.mask = true
			colorLayer.showInList = false
			colorLayer.color = 0x166571;
			colorLayer.locked = true; //all masks should be locked by default 
			face.layersToImport.push(colorLayer);
			
			var textLayer: TextLayerVO = new TextLayerVO;
			textLayer.text = 'Back Text' 
			textLayer.name = 'Text'
			textLayer.maxChars = 25
			textLayer.sizingSettings = TextLayerVO.SIZING_AUTO_SIZE; //'get smaller' 
			textLayer.maxFontSize = 35
			textLayer.minFontSize = 6
			textLayer.prompt_layer = true; 
			textLayer.default_text = 'Back Text'
			face.layersToImport.push(textLayer);
			var imageLayer: ImageLayerVO
			
			
			imageLayer = new ImageLayerVO;
			imageLayer.name = 'Upload'
			imageLayer.url ='assets/images/pokemon.png'
			imageLayer.default_url ='assets/images/pokemon.png'
			imageLayer.prompt_layer = true; 
			imageLayer.visible = false; 
			imageLayer.cost = 8.95
			imageLayer.image_source = ViridConstants.IMAGE_SOURCE_UPLOAD
			face.layersToImport.push(imageLayer);
			
			imageLayer = new ImageLayerVO;
			imageLayer.url = ''
			imageLayer.name = 'Clip Art 1'
			imageLayer.visible = false; 
			imageLayer.cost = 14.00
			imageLayer.prompt_layer = true; 
			imageLayer.image_source = ViridConstants.IMAGE_SOURCE_CLIPART	
			face.layersToImport.push(imageLayer);
			
			imageLayer = new ImageLayerVO;
			//imageLayer.url = ''
			imageLayer.name = 'Clip Art 2'
			imageLayer.prompt_layer = true; 
			imageLayer.visible = false; 
			imageLayer.cost = 14.00
			imageLayer.image_source = ViridConstants.IMAGE_SOURCE_CLIPART					
			face.layersToImport.push(imageLayer);
			
			imageLayer = new ImageLayerVO;
			imageLayer.prompt_layer = true; 		
			imageLayer.name = 'Clip Art 3'
			imageLayer.cost = 14.00
			imageLayer.image_source = ViridConstants.IMAGE_SOURCE_CLIPART
			imageLayer.url ='assets/images/img.jpg'
			imageLayer.visible = false; 
			face.layersToImport.push(imageLayer);
			
			/*var l : Array = [] ; 
			l = MakeVOs.makeObjs(['L1', 'L2'], LessonVO, 'name' )
			var lp : LessonGroupVO = new LessonGroupVO(); 
			lp.lessons = new ArrayList( l ) ; 
			//this.model.loadLessons( l ); 
			
			var firstLesson : LessonVO = lp.lessons.getItemAt( 0 ) as LessonVO
			l = MakeVOs.makeObjs(['Ls1', 'Ls2', 'Ls3'], LessonSetVO, 'name' )
			firstLesson.sets = new ArrayList( l ) ; 
			
			var set : LessonSetVO = firstLesson.sets.getItemAt( 0 ) as LessonSetVO
			l = MakeVOs.makeObjs(['dog', '2', '3','4'], LessonItemVO, 'name' )
			set.items = new ArrayList( l ) ; 					
			
			this.model.currentLessonPlan = lp ; */
			//this.createBackFace(base); 
			//this.model.baseItem = base; 
		}		
		
		
		
	}
}