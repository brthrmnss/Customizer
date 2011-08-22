package   org.syncon2.utils.data
{
	import mx.collections.ArrayCollection;
	
	public class  GoThroughEach 
	{
		private var currentIndex:int;
		private var songs: Array = []; ;
		private var fxCallAfterSoundCompletePlaying:Function;
		private var fxCallback:Function;
		private var complete:Boolean=true;
	
		public function go( arr : Array, fxCallback:Function, fxComplete : Function   ) : void
		{
			this.complete = false; 
			this.songs = arr; 
			this.fxCallAfterSoundCompletePlaying = fxComplete
			this.fxCallback = fxCallback; 
			this.currentIndex = -1
			this.nextSound(); 		
			
		}
		
		private function nextSound(e:Object=null) : void
		{
			if ( this.complete ) return; 
			this.currentIndex ++
			if ( currentIndex>=  this.songs.length ) 
			{
				if ( this.fxCallAfterSoundCompletePlaying != null ) 
					fxCallAfterSoundCompletePlaying();
				fxCallAfterSoundCompletePlaying = null
					this.complete = true; 
				return;
			}
			fxCallback(this.songs[this.currentIndex]  ); 
		}
		
		public function next() : void
		{
			this.nextSound(null); 
		}
			
		public function get index() : int
		{
			return this.currentIndex; 
		}
		
		/**
		 * Terminate looping early , make sure no further indexes can be called
		 * */
		public function end() : void
		{
			if ( this.fxCallAfterSoundCompletePlaying != null ) 
				fxCallAfterSoundCompletePlaying();
			fxCallAfterSoundCompletePlaying = null
			this.songs = [] ; // 
		}
		
			
	}
}