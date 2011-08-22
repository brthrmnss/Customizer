package org.syncon2.utils.openplug
{
	import flash.events.TouchEvent;
	
	import openplug.elips.controls.Alert;
	import openplug.elips.events.ItemTouchTapEvent;
	import flash.events.Event;
	
	public class PlatformGlobals_OpenPlug implements IPlatformGlobals
	{
		
		public	function get ELIPS ( ) : Boolean
		{
			return true; 
		}
		public	function get flex ( ) : Boolean
		{
			return false; 
		}
		
		public function addPlatformClickEvent(ui : Object, fx : Function ) : void
		{
			ui.addEventListener(TouchEvent.TOUCH_TAP, fx , false, 0, true )
		}
		public function removePlatformClickEvent(ui : Object, fx : Function ) : void
		{
			ui.removeEventListener(TouchEvent.TOUCH_TAP, fx ) ;//, false, 0, true )
		}
		public function addPlatformListClickEvent(ui : Object, fx : Function ) : void
		{
			
			ui.addEventListener(ItemTouchTapEvent.ITEM_TOUCH_TAP, fx , false, 0, true )
		}
		public function removePlatformListClickEvent(ui : Object, fx : Function ) : void
		{
			ui.removeEventListener(ItemTouchTapEvent.ITEM_TOUCH_TAP , fx ) ;//, false, 0, true )
		}
		
		public function getItemClickEventData(event : Event ) : Object
		{
			return event['item'] ; 
		}
		
		public function show ( msg : String, title : String ='') : void
		{
			//have another close fx ...
			Alert.show( msg, title ); 
			//ui.removeEventListener(TouchEvent.TOUCH_TAP, fx ) ;//, false, 0, true )
		}
		
		
	}
}