package org.syncon2.utils.openplug
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.events.ListEvent;
	import openplug.elips.controls.List;
	
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
		
		
		public function getItemClickEventData(event : Event ) : Object
		{
			//.itemRenderer.data
			return event['item'] ; 
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
			list.selectedIndex = row; 
		}
		public	function setListScrollPosition ( list : List, row : Number, section : Number =-1 ) : void
		{
			//list.horizontalScrollPosition = row; 
			list.scrollToIndex( row ) 
		}
		
		
	}
}