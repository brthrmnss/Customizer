package org.syncon2.utils.sound
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	import mx.core.SoundAsset;
	
	import org.syncon.Customizer.controller.GetSoundTriggerEvent;
	import org.syncon.Customizer.model.NightStandConstants;
	import org.syncon.TalkingClock.vo.SoundVO;
	
	public class  PlaySound_Flex implements  IPlaySound
	{
		public function  get  fxCallAfterSoundCompletePlaying (  ) : Function
		{
			return this._fxCallAfterSoundCompletePlaying  
		}
		public function set fxCallAfterSoundCompletePlaying ( fx : Function ) : void
		{
			this._fxCallAfterSoundCompletePlaying = fx; 
		}
		private var _fxCallAfterSoundCompletePlaying:Function;
		
		public var song:SoundAsset;
		
		public var soundControl:SoundChannel;
		
		public var sound : Sound; 
		public function playSound( s : SoundVO, fxCallAfterSoundCompletePlaying_ : Function = null ) : void
		{
			//NightStandConstants.PlaySound.playSound( s, fxCallAfterSoundCompletePlaying_ ); 
			this.playSound2( s.url ); 
			this.fxCallAfterSoundCompletePlaying = fxCallAfterSoundCompletePlaying_
		}
		public function playSound2(url : String , times : int = 1 ) : void
		{
			
			var soundReq:URLRequest = new URLRequest(url);
			/*var e : GetSoundTriggerEvent = new GetSoundTriggerEvent( GetSoundTriggerEvent.GET_SOUND , url ) 
			this.dispatch( e ) 
			if ( e.urlReq != null ) 
				soundReq = e.urlReq*/
			if ( sound != null ) 
			{this.stopSound()}
			this.sound = new Sound(); 
			soundControl = new SoundChannel(); 
			//sound.addEventListener(Event.COMPLETE, completeSound);
			/*sound.addEventListener(Event.COMPLETE, completeHandler);
			sound.addEventListener(Event.ID3, id3Handler);
			sound.addEventListener(IOErrorEvent.IO_ERROR, ioSoundErrorHandler);
			sound.addEventListener(ProgressEvent.PROGRESS, progressHandler);*/
			sound.load(soundReq); 
			if ( times == 0 ) 
				times = int.MAX_VALUE
			soundControl = sound.play(0,times);
			soundControl.addEventListener(Event.SOUND_COMPLETE, this.onSoundComplete ) ; 
		}
		
		protected function onSoundComplete(event:Event):void
		{
			if ( fxCallAfterSoundCompletePlaying != null ) 
				fxCallAfterSoundCompletePlaying(event); 
		}
		
		public function stopSound():void{
			if ( sound != null ) 
			{
				soundControl.stop();
				soundControl.removeEventListener(Event.COMPLETE,onSoundComplete);
			}
			sound = null;
		}
		
		
	}
}