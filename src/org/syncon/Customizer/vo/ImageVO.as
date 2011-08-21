package  org.syncon.Customizer.vo
{
	import flash.events.EventDispatcher;

	public class ImageVO  extends EventDispatcher
	{
		public var hiSpeedMode : Boolean = true; 
		
		public var name : String = ''; 
		public var url : String  = ''; 
		
		static public var UPDATED : String = 'updatedImaveVO'; 
		
	}
}