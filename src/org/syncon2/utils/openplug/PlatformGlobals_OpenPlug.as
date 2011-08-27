package org.syncon2.utils.openplug
{
	import flash.events.Event;
	import flash.events.TouchEvent;
	
	import openplug.elips.controls.Alert;
	import openplug.elips.controls.List;
	import openplug.elips.controls.listClasses.ListIndex;
	import openplug.elips.events.ItemTouchTapEvent;
	
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
		
		
		
		private var _fxMediate : Function;
		public function setFxMediate(fx  :  Function ) : void
		{
			this._fxMediate = fx; 
		}
		
		public function fxMediate(ui :  Object ) : void
		{
			this._fxMediate(ui)
		}
		
		
		public function setListSelectedIndex ( list : List, row : Number, section : Number =-1 ) : void
		{
			list.selectedIndex = new ListIndex(row, section )  ; 
		}
		public	function setListScrollPosition ( list : List, row : Number, section : Number =-1 ) : void
		{
			list.verticalScrollPosition =   new ListIndex(row, section ); 
		}
		
	}
}