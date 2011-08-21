package  	org.syncon.Customizer.view.popup.rs 
{
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	import org.syncon.Customizer.model.NightStandModel;
	import org.syncon.Customizer.vo.LazyEventHandler;
	
	public class  PopupUploadImageMediator extends Mediator
	{
		[Inject] public var ui:PopupUploadImage;
		[Inject] public var model : NightStandModel;
		private var ev :  LazyEventHandler = new LazyEventHandler(); 
		public function PopupUploadImageMediator()
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
			this.ev.addEv(PopupUploadImage.CANCEL, this.onCancel )
			this.ev.addEv(PopupUploadImage.SETUP, this.onSetup ) ; 
		}
		
		
		
		protected function onSetup(event:Event):void
		{
		}
		
		
		
		
		private function onCancel(e:Event) : void
		{
			this.ui.hide();
		}				
		
		
	}
}