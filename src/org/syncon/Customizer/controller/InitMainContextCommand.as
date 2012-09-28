package org.syncon.Customizer.controller
{
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	import org.syncon.Customizer.model.NightStandModel;
	import org.syncon.Customizer.model.ViridConstants;
	import org.syncon.Customizer.vo.CollectiveLayerPriceVO;
	import org.syncon.Customizer.vo.ColorLayerVO;
	import org.syncon.Customizer.vo.FaceVO;
	import org.syncon.Customizer.vo.FontVO;
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
				
				this.createDetailedDefaultProduct();
				//this.createDetailedDefaultProduct_Engrave()
				//this.createDetailedDefaultProduct_Engrave2(false)
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
			/*var names : Array = [] ; 
			for (var i : int = 0 ; i < 150; i++ )
			{
			names.push( 'Title ' + i.toString() ) ; 
			}
			var imgs : Array = MakeVOs.makeObjs( names, ImageVO, 'name' )
			for each ( var img : ImageVO in imgs ) 
			{
			img.url = 'assets/images/img.jpg'; 
			}*/
			
			
			
			var prefix : String = "assets/images/zippoLibrary/clipart_8_16_2012/";
			/*var cprefix : String = "assets/images/zippoLibrary/clipart/color/";
			var backprefix : String = "assets/images/zippoLibrary/clipart/set2/";
			var set3prefix : String = "assets/images/zippoLibrary/clipart/set3/";
			var set4prefix : String = "assets/images/zippoLibrary/clipart/set4/";*/

			var importImages : Array = [
				['Beer',prefix + 'BackgroundBeer.png'],
				['Camouflage1',prefix + 'BackgroundCamouflage.png'],
				['Camouflage2',prefix + 'BackgroundCamouflage16.png'],
				['Camouflage3',prefix + 'BackgroundCamouflage18.png'],
				['Camouflage4',prefix + 'BackgroundCamouflage19.png'],
				['Crocodile1',prefix + 'BackgroundCrocodile1.png'],
				['Crocodile2',prefix + 'BackgroundCrocodile2.png'],
				['Feathers',prefix + 'BackgroundFeathers.png'],
				['Fire1',prefix + 'BackgroundFire1.png'],
				['Fire2',prefix + 'BackgroundFire2.png'],
				['Fireworks',prefix + 'BackgroundFireworks.png'],
				['Flowers',prefix + 'BackgroundFlowers.png'],
				['Fur1',prefix + 'BackgroundFur1.png'],
				['Fur2',prefix + 'BackgroundFur2.png'],
				['Fur3',prefix + 'BackgroundFur3.png'],
				['Fur4',prefix + 'BackgroundFur4.png'],
				['Green1',prefix + 'BackgroundGreen1.png'],
				['Green2',prefix + 'BackgroundGreen2.png'],
				['Green3',prefix + 'BackgroundGreen3.png'],
				['Heart1',prefix + 'BackgroundHeart1.png'],
				['Heart2',prefix + 'BackgroundHeart2.png'],
				['Jean1',prefix + 'BackgroundJean1.png'],
				['Jean2',prefix + 'BackgroundJean2.png'],
				['Owl',prefix + 'BackgroundOwl.png'],
				['Rainbow1',prefix + 'BackgroundRainbow.png'],
				['Scroll',prefix + 'BackgroundScroll.png'],
				['Skull',prefix + 'BackgroundSkull.png'],
				['Snake',prefix + 'BackgroundSnake.png'],
				['StarStripes',prefix + 'BackgroundStarStripes.png'],
				['Stars',prefix + 'BackgroundStars.png'],
				['Steel1',prefix + 'BackgroundSteel1.png'],
				['Steel2',prefix + 'BackgroundSteel2.png'],
				['TieDye1',prefix + 'BackgroundTieDye1.png'],
				['TieDye2',prefix + 'BackgroundTieDye2.png'],
				['Wanted',prefix + 'BackgroundWanted.png'],
				['Water1',prefix + 'BackgroundWater1.png'],
				['Water2',prefix + 'BackgroundWater2.png'],
				['Zebra',prefix + 'BackgroundZebra.png'],
				['Biohazard1',prefix + 'Biohazard1.png'],
				['Biohazard2',prefix + 'Biohazard2.png'],
				['Border1',prefix + 'Border1.png'],
				['Border2',prefix + 'Border2.png'],
				['Border3',prefix + 'Border3.png'],
				['Border4',prefix + 'Border4.png'],
				['BrideGroom1',prefix + 'BrideGroom1.png'],
				['BrideGroom2',prefix + 'BrideGroom2.png'],
				['BrideGroom3',prefix + 'BrideGroom3.png'],
				['Bubble1',prefix + 'Bubble1.png'],
				['Bubble2',prefix + 'Bubble2.png'],
				['Bubble3',prefix + 'Bubble3.png'],
				['Bubble4',prefix + 'Bubble4.png'],
				['Bullet',prefix + 'Bullet.png'],
				['CheckeredFlag',prefix + 'CheckeredFlag.png'],
				['Clover',prefix + 'Clover.png'],
				['Cross',prefix + 'Cross.png'],
				['Devil1',prefix + 'Devil1.png'],
				['Devil2',prefix + 'Devil2.png'],
				['Dragons',prefix + 'Dragons.png'],
				['Eyes',prefix + 'Eyes.png'],
				['Glass1',prefix + 'Glass1.png'],
				['Glass2',prefix + 'Glass2.png'],
				['Glass3',prefix + 'Glass3.png'],
				['Glass4',prefix + 'Glass4.png'],
				['Glasses1',prefix + 'Glasses1.png'],
				['Glasses2',prefix + 'Glasses2.png'],
				['Glasses3',prefix + 'Glasses3.png'],
				['Glasses4',prefix + 'Glasses4.png'],
				['Golfer1',prefix + 'Golfer1.png'],
				['Golfer2',prefix + 'Golfer2.png'],
				['Golfer3',prefix + 'Golfer3.png'],
				['Guitar',prefix + 'Guitar.png'],
				['Gun',prefix + 'Gun.png'],
				['Heart1',prefix + 'Heart1.png'],
				['Heart2',prefix + 'Heart2.png'],
				['Heart3',prefix + 'Heart3.png'],
				['Heart4',prefix + 'Heart4.png'],
				['Helicopter',prefix + 'Helicopter.png'],
				['Lips1',prefix + 'Lips1.png'],
				['Lips2',prefix + 'Lips2.png'],
				['Lips3',prefix + 'Lips3.png'],
				['Mustache1',prefix + 'Mustache1.png'],
				['Mustache2',prefix + 'Mustache2.png'],
				['Mustache3',prefix + 'Mustache3.png'],
				['PinkScroll',prefix + 'PinkScroll.png'],
				['Political1',prefix + 'Political1.png'],
				['Political2',prefix + 'Political2.png'],
				['PropertyOf',prefix + 'PropertyOf.png'],
				['Rainbow2',prefix + 'Rainbow.png'],
				['Ring1',prefix + 'Ring1.png'],
				['Ring2',prefix + 'Ring2.png'],
				['Skull1',prefix + 'Skull1.png'],
				['Skull2',prefix + 'Skull2.png'],
				['Skull3',prefix + 'Skull3.png'],
				['Snake1',prefix + 'Snake1.png'],
				['Snake2',prefix + 'Snake2.png'],
				['Snowflake',prefix + 'Snowflake.png'],
				['Soldier1',prefix + 'Soldier1.png'],
				['Soldier2',prefix + 'Soldier2.png'],
				['StickBoy',prefix + 'StickBoy.png'],
				['StickCat',prefix + 'StickCat.png'],
				['StickDad',prefix + 'StickDad.png'],
				['StickDog',prefix + 'StickDog.png'],
				['StickGirl',prefix + 'StickGirl.png'],
				['StickMom',prefix + 'StickMom.png'],
				['Teeth',prefix + 'Teeth.png'],
				['Zombie1',prefix + 'Zombie1.png'],
				['Zombie2',prefix + 'Zombie2.png'],
				['bulb',prefix + 'bulb.png']

			];
			/*
			var importImagesSet4:Array = [
				['HEART1', set4prefix + 'Heart1.png'],
				['HEART2', set4prefix + 'Heart2.png'],
				['HEART3', set4prefix + 'Heart3.png'],
				['HEART4', set4prefix + 'Heart4.png'],
				['HEART5', set4prefix + 'Heart5.png'],
				['HEART6', set4prefix + 'Heart6.png'],
				['HEART7', set4prefix + 'Heart7.png'],
				['HEART8', set4prefix + 'Heart8.png'],
				['HEART9', set4prefix + 'Heart9.png'],
				['HEART10', set4prefix + 'Heart10.png'],
				['WEDDINGBANDS', set4prefix + 'WeddingBands.png'],
				['GUITAR', set4prefix + 'Guitar.png'],
				['HELICOPTER', set4prefix + 'Helicopter.png'],
				['HOCKEY', set4prefix + 'Hockey.png'],
				['SKIIING', set4prefix + 'skiiing.png'],
				['SOCCERBALL', set4prefix + 'Soccerball.png'],
				['DRAGONFLY', set4prefix + 'DragonFly.png'],
				['BEER', set4prefix + 'Beer.png'],
				['HORSE', set4prefix + 'Horse.png'],
				['DOUBLEDRAGONS', set4prefix + 'DoubleDragons.png'],
				['BALLOONS', set4prefix + 'Balloons.png'],
				['AMERICANFLAG', set4prefix + 'AmericanFlag.png'],
				['PAWPRINTS', set4prefix + 'Pawprints.png'],
				['DOGTAGS', set4prefix + 'DogTags.png'],
				['PEACESIGN', set4prefix + 'PeaceSign.png'],
				['GOLFER', set4prefix + 'Golfer.png'],
				['CROSS', set4prefix + 'Cross.png'],
				['CHECKEREDFLAG', set4prefix + 'CheckeredFlag.png'],
				['BASEBALL', set4prefix + 'Baseball.png'],
				['TRUCK', set4prefix + 'Truck.png'],
				['GUN', set4prefix + 'Gun.png'],
				['SKULL', set4prefix + 'Skull.png'],
				['BIOHAZARD', set4prefix + 'Biohazard.png'],
				['REDSPLASH', set4prefix + 'RedSplash.png'],
				['PROPERTYOF', set4prefix + 'PropertyOf.png'],
				['WINE', set4prefix + 'Wine.png'],
				['ALIEN1', set4prefix + 'Alien1.png'],
				['ALIEN2', set4prefix + 'Alien2.png'],
				['ALIEN3', set4prefix + 'Alien3.png'],
				['ALIEN4', set4prefix + 'Alien4.png'],
				['BASKETWEAVE', set4prefix + 'BasketWeave.png'],
				['POLKADOT', set4prefix + 'PolkaDot.png'],
				['ZEBRA1', set4prefix + 'Zebra1.png'],
				['ZEBRA2', set4prefix + 'Zebra2.png'],
				['PINK1', set4prefix + 'Pink.png'],
				['MUSTACHE', set4prefix + 'Mustache.png'],
				['SQUARE', set4prefix + 'Square.png'],
				['CIRCLE', set4prefix + 'Circle.png'],
				['WANTEDPOSTER', set4prefix + 'WantedPoster.png'],
				['CLOVER', set4prefix + 'Clover.png'],
				['BULLET', set4prefix + 'Bullet.png'],
				['BASKETBALL', set4prefix + 'Basketball.png'],
				['FOOTBALL', set4prefix + 'Football.png'],
				['DIAMONDSTEELPLATE', set4prefix + 'DiamondSteelPlate.png'],
				['SNOWFLAKE', set4prefix + 'Snowflake.png'],
				['FIREWORKS', set4prefix + 'Fireworks.png'],
				['BORDER1', set4prefix + 'Border1.png'],
				['BORDER2', set4prefix + 'Border2.png'],
				['BORDER3', set4prefix + 'Border3.png'],
				['FLAME1', set4prefix + 'Flame1.png'],
				['FLAME2', set4prefix + 'Flame2.png'],
				['BRICKWALL', set4prefix + 'BrickWall.png']
			];*/
			var i : int = 0 ; 
			var imgs : Array = []; 
			for ( i  = 0 ; i < importImages.length; i++ )
			{
				var imageNameAndSourceArray : Array = importImages[i] as Array
				var img  : ImageVO= new ImageVO()
				img.name = imageNameAndSourceArray[0]
				img.url = imageNameAndSourceArray[1];
				//names.push( 'Title ' + i.toString() ) ; 
				imgs.push( img ); 
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
			face.layersToImport = [];
			
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
			textLayer.height =60 
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
			
			var fonts : Array = []; 
			var font : FontVO = new FontVO()
			font.name = 'Helvetica' 
			fonts.push(font); 
			font = new FontVO()
			font.name = 'Arial' 
			fonts.push(font); 
			font = new FontVO()
			font.name = 'Times New Roman' 
			font.swf_name = 'TimesFont' 
			fonts.push(font); 
			textLayer.fonts = fonts; 
			
			textLayer = new TextLayerVO;
			textLayer.text = 'Add' 
			textLayer.name = 'Text'
			textLayer.maxChars = 3
			textLayer.fonts = fonts; 
			//textLayer.fontFamily = 'Arial'
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
			face.layersToImport = [];
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
			textLayer.fonts = fonts; 
			
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
		
		
		private function createDetailedDefaultProduct_Engrave2(noLayersOnFace1 :Boolean = false):void
		{
			var base : StoreItemVO = new StoreItemVO(); 
			base.name = '1941 Replica &#8482;'
			base.desc = '<br>&#8226;Brushed Brass<br>&#8226;Case has flat planes with sharper, less rounded edges where the front and back surfaces meet the sides<br>&#8226;Lid and the bottom are joined with a four-barrel hinge<br>&#8226;Inside unit are flatter, with squared edges where they meet the front and back sur'
			base.price = 65
			base.sku = '1023763'; 
			var face : FaceVO = new FaceVO()
			face.layersToImport = []; 
			face.name = 'Front'; 
			face.base_image_url = 'assets/products/1941B-000003-Z_Configure.jpg'
			
			base.faces.addItem( face ) 
			
			//face.image_mask = 'assets/images/imgbase.png'
			
			var colorLayer : ColorLayerVO; 
			var imageLayer: ImageLayerVO
			
			/*
			colorLayer = new ColorLayerVO;
			colorLayer.name = 'Color Layer'
			colorLayer.url ='assets/images/imgbase.png'
			//colorLayer.mask = true
			colorLayer.showInList = true;
			colorLayer.prompt_layer = true;
			colorLayer.color = 0x166571;
			colorLayer.locked = true; //all masks should be locked by default 
			face.layersToImport.push(colorLayer);
			*/
			var textLayer: TextLayerVO = new TextLayerVO;
			textLayer.text = '' 
			textLayer.name = 'Top Front'
			textLayer.maxChars = 3
			textLayer.location = 'front small'; 
			/*textLayer.sizingSettings = TextLayerVO.SIZING_AUTO_SIZE; //'get smaller' 
			textLayer.maxFontSize = 35
			*/
			textLayer.width = 130
			textLayer.height =40 
			textLayer.x = 45
			textLayer.y = 75; 
			textLayer.vertStartAlignment = ''; //no necessary if you lock the layer
			textLayer.horizStartAlignment = ''
			textLayer.locked = true; 
			//textLayer.vertStartAlignment = ''; //no necessary if you lock the layer
			//textLayer.horizStartAlignment = ''
			textLayer.subType = ViridConstants.SUBTYPE_ENGRAVE
			//textLayer.minFontSize = 6
			textLayer.prompt_layer = true; 
			face.layersToImport.push(textLayer);
			
			var fonts : Array = []; 
			var font : FontVO = new FontVO()
			font.name = 'Helvetica' 
			fonts.push(font); 
			font = new FontVO()
			font.name = 'Arial' 
			fonts.push(font); 
			font = new FontVO()
			font.name = 'Times New Roman' 
			font.swf_name = 'TimesFont' 
			fonts.push(font); 
			textLayer.fonts = fonts; 
			
			textLayer = new TextLayerVO;
			textLayer.text = '' 
			textLayer.name = 'Text'
			textLayer.maxChars = 3
			textLayer.fonts = fonts; 
			//textLayer.fontFamily = 'Arial'
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
			
			
			textLayer = new TextLayerVO;
			textLayer.text = 'first' 
			textLayer.name = 'Text'
			//face.importFirstLayerSelection = textLayer
			//textLayer.maxChars = 6
			textLayer.fonts = fonts; 
			//textLayer.fontFamily = 'Arial'
			 textLayer.sizingSettings = TextLayerVO.SIZING_AUTO_SIZE; //'get smaller' 
			textLayer.maxFontSize = 35
			textLayer.minFontSize = 12
			textLayer.width = 120
			textLayer.height = 120
			textLayer.x = 50
			textLayer.y =50; 
			textLayer.locked = true; 
			textLayer.fontSize = 35
			textLayer.location = 'front Large'; 
			textLayer.vertStartAlignment = ''; //no necessary if you lock the layer
			textLayer.horizStartAlignment = ''
			textLayer.subType = ViridConstants.SUBTYPE_ENGRAVE
			//textLayer.minFontSize = 6
			textLayer.prompt_layer = true; 
			face.layersToImport.push(textLayer);
			
			
			textLayer = new TextLayerVO;
			textLayer.text = 'ddd '
			
			textLayer.name = 'Text 3'
			//textLayer.maxChars = 3
			textLayer.fonts = fonts; 
			//textLayer.fontFamily = 'Arial'
			
			textLayer.sizingSettings = TextLayerVO.SIZING_AUTO_SIZE; //'get smaller' 
			textLayer.maxFontSize = 35
			textLayer.minFontSize = 12
			textLayer.maxChars = 20
			
				textLayer.verticalText = true
				
			textLayer.width = 20
			textLayer.height = 140 
			textLayer.x = 60
			textLayer.y =200; 
			textLayer.locked = true; 
			textLayer.fontSize = 35
			textLayer.location = 'front Large2'; 
			textLayer.vertStartAlignment = ''; //no necessary if you lock the layer
			textLayer.horizStartAlignment = ''
			textLayer.subType = ViridConstants.SUBTYPE_ENGRAVE
			//textLayer.minFontSize = 6
			textLayer.fonts = fonts; 
			textLayer.prompt_layer = true; 
			face.layersToImport.push(textLayer);
			if ( noLayersOnFace1 ) 
				face.layersToImport = [] ; 
			
			face  = new FaceVO()
			face.layersToImport = []; 
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
			textLayer.showInList = false			
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
			textLayer.fonts = fonts; 
			
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
			textLayer.fonts = fonts; 
			face.layersToImport.push(textLayer);
			
			this.model.baseItem = base; 
		}
		
		private function createDetailedDefaultProduct():void
		{
			var base : StoreItemVO = new StoreItemVO(); 
			base.name = 'Zippo'
			base.price = 65
			var face : FaceVO = new FaceVO()
			face.layersToImport = [] ; 
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
			textLayer.nameHidden = 'put something here';  
			face.layersToImport.push(textLayer);
			var imageLayer: ImageLayerVO
			//face.importFirstLayerSelection = textLayer; 
			
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
			//imageLayer.cost = 14.00
			imageLayer.image_source = ViridConstants.IMAGE_SOURCE_CLIPART					
			face.layersToImport.push(imageLayer);
			
			imageLayer = new ImageLayerVO;
			imageLayer.prompt_layer = true; 		
			imageLayer.name = 'Clip Art 3'
			//imageLayer.cost = 14.00
			imageLayer.image_source = ViridConstants.IMAGE_SOURCE_CLIPART
			imageLayer.url ='assets/images/img.jpg'
			imageLayer.visible = false; 
			face.layersToImport.push(imageLayer);
			
			var collectivePrice : CollectiveLayerPriceVO = new CollectiveLayerPriceVO() ; 
			collectivePrice.price = 9.95; 
			collectivePrice.type = ImageLayerVO.Type; 
			collectivePrice.subtype  = ViridConstants.IMAGE_SOURCE_CLIPART; 
			face.collectiveLayerPrices.push( collectivePrice ) ; 
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
			face.layersToImport = [] ; 
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