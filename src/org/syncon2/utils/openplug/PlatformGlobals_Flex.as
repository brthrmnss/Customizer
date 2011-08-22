package org.syncon2.utils.openplug
{
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.events.ListEvent;
	
	public class PlatformGlobals_Flex implements IPlatformGlobals
	{
		
		public	function get ELIPS( ) : Boolean
		{
			return false; 
		}
		public	function get flex( ) : Boolean
		{
			return true; 
		}
		
		public function addPlatformClickEvent(ui : Object, fx : Function ) : void
		{
			ui.addEventListener(MouseEvent.CLICK, fx , false, 0, true )
		}
		public function removePlatformClickEvent(ui : Object, fx : Function ) : void
		{
			ui.removeEventListener(MouseEvent.CLICK, fx ) ;//, false, 0, true )
		}
		public function addPlatformListClickEvent(ui : Object, fx : Function ) : void
		{
			ui.addEventListener(ListEvent.ITEM_CLICK, fx , false, 0, true )
		}
		public function removePlatformListClickEvent(ui : Object, fx : Function ) : void
		{
			ui.removeEventListener(ListEvent.ITEM_CLICK , fx ) ;//, false, 0, true )
		}
		public function show( msg : String, title : String ='') : void
		{
			//have another close fx ...
			Alert.show( msg, title ); 
			//ui.removeEventListener(TouchEvent.TOUCH_TAP, fx ) ;//, false, 0, true )
		}
		
		
	}
}