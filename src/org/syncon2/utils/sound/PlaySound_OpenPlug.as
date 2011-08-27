package org.syncon2.utils.sound
{
	import flash.events.Event;
	
	import openplug.elips.controls.Alert;
	import openplug.elips.services.SystemAPI;
	
	import org.syncon.TalkingClock.vo.SoundVO;
	
	import outside.PlatformGlobals;
	
	public class  PlaySound_OpenPlug implements  IPlaySound
	{
		public function set fxCallAfterSoundCompletePlaying ( fx : Function ) : void
		{
			this._fxCallAfterSoundCompletePlaying = fx; 
		}
		private var _fxCallAfterSoundCompletePlaying:Function;
		private var addedEventListner:Boolean=false;
		private var currentSoundId:int=-1;
		private var cpu:Boolean=false;
		private var oldUrl:String; /**
		* so we can plsy sound twice
		* */
		public function  get  fxCallAfterSoundCompletePlaying (  ) : Function
		{
			return this._fxCallAfterSoundCompletePlaying  
		}
		
		public function playSound( s : Object, fxCallAfterSoundCompletePlaying_ : Function = null ) : void
		{
			this.playSound2( s.url ); 
			this.fxCallAfterSoundCompletePlaying = fxCallAfterSoundCompletePlaying_			
		}
		public function playSound2(url : String , times : int = 1, x : Object = null, fxDone : Function = null ) : void
		{
			//PlatformGlobals.show('play ' + url ) ; 
			/*if ( currentSoundId !=  -1 ) 
			this.stopSound();*/
			//url = "G:/My Documents/work/mobile3/SoundBoardEllips/bin-debug/assets/sub/gow/sounds/Baird - No shit.mp3"
			
			if ( this.cpu ) 
			{
				
				var pattern2:RegExp = new RegExp("\\", "gi");
				url = url.replace(pattern2, '/' )
				var pattern:RegExp = /(\)/g; 
				url = url.replace(pattern, '/' )
				pattern  = /\\/g
				url = url.replace(pattern, '/' )
				Alert.show(url, 'url' ) ; 
				
				var soundID:int = SystemAPI.loadSoundFile(url);
				if ( soundID == -1 ) 
				{
					//try agin 
					trace( 'again 1', soundID ); 
					soundID = SystemAPI.loadSoundFile(url);
					/*trace( 'again 2', soundID ); 
					soundID = SystemAPI.loadSoundFile(url);*/
				}
				//if same url, id is -1, but the current sound is playing ... replay it ...
				if ( oldUrl == url && soundID == -1 &&  this.currentSoundId != -1 )
				{
					trace( 'replay', soundID, currentSoundId ) ; 
					this.stopSound();
					soundID = SystemAPI.loadSoundFile(url);
					SystemAPI.playSoundFile(currentSoundId);
					return; 
				}
				else
				{
					if ( this.currentSoundId != -1 )
					{
						if ( soundID !=  -1 ) 
							this.stopSound();
						//	SystemAPI.stopSoundFile(currentSoundId);
					}
				}
				oldUrl = url; 
				trace( 'play', soundID, currentSoundId ) ; 
				currentSoundId = soundID; 
				SystemAPI.playSoundFile(soundID);
			}
			else
			{
				/*if ( this.currentSoundId != -1 )
				{
				//if ( soundID !=  -1 ) 
				this.stopSound();
				//	SystemAPI.stopSoundFile(currentSoundId);
				}
				soundID = SystemAPI.loadSoundFile(url);
				if ( soundID == -1 ) 
				{
				//try agin 
				trace( 'again 1', soundID ); 
				soundID = SystemAPI.loadSoundFile(url);
				}
				Alert.show(soundID.toString(), 'play'); 
				SystemAPI.playSoundFile(soundID);*/
				
				
				if ( this.currentSoundId != -1 )
				{
					//if ( soundID !=  -1 ) 
					this.stopSound();
					//	SystemAPI.stopSoundFile(currentSoundId);
				}
				soundID = SystemAPI.loadSoundFile(url);
				
				if ( soundID == -1 ) 
				{
					//try agin 
					
					trace( 'again 1', soundID ); 
					soundID = SystemAPI.loadSoundFile(url);
					/*trace( 'again 2', soundID ); 
					soundID = SystemAPI.loadSoundFile(url);*/
				}
				/*			
				soundID = SystemAPI.loadSoundFile(url);
				trace( 'after 1', soundID ); 
				if ( soundID == -1 ) 
				{
				//try agin 
				trace( 'again 1', soundID ); 
				soundID = SystemAPI.loadSoundFile(url);
				}*/
				
				//Alert.show(soundID.toString(), 'play'); 
				SystemAPI.playSoundFile(soundID);
				SystemAPI.playSoundFile(soundID);
				this.currentSoundId= soundID
			//	PlatformGlobals.show('play sound sound '  + this.currentSoundId  )
			}
			
			this.fxCallAfterSoundCompletePlaying = fxDone; 
			//SystemAPI.pauseSoundFile(soundID);
			//soundID = SystemAPI.loadSoundFile(url);
			/*	trace( '1', soundID ); 
			soundID = SystemAPI.loadSoundFile(url);
			trace( '2', soundID ); 
			soundID = SystemAPI.loadSoundFile(url);
			trace( '3', soundID ); */
			
			if ( addedEventListner == false  ) 
			{
				addedEventListner = true
				SystemAPI.dispatcher.addEventListener(SystemAPI.AUDIO_FILE_ENDED, onSoundComplete);
			}
		}
		
		protected function onSoundComplete(event:Event):void
		{
			//PlatformGlobals.show('stop sound '  + this.currentSoundId  )
			this.stopSound(); 
			if ( fxCallAfterSoundCompletePlaying != null ) 
				fxCallAfterSoundCompletePlaying(event); 
			
		}
		
		public function stopSound():void{
			if ( this.currentSoundId != -1 )
			{
				trace( 'stop', currentSoundId ) ; 
				SystemAPI.stopSoundFile(currentSoundId);
				SystemAPI.unloadSoundFile(currentSoundId);
				this.currentSoundId = -1
			}
		}
		
	}
}