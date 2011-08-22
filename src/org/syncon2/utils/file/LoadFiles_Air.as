package org.syncon2.utils.file
{
	import flash.net.URLRequest;
	
	public class LoadFiles_Air implements ILoadConfig
	{
		
		
		public function readObjectFromFile(fname:String, fxCallbak : Function ):Object
		{
			throw 'have disabled these functions, use json, do you need them? '
			/*var fileAir : FileAir = new FileAir(); 
			fileAir.read(fname, fxCallbak)*/
			return false; 
		}
		
		
		
		public function writeObjectToFile(object:Object, fname:String, fxCallbak : Function=null):Boolean
		{
			throw 'have disabled these functions, use json, do you need them? '
			/*var fileAir : FileAir = new FileAir(); 
			fileAir.write( fname, object , 'writeObject' ) */
			return false; 
		}
		
		
		
		static public var baseFolder : String = 'G:/My Documents/work/flex4/Mobile2/RosettaStoneBuilder_Flex/bin-debug/assets'
		
		public function readFile(dir : String, filename:String, fxCallbak : Function ):void
		{
			var fileAir : FileAir2_Air = new FileAir2_Air(); 
			/*if ( dir == '' ) dir =  baseFolder 
			if ( dir.indexOf(':') == -1 ) 
				dir = baseFolder + '/' +  dir   		*/		
			fileAir.read(dir, filename, fxCallbak)
		}
		
		public function writeFile(contents : String, dir : String, filename:String, fxCallbak : Function=null):void
		{
			var fileAir : FileAir2_Air = new FileAir2_Air(); 
			/*if ( dir == '' ) 
			{
				dir = getDir(filename)
				filename = getFileName(filename)
			}
			if ( dir == '' ) dir =  baseFolder 
			if ( dir.indexOf(':') == -1 ) 
				dir = baseFolder + '/' +  dir   */
			fileAir.write(  contents,dir, filename, fxCallbak ) 
		}
		
		
		public function downloadFileTo(url : String, dir : String, filename:String, fxCallbak : Function, renameIfExists : Boolean=false ):void
		{
			var fileAir : FileAir2_Air = new FileAir2_Air();
			if ( dir == '' ) dir =  baseFolder 
			if ( dir.indexOf(':') == -1 ) 
				dir = baseFolder + '/' +  dir   				
			fileAir.downloadFileTo(url, dir, filename, fxCallbak)
		}
		
		public function getUrlProxy(url : String ):URLRequest
		{
			var fileAir : FileAir2_Air = new FileAir2_Air(); 
			return fileAir.getProxy( url) 
		}		
		
		/**
		 * i fflex we alwas y apply the base folder on the directyory 
		 * */
		
		
		
		private function getFileName(filename:String):String
		{
			if ( filename.indexOf('/') == -1 ) 
				return filename
			var split : Array = filename.split('/'); 
			//if no '.' complain
			var last : String = split[split.length-1]
			return last;
		}
		
		private function getDir(filename:String):String
		{
			if ( filename.indexOf('/') == -1 ) 
				return ''
			var split : Array = filename.split('/'); 
			//if no '.' complain
			var dir : String = split.slice( 0, split.length-2).join('/');
			return dir;
		}
		
		
		
		
		public function deleteFile( dir : String, filename:String, fxCallbak : Function=null ):void
		{
			var fileAir : FileAir2_Air = new FileAir2_Air();
			if ( dir == '' ) dir =  baseFolder 
/*			if ( dir.indexOf(':') == -1 ) 
				dir = baseFolder + '/' +  dir   		*/		
			fileAir.deleteFile( dir, filename, fxCallbak)
		}
		
		
		public function getDirectoryListing( dir : String, fxCallbak : Function=null ):void
		{
			var fileAir : FileAir2_Air = new FileAir2_Air();
			if ( dir == '' ) dir =  baseFolder 
			if ( dir.indexOf(':') == -1 ) 
				dir = baseFolder + '/' +  dir   				
		}
		
		
		
		public function isDirectory(   filename:String, fxCallbak : Function=null ):void
		{
			var fileAir : FileAir2_Air = new FileAir2_Air();
		}
		
		
		public function getSubDirectories( dir : String,  fxCallbak : Function=null ):void
		{
			var fileAir : FileAir2_Air = new FileAir2_Air();
			if ( dir == '' ) dir =  baseFolder 
		/*	if ( dir.indexOf(':') == -1 ) 
				dir = baseFolder + '/' +  dir   		*/		
			fileAir.getSubDirectories( dir , fxCallbak)
		}
		
		public function get getBaseFolder(   ): String
		{
			return FileAir2_Air.baseFolder.nativePath
		}
	/*	
		public function downloadFileTo(url : String, dir : String, filename:String, fxCallbak : Function, renameIfExists : Boolean=false ):void
		{
			throw 'didnt care to implement it for air flex-only now flex'; 
		}*/
		
 
	}
}