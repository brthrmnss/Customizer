package  org.syncon2.utils.openplug
{
	import flash.events.Event;
	
	import openplug.elips.controls.List;
	
	public interface IPlatformGlobals  
	{
		//function set ELIPS ( b : Boolean ) : void
		function get  ELIPS (   ) :  Boolean
		
		//function set flex ( b : Boolean ) : void
		function get  flex (   ) :  Boolean
		
		
		function addPlatformClickEvent(ui : Object, fx : Function ) : void
		function removePlatformClickEvent(ui : Object, fx : Function ) : void
		function addPlatformListClickEvent(ui : Object, fx : Function ) : void
		function  removePlatformListClickEvent(ui : Object, fx : Function ) : void
		
		function getItemClickEventData( e : Event ) : Object
		function setFxMediate( f : Function ) : void
		function fxMediate( io : Object ) : void
		function show ( title : String, msg : String='' ) : void
		function setListSelectedIndex ( list : List, row : Number, section : Number =-1 ) : void
		function setListScrollPosition ( list : List, row : Number, section : Number =-1 ) : void
		
	}
}