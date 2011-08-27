package org.syncon.Customizer
{
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	import org.syncon.Customizer.controller.*;
	import org.syncon.Customizer.controller.IO.*;
	import org.syncon.Customizer.model.CustomEvent;
	import org.syncon.Customizer.model.NightStandConstants;
	import org.syncon.Customizer.model.NightStandModel;
	import org.syncon.popups.controller.default_commands.ShowAlertMessageTriggerEvent;
	import org.syncon2.utils.SubContext;
	import org.syncon2.utils.mobile.AndroidExtensions;
	
	public class ContextNightStand extends Context
	{
		public function ContextNightStand()
		{
			super();
		}
		override public function startup():void
		{
			// Model
			injector.mapSingleton( NightStandModel )		
			
			//	GetInitDataCommandTriggerEvent.mapCommands( this.commandMap, GetInitDataCommand )
			InitMainContextCommandTriggerEvent.mapCommands( this.commandMap, InitMainContextCommand ); 
			
			this.commandMap.mapEvent( CreateDefaultDataTriggerEvent.CREATE, CreateDefaultDataCommand );

			this.commandMap.mapEvent( ExportJSONCommandTriggerEvent.EXPORT_JSON, ExportJSONCommand );
			this.commandMap.mapEvent( ImportJSONCommandTriggerEvent.IMPORT_JSON, ImportJSONCommand );

			
			EditProductCommandTriggerEvent.mapCommands( this.commandMap, EditProductCommand ) ; 
			EditProductCommandTriggerEvent.fxAnimate = this.dispatchEvent; 
			ConfigCommandTriggerEvent.mapCommands( this.commandMap, ConfigCommand); 
			
			this.loadSubContexts()			
			super.startup();
			this.initStage()
			
			if ( doInit == false ) {trace('this.context.loadConfig( ) ; ', 'skipped init'); return;} 
			var wait : Boolean = false;
			if ( wait ) 
			{
				import flash.utils.setTimeout;
				setTimeout( this.onInit, 1500 )
			}
			else
				this.onInit()	
			//this.dispatchEvent( new Event( CreateDefaultDataCommand.START ))
			//this.dispatchEvent( new CreatePopupEvent( CreatePopupEvent.REGISTER_AND_CREATE_POPUP, popup_modal_bg, 'popup_modal_bg', true ) );
			
			
		}
		override public function set contextView(value:DisplayObjectContainer):void
		{
			super.contextView = value;
			listenForMediation()
		}
		public function listenForMediation(): void
		{
			this.contextView.addEventListener( 'mediate', this.onMediate ) ; 
		}
		protected function onMediate(event:CustomEvent):void
		{
			this.mediatorMap.createMediator( event.data) 
		}
		
		public function addSubContext( _subContext : SubContext ) : void
		{
			this.subContexts.push(_subContext)
		}
		/**
		 * Prevents onInit from being called, 
		 * fill in models with fake information 
		 * */
		public var doInit : Boolean = true; 
		//private var subContext : EvernoteBasicPopupContext = new EvernoteBasicPopupContext()
		private function onInit() : void
		{
			//this.dispatchEvent( new Event( CreateDefaultDataCommand.START ))
			//this.dispatchEvent( new Event( CreateDefaultDataCommand.LIVE_DATA ))
			//this.subContext.onInit(); 
		}
		
		
		public function initStage() : void
		{
			this.dispatchEvent( new InitMainContextCommandTriggerEvent(
				InitMainContextCommandTriggerEvent.INIT, NightStandConstants.showAds, NightStandConstants.flex ) ) ; 
			
			this.dispatchEvent( new InitMainContextCommandTriggerEvent(
				InitMainContextCommandTriggerEvent.INIT2 ) ) ; 
			
			this.dispatchEvent( new InitMainContextCommandTriggerEvent(
				InitMainContextCommandTriggerEvent.INIT3_MAKEUP_FLEX_DATA ) ) ; 
			
			this.dispatchEvent( new ImportJSONCommandTriggerEvent(
				ImportJSONCommandTriggerEvent.IMPORT_JSON,this.importJsonStr)) ; 
			/*
			this.dispatchEvent( new LoadSoundsTriggerEvent(
			LoadSoundsTriggerEvent.LOAD_SOUNDS ) ) ; 
			this.dispatchEvent( new LoadPortCommandTriggerEvent(
			LoadPortCommandTriggerEvent.LOAD_PORT ) ) ; 			
			
			*/
			/*this.dispatchEvent( new LoadLessonPlanTriggerEvent(
			LoadLessonPlanTriggerEvent.LOAD_LESSON_PLAN ) ) ;
			*/
			/*	this.dispatchEvent( new LoadUnitsCommandTriggerEvent(
			LoadUnitsCommandTriggerEvent.LOAD_UNITS, '', false  ) ) ;
			
			
			this.dispatchEvent( new ConfigCommandTriggerEvent(
			ConfigCommandTriggerEvent.LOAD_CONFIG, configName ) );
			*/
			AndroidExtensions.FxError = this.onAlert; 
		}
		
		public var configName : String = ''; 
		
		public function onAlert(msg : String ) : void
		{
			this.dispatchEvent( new ShowAlertMessageTriggerEvent( ShowAlertMessageTriggerEvent.SHOW_ALERT_POPUP, msg  )  ) 
		}
		
		private function loadSubContexts() : void
		{
			for each ( var _subContext : SubContext in this.subContexts ) 
			{
				_subContext.subLoad( this, this.injector, this.commandMap, this.mediatorMap, this.contextView ) 		
			}
		}
		
		public var subContexts : Array = []; 
		private var importJsonStr:String;
		
		public function importJson(str:String):void{
				this.importJsonStr=str;

			
		}
		public function newMultipler( n : Number ) : void
		{
			this.dispatchEvent( new InitMainContextCommandTriggerEvent(
				InitMainContextCommandTriggerEvent.SET_MULTIPLER,false, false, n ) ) ; 
		}
		
		public function mapMediator(view:Object=null) : void
		{
			mediatorMap.createMediator(view)
		}
		
		
		
		
		
		
	}
}