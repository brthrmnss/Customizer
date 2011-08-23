package org.syncon.Customizer.model
{
	import com.roguedevelopment.objecthandles.ObjectHandles;
	
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.utils.getQualifiedClassName;
	
	import flashx.undo.UndoManager;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	
	import org.robotlegs.mvcs.Actor;
	import org.syncon.Customizer.controller.EditProductCommandTriggerEvent;
	import org.syncon.Customizer.vo.*;
	import org.syncon.popups.controller.default_commands.ShowAlertMessageTriggerEvent;
	
	public class NightStandModel extends Actor 
	{
		public var ready : Boolean = false; 
		public function onReady() : void
		{
			this.ready = true 
			this.dispatch( new NightStandModelEvent(NightStandModelEvent.EVERNOTE_API_MODEL_READY) ) 
		}
		
		public function NightStandModel()
		{
		}		
		
		public var undo  : UndoManager = new UndoManager(); 
		
 
		
		private var timerRefreshToken : Timer = new Timer(1501,1 ); 
		private var timer_Alarms : Timer = new Timer(1000*60/60,0 ); 
		
		public var loggedIn:Boolean;
		public var currentUser:Object;
		public var showAds:Object;
		/*		private var _config: RosettaStoneConfig;
		
		public function get config(): RosettaStoneConfig
		{
		return _config;
		}
		
		public function set config(value:RosettaStoneConfig):void
		{
		currentConfigSet = true; 
		_config = value;
		this.dispatch( new NightStandModelEvent( NightStandModelEvent.CONFIG_CHANGED ) ) 
		}
		*/
		
		private var _automating : Boolean = false; 
		public function get automating(): Boolean
		{
			return _automating;
		}
		
		public function set automating(value:Boolean):void
		{
			_automating = value;
			this.dispatch( new NightStandModelEvent( NightStandModelEvent.AUTOMATING_CHANGED ) ) 
		}
		
		public function layersChanged() : void
		{
			this.dispatch( new NightStandModelEvent( NightStandModelEvent.LAYERS_CHANGED ) ) 
		}
		
		private var _loadedLastLesson : Boolean = false; 
		public function get loadedLastLesson(): Boolean
		{
			return _loadedLastLesson;
		}
		
		public function set loadedLastLesson(value:Boolean):void
		{
			_loadedLastLesson = value;
			if ( value == true ) 
				this.dispatch( new NightStandModelEvent( NightStandModelEvent.LOADED_LAST_LESSON ) ) 
		}
		
		public var flex:Boolean;
		public var currentConfigSet:Boolean=false;
		private var _multipler:Number=1;
		
		public function get multipler():Number
		{
			return _multipler;
		}
		
		public function set multipler(value:Number):void
		{
			_multipler = value;
			this.dispatch( new NightStandModelEvent(NightStandModelEvent.MULTIPLER_CHANGED ) ) ; 
		}
		
		
		
		public function logout():void
		{
			this.loggedIn= false; 
			this.currentUser = null; 
		}
		
		private var _layersVisible : ArrayCollection = new ArrayCollection( ); 
		public function get layersVisible():ArrayCollection
		{
			return _layersVisible;
		}
		
		private var _layers : ArrayCollection = new ArrayCollection( ); 
		public function get layers():ArrayCollection
		{
			return _layers;
		}
		public function set layers(value:ArrayCollection):void
		{
			_layers = value;
		}
		/**
		 * used when importing items
		 * */
		public function loadLayers(value: Array):void
		{
			this.addAllTo( this.layers, value )
			this.recreateDisplayableLayers(); 
			this.layersChanged() ; 
		}
		
		
		private var _images : ArrayCollection = new ArrayCollection( ); 
		public function get images():ArrayCollection
		{
			return _images;
		}
		public function set images(value:ArrayCollection):void
		{
			_images = value;
		}
		public function loadImages(value: Array):void
		{
			this.addAllTo( this.images, value )
			//this.dispatch( new NightStandModelEvent( NightStandModelEvent.UNITS_CHANGED, value ) ) 
		}
		
		
		
		private var _baseItem:  StoreItemVO;
		public function get baseItem(): StoreItemVO 	{ return _baseItem; }
		public function set baseItem(value:StoreItemVO):void { 
			var e : Event =  new NightStandModelEvent( NightStandModelEvent.BASE_ITEM_CHANGING, value )
			this.dispatch( e ) 
			if ( e.isDefaultPrevented() ) 
				return; 
			_baseItem = value;
			this.layers = value.lists; 
			this.dispatch( new EditProductCommandTriggerEvent(
				EditProductCommandTriggerEvent.LOAD_PRODUCT, value ) ) ; 
			
			this.dispatch( new NightStandModelEvent( NightStandModelEvent.BASE_ITEM_CHANGED, value ) ) 
		}
		
		private var _currentLayer:  LayerBaseVO;
		public function get currentLayer(): LayerBaseVO 	{ return _currentLayer; }
		public function set currentLayer(value:LayerBaseVO):void { 
			var e : Event =  new NightStandModelEvent( NightStandModelEvent.CURRENT_LAYER_CHANGING, value )
			this.dispatch( e ) 
			if ( e.isDefaultPrevented() ) 
				return; 
			_currentLayer = value;
			//this.dispatch( new EditProductCommandTriggerEvent(
			//	EditProductCommandTriggerEvent.LOAD_PRODUCT, value ) ) ; 
			
			this.dispatch( new NightStandModelEvent( NightStandModelEvent.CURRENT_LAYER_CHANGED, value ) ) 
		}
		
		/*	
		
		public function setOdbs(e:Array, append : Boolean=false) : void
		{
		this.addAllTo( this._stories, e, append ) 
		this.dispatch( new NightStandModelEvent( NightStandModelEvent.LOADED_ODBS, e ) ) 
		}		
		
		public function loadOdb(e: OdbVO, append : Boolean=false) : void
		{
		//this.addAllTo( this._stories, e, append ) 
		this.currentOdb = e; 
		this.dispatch( new NightStandModelEvent( NightStandModelEvent.LOADED_ODB, e ) ) 
		}		
		
		
		
		public function onFailLoadList( ) : void
		{
		this.dispatch( new NightStandModelEvent( NightStandModelEvent.LOAD_ODBS_FAULT ) ) 
		}		
		*/
		
		/*
		public function getWidgetMenuItems() : Array
		{
		var labels : Array = ['Theme Settings', 'Config', 'Change Theme', 'Alarms', 'Help' ]
		var fxs : Array = [ null, this.onGlobalConfig, this.onChangeTheme, this.onAlarms, this.onHelp ]
		var arr : Array = [] 
		for ( var i : int = 0 ; i < labels.length; i++ )
		{
		arr.push( [labels[i], fxs[i]] ) 
		}
		return arr; 
		}
		*/
		protected function onGlobalConfig(event:Event):void
		{ 
			
		}
		
		
		private var _fontSize : Number = NaN; 
		
		
		private var _alarmList : ArrayCollection = new ArrayCollection( ) ; 
		
		public function get alarmList():ArrayCollection
		{
			return _alarmList;
		}
		
		public function set alarmList(value:ArrayCollection):void
		{
			_alarmList = value;
		}
		public function loadAlarms(value: Array):void
		{
			this.addAllTo( this.alarmList, value )
		}
		
		
		
		private var _voiceList : ArrayCollection = new ArrayCollection( ) ; 
		private var _mute:Boolean=false;
		private var fxCallAfterSoundCompletePlaying:Function;
		/*	
		public function get fxCallAfterSoundCompletePlaying():Function
		{
		return _fxCallAfterSoundCompletePlaying;
		}
		
		public function set fxCallAfterSoundCompletePlaying(value:Function):void
		{
		_fxCallAfterSoundCompletePlaying = value;
		}
		*/
		public var port:Number;
		public var viewer: Object;
		public var objectHandles:ObjectHandles;
		public var baseLayer:LayerBaseVO;// = new LastOperationStatus(); ;
		public var layerMask:LayerBaseVO;
		/**
		 * Store the last added undo item so we can compare it later
		 * */
		public var lastUndo: EditProductCommandTriggerEvent;
		/**
		 * When undoing moving and resizing ... do not allow adding further undos 
		 * */
		public var blockUndos:Boolean;
		/**
		 * hardcoded reference to color layer 
		 * in future, use strings references based on type 
		 * */
		public var layerColor:ColorLayerVO;
		
		public function get mute():Boolean
		{
			return _mute;
		}
		
		public function set mute(value:Boolean):void
		{
			if ( mute == value ) return; 
			_mute = value;
			this.dispatch(new NightStandModelEvent( NightStandModelEvent.MUTE_CHANGED ) ) 
		}
		
		
		public function get voiceList():ArrayCollection
		{
			return _voiceList;
		}
		
		public function set voiceList(value:ArrayCollection):void
		{
			_voiceList = value;
		}
		public function loadVoices(value: Array):void
		{
			this.addAllTo( this.voiceList, value )
		}
		
		public function addLayer(layer : LayerBaseVO ) : void
		{
			this.layers.addItem( layer ) ; 
			this.recreateDisplayableLayers()
			this.layersChanged();
		}
		
		private function recreateDisplayableLayers():void
		{
			var newLayersVisible : Array = []; 
			for each ( var l : LayerBaseVO in this.layers.toArray() ) 
			{
				if ( l.showInList == false ) 
					continue; 
				newLayersVisible.push( l ) 
			}
			if ( newLayersVisible.length == this.layersVisible.length ) 
				return; 
			
			this.addAllTo( this.layersVisible, newLayersVisible )
		}
		
		public function removeLayer( layer : LayerBaseVO ) : void
		{
			var index : int = this.layers.getItemIndex( layer ) ;
			this.layers.removeItemAt( index ) ; 
			this.recreateDisplayableLayers()
			this.layersChanged();
		}
		
		public function collect() : void
		{
			this.dispatch( new NightStandModelEvent(NightStandModelEvent.COLLECT
			) ) ; 
		}
  
		private function addAllTo( e:ArrayCollection, arr : Array, append : Boolean = false ) : void
		{
			if ( append == false ) 
			{
				e.source = arr; 
				e.refresh()
			}
			else
			{
				e.addAll( new ArrayList( arr ) ) ; 
				//e.refresh(); 
			}
		}
		
		public function getLayersByType(clazz : Class ) :  Array
		{
			var className : String = getQualifiedClassName( clazz ) 
			var found : Array = [] ; 
			for each ( var l : LayerBaseVO in this.layers ) 
			{
				if (getQualifiedClassName(l) == className ) 
					found.push(l)
			}
			return found; 
		}
		
		
		public function isDescendent( e : Object , againsts : Object ) : Boolean 
		{
			var par : Object = e; 
			do 
			{
				par = par.parent //as UIComponent
				if ( par == againsts ) 
					return true
				
			}	while ( par.parent != null )
			
			return false 
		}
		
		public function alert( str : String, title : String = '' ) : void
		{
			this.dispatch( new ShowAlertMessageTriggerEvent(
				ShowAlertMessageTriggerEvent.SHOW_ALERT_POPUP, 
				str, title  )  ) 
		}
	}
}