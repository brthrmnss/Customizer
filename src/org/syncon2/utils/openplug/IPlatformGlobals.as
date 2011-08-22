package  org.syncon2.utils.openplug
{
	import flash.events.Event;
	
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
		function show ( title : String, msg : String='' ) : void
	}
}