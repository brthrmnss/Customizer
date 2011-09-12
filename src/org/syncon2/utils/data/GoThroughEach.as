package   org.syncon2.utils.data
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	
	public class  GoThroughEach 
	{
		private var currentIndex:int;
		private var songs: Array = []; ;
		private var fxCallAfterSoundCompletePlaying:Function;
		private var fxCallback:Function;
		private var complete:Boolean=true;
		private var timer : Timer  
		private var timeDelay:Number=0;
		public function go( arr : Array, fxCallback:Function, fxComplete : Function, timeDelay_ : Number = 0    ) : void
		{
			this.complete = false; 
			this.songs = arr; 
			this.fxCallAfterSoundCompletePlaying = fxComplete
			this.fxCallback = fxCallback; 
			this.currentIndex = -1
			this.nextSound(); 		
			this.timeDelay = timeDelay_
			if ( timeDelay > 0 ) 
			{
				timer = new Timer(timeDelay,1 )
				timer.addEventListener(TimerEvent.TIMER, this.nextTimerComplete ) 
			}
		}
		
		private function nextSound(e:Object=null, timed : Boolean = false) : void
		{
			if ( timeDelay != 0 && timed == false  ) 
			{
				this.timer.start();
				return; 
			}
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
		public function nextTimerComplete(e:TimerEvent) : void
		{
			timer.stop(); 
			this.nextSound(null, true ); 
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