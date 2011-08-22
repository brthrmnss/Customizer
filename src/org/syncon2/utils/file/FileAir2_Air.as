package  org.syncon2.utils.file
{
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	
	import org.syncon2.utils.services.utils.SendRequest;
	
	public class FileAir2_Air  
	{
		static public var baseAddressOfProxyServer : String =  'http://localhost:7126/'
		static public var baseFolder : File = File.applicationStorageDirectory
		static public var baseFolder_writeOverride :  File// = File.applicationDirectory; 
		private var  fxRead : Function; 
		
		public   function read( folder : String,  filename : String, fx : Function ):void
		{
			//new File()
			//var f : File = File.applicationDirectory
			var path :String= this.joinPath(folder, filename ) 
				var b : Object = baseFolder 
			var file:File = baseFolder.resolvePath(path);
			var path_ : String= file.nativePath
			if(file.exists) {
				var fileStream:FileStream = new FileStream();
				fileStream.open(file, FileMode.READ);
				var str:String = fileStream.readUTFBytes(fileStream.bytesAvailable);
				fileStream.close();
				fx( str )
				return;
			}
			fx( null) 
		}
		
		private function joinPath(folder:String, filename:String): String
		{
			if ( folder == '' ) 
				return filename 
			var newPath : String = folder+ '/' + filename
			return newPath;
		}
		
		private var  fxWritten : Function; 
		
		public function write(contents : String, folder : String, filename:String, fx : Function=null ):void
		{
			var path :String= this.joinPath(folder, filename ) 
			var file:File = baseFolder.resolvePath(path);
			if ( baseFolder_writeOverride != null ) 
			{
				file = baseFolder_writeOverride.resolvePath(path);
			}
			try 
			{
			file = new File(file.nativePath );
			}
			catch ( e : Error )  {}
			if ( file.exists == false && file.isDirectory )
				file.createDirectory()
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			//contents = contents.replace(/\r/g, File.lineEnding);
			contents = contents.replace(/\r/g, '\n');
			fileStream.writeUTFBytes(contents);
			fileStream.close();
			
			if ( fx != null )  	fx( contents )
		}
		
		
		private var  fxDownloadFile : Function; 
		
		public function downloadFileTo(url : String, dir : String, filename:String, fx : Function=null ):void
		{
			var pss :   SendRequest = new SendRequest(); 
			var params : Object = {}; 
			params.file = filename
			params.folder =dir
			params.url = url
			pss.request( baseAddressOfProxyServer+'download_file', params, onDownloadFileResult , onDownloadFileFault ); 
			fxDownloadFile = fx; 
		}
		
		private function onDownloadFileResult(data:String):void
		{
			trace("Upload complete");
			if ( fxDownloadFile != null ) 
				fxDownloadFile( data ) ; 
		}
		
		private function onDownloadFileFault(e:Object):void
		{
			trace('upload error'); 
			
		} 
		
		/*
		public   function readObjectFromFile(fname:String):Object
		{
		var file:File = File.applicationStorageDirectory.resolvePath(fname);
		
		if(file.exists) {
		var obj:Object;
		var fileStream:FileStream = new FileStream();
		fileStream.open(file, FileMode.READ);
		obj = fileStream.readObject();
		fileStream.close();
		return obj;
		}
		return null;
		}
		*/
		
		
		public   function readDirectory(folder:String , fx : Function ):void
		{
			var req:URLRequest = new URLRequest("http://localhost:8888/read_folder");
			//req.method = URLRequestMethod.POST;
			
			var postData:URLVariables = new URLVariables();
			postData.folder =folder//encoder.flush();
			req.data = postData;
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE, readDirectory_complete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, this.onReadDirectoryFault, false, 0, true  ) 
			loader.load(req);
			fxReadDir = fx; 
		}
		
		protected function onReadDirectoryFault(event:Object):void
		{
			trace("read dir fault ");
			fxReadDir(null ) ; 
		}
		
		private function readDirectory_complete(event:Event):void
		{
			/*var b : ByteArray = event.currentTarget.data; 
			trace("read dir ");
			var data : ByteArray = b
			try{
				var obj : Object = data.readObject() 
				var data2 :  Object = JSON.decode( obj.toString() ) 
				//trace( data2 ) ; 
			}
			catch(e:Error )
			{
				trace(e); 
			}*/
			var data2 : Object
			fxReadDir( data2  ) ;
		}
		
		private var fxReadDir:Function;
		
		
		
		
		public function getProxy(url:String) : URLRequest
		{
			var req:URLRequest = new URLRequest(baseAddressOfProxyServer+"play_sound");
			var postData:URLVariables = new URLVariables();
			postData.file_name //=event.url; //encoder.flush();
			postData.path //= this.
			postData.url = url
			//postData.readAs
			req.data = postData;
			return req; 
		}
		
		
		public function deleteFile( dir : String, filename:String, fx : Function=null ):void
		{
			var path :String= this.joinPath(dir, filename ) 
			var file:File = baseFolder.resolvePath(path);
			file.deleteFile()
			if ( fx != null ) 
				fx( filename ) ; 
		}
		
		
		
		public function getSubDirectories( dir :String, fx : Function=null ):void
		{
			var folder:File = baseFolder.resolvePath(dir);
			var dirList:Array = folder.getDirectoryListing();
			var directories:Array  = [] ;
			for each ( var d : File in dirList ) 
			{
				if ( d.isDirectory ) 
					directories.push(d.name)
			}
			
			
			if ( fx != null ) 
				fx(directories)
		}
		
		/**
		 * ??? mistake why is this here? 
		 * 8/147/11
		 * 
		 * */
		public function get baseFolderr () : File
		{
			return baseFolder; 
		}
		
		
	}
}