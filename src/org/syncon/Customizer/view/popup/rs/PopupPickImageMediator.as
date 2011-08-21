package  	org.syncon.Customizer.view.popup.rs 
{
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	import org.syncon.Customizer.model.CustomEvent;
	import org.syncon.Customizer.model.NightStandModel;
	import org.syncon.Customizer.vo.ImageVO;
	import org.syncon.Customizer.vo.LazyEventHandler;
	import org.syncon.popups.controller.ShowPopupEvent;
	
	public class  PopupPickImageMediator extends Mediator
	{
		[Inject] public var ui:PopupPickImage;
		[Inject] public var model : NightStandModel;
		private var ev :  LazyEventHandler = new LazyEventHandler(); 
		public function PopupPickImageMediator()
		{
		} 
		override public function onRemove():void
		{
			ev.unmapAll(); 
			super.onRemove()
		}
		override public function onRegister():void
		{
			ev.init( this.ui ) ; 
			this.ev.addEv(PopupPickImage.CANCEL, this.onCancel )
			this.ev.addEv(PopupPickImage.SETUP, this.onSetup ) ; 
			
			this.ev.addEv(PopupPickImage.UPLOAD, this.onUpload )
			
			this.ev.addEv(PopupPickImage.SELECT, this.onSelect )
			
			
			this.ui.list.dataProvider = this.model.images; 
		}
		
		private function onSelect(e:CustomEvent):void
		{
			this.ui.list.selectedIndex = -1
			var img : ImageVO = e.data as ImageVO; 
			//	img.name = 'foo'; 
			this.ui.hide()
			this.ui.fxDone( img ) ; 
		}
		
		private function onUpload(event:Event=null):void
		{
			//this.dispatch( new AutomateEvent(AutomateEvent.START_LESSON, this.ui.lesson )) 
			//this.ui.hide(); 
			var event_ : ShowPopupEvent = new ShowPopupEvent(ShowPopupEvent.SHOW_POPUP, 
				'PopupUploadImage', [null], 'done' ) 		
			this.dispatch( event_ ) 
		}	
		
		protected function onSetup(event:Event):void
		{
			//this.ui.txtLessonName.text = this.model.currentLessonPlan.name; 
		}
		
		
		
		
		private function onCancel(e:Event) : void
		{
			this.ui.hide();
		}				
		
		
	}
}