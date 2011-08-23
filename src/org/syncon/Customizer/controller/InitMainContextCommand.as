package org.syncon.Customizer.controller
{
	import org.robotlegs.mvcs.Command;
	import org.syncon.Customizer.model.NightStandModel;
	import org.syncon.Customizer.vo.ImageVO;
	import org.syncon.Customizer.vo.StoreItemVO;
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
			if ( event.type == InitMainContextCommandTriggerEvent.SET_MULTIPLER ) 
			{
				if ( this.model.flex == false ) 
				{
					this.model.multipler = event.data as Number
				}
			}	
			
			if ( event.type == InitMainContextCommandTriggerEvent.INIT3_MAKEUP_FLEX_DATA ) 
			{
				if ( this.model.flex ) 
				{
					var names : Array = [] ; 
					for  (var i : int = 0 ; i < 150; i++ )
					{
						names.push( 'Title ' + i.toString() ) ; 
					}
					var imgs : Array = MakeVOs.makeObjs( names, ImageVO, 'name' )
					for each ( var img : ImageVO in imgs ) 
					{
						img.url = 'assets/images/img.jpg'; 
					}
					this.model.loadImages( imgs ) ; 
					
					
					var base : StoreItemVO = new StoreItemVO(); 
					base.name = 'Zippo'
					base.base_image_url = 'assets/images/imgbase.png'
					this.model.baseItem = base; 
					/*var l :  Array = [] ; 
					l = MakeVOs.makeObjs(['L1', 'L2'], LessonVO, 'name' )
					var lp : LessonGroupVO = new LessonGroupVO(); 
					lp.lessons = new ArrayList( l ) ; 
					//this.model.loadLessons( l ); 
					
					var firstLesson : LessonVO = lp.lessons.getItemAt( 0 ) as LessonVO
					l =  MakeVOs.makeObjs(['Ls1', 'Ls2', 'Ls3'], LessonSetVO, 'name' )
					firstLesson.sets = new ArrayList( l ) ; 
					
					var set : LessonSetVO = firstLesson.sets.getItemAt( 0 ) as LessonSetVO
					l =  MakeVOs.makeObjs(['dog', '2', '3','4'], LessonItemVO, 'name' )
					set.items = new ArrayList( l ) ; 					
					
					this.model.currentLessonPlan =  lp ; */
				}
			}	
			
			if ( event.type == InitMainContextCommandTriggerEvent.EXIT_APP ) 
			{
				if ( this.model.flex == false ) 
				{
				}
			}
			
			
		}
		
		
		
		
		
	}
}