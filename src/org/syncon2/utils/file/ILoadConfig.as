package  org.syncon2.utils.file
{
	import flash.net.URLRequest;

	public interface ILoadConfig  
	{
		
		/**
		 * post save function to call when saving is complete ... thisis for async support 
		 * */
		  function writeObjectToFile(object:Object, fname:String, fxCallbak : Function =null):Boolean
		
			  /**
			  * return false if you don't have sync data 
			  * */
		  function readObjectFromFile(fname:String, fxCallbak : Function): Object
		
			  
			  
			  
		  
		  /**
		   * post save function to call when saving is complete ... thisis for async support 
		   * */
		  function writeFile(contents : String, dir : String, filename:String, fxCallbak : Function =null):void
		  
		  /**
		   * return false if you don't have sync data 
		   * */
		  function readFile(dir : String, filename:String, fxCallbak : Function): void
			  
		  
		  /**
		   * return false if you don't have sync data 
		   * */
		  function downloadFileTo(url : String, dir : String, filename:String, fxCallbak : Function,renameIfExists : Boolean=false ): void
			  			  
		  /**
		   * return false if you don't have sync data 
		   * */
		  function getUrlProxy(url : String ): URLRequest
			  
		  
		  /**
		   * */
		  function deleteFile( dir : String, filename:String, fxCallbak : Function=null): void
			 
		  /**
		  * will return strings of directories
		   * */
		  function getDirectoryListing( dir : String, fxCallbak : Function=null): void
			  
			  
		  /**
		   * */
		  function isDirectory(  filename:String, fxCallbak : Function=null): void			  
			  
		  
		  /**
		   * */
		  function getSubDirectories(  dir:String, fxCallbak : Function=null): void			  			  
			
			  
		  /**
		  * used for flex for ruby server locating ... not imp for air ? 
		  * to set pro use the implementation 
		  * needs to be a static implmeentation ...
		  * i do not undersatnd how this is ok to compile ...
		   * */
		  function get   getBaseFolder(  ):String 
	}
}