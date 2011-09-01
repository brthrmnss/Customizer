package org.syncon.Customizer.vo
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.syncon.Customizer.view.ui.SimpleDataModel;
	import org.syncon.onenote.onenotehelpers.base.IListVO;
	
	public class LayerBaseVO extends EventDispatcher implements IListVO
	{
		static public var UPDATED : String = 'LayerBaseVOOmupdated';
		public function update(prop:String='') : void
		{
			propChanged = prop
			this.dispatchEvent( new Event( UPDATED  ) ) ; 
			this.propChanged = ''; 
		}
		
		static public var LAYER_VISIBLITY : String = 'LAYER_VISIBLITY';
		public function updateVisibility(prop:String='') : void
		{
			this.dispatchEvent( new Event( LAYER_VISIBLITY  ) ) ; 
		}
		
		static public var LAYER_REMOVED : String = 'LAYER_REMOVED';
		public function layerRemoved( ) : void
		{
			this.dispatchEvent( new Event( LAYER_REMOVED  ) ) ; 
		}
		
		static public var LAYER_REDD : String = 'LAYER_REDD';
		public function layerReAdded( ) : void
		{
			this.dispatchEvent( new Event( LAYER_REDD  ) ) ; 
		}
		
		static public var LAYER_SELEECTED : String = 'LAYER_SELEECTED';
		public function layerSelected( ) : void
		{
			this.dispatchEvent( new Event( LAYER_SELEECTED  ) ) ; 
		}
		
		
		/**
		 * .
		 * USed by x so we don't have to setStyle constantly 
		 * */
		public var propChanged : String = ''; 
		/**
		 * pretty name, sometimes overridden by subclasses
		 * */
		public function get displayName():String
		{
			return this.name;
		}
		public function get aaa():String
		{
			return [this.name, this.x, this.y, this.width, this.height,this.rotation].join(', ' ) 
		}
		//public var name : String = ''; // : Boolean = true; 
		private var _url : String = ''; 
		
		public function get url():String
		{
			return _url;
		}
		
		public function set url(value:String):void
		{
			_url = value;
		}
		
		public var rotation:Number = 0;
		public var subType:Object;
		public var visible : Boolean = true; 
		public var locked : Boolean = false; 
		public var required : Boolean = false;
		
		public var location :  String = '' // = false; 
		
		public var _cost :  Number = 0
		public function get cost():Number
		{
			return _cost;
		}
		
		public function set cost(value:Number):void
		{
			_cost = value;
		}
		
		
		
		/**
		 * This layer cannot be deleted
		 * */
		public var prompt_layer : Boolean = false; 
		
		public var showInList : Boolean = true; 		
		public var data2:Object; 
		public static var Type:String= 'LED';
		public function get type():String
		{
			return Type;
		}
		/**
		 * The other height includes the chrome (and is set by the viewer3 component ) 
		 * this only includes the ui component
		 * */
		public var nonChromeHeight : Number = 0; 
		public var nonChromeWidth : Number = 0;
		
		private var _name : String = ''; 
		private var _x : Number; 
		private var _y : Number;	 
		private var _height : Number; 
		private var _width : Number;
		
		private var _loadedIntoLister : Object; 
		private var _data : Object = new Object();
		public var vertStartAlignment: String = 'center' ;
		public var horizStartAlignment: String='center';
		
		public static const ALIGNMENT_CENTER : String = 'center' 
		/**
		 * will not auto center, will be placed relative to base image XY
		 * */
		public static const ALIGNMENT_NONE : String = ''; 
		/**
		 * will be placed directly on the stage
		 * */
		public static const ALIGNMENT_FREEFORM : String = ''; 
		/**
		 * Store this here so we can unselect obojects on the stage 
		 * */
		public var model:SimpleDataModel;
		public var repositionedOnce:Boolean=false;
		
		/**
		 * ONly to be used with no alignment, 
		 * this is the inisialy xy set on the layer
		 * */
		public var importX:Number;
		public var importY:Number;
		/**
		 * turns of alignment options after first time ...
		 * */
		//public var movedOnce:Boolean;
		
		public function get width():Number
		{
			return _width;
		}
		
		public function set width(value:Number):void
		{
			if ( this._width == value ) 
				return; 
			if ( value < 100 ) 
			{
				trace('LayerBaseVO','value', 'ListVO' ) ; 
			}
			_width = value;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}
		
		/**
		 * Storage of lister list is being loaded into ... temp ... use dictionary 
		 * */
		public function get loadedIntoLister():Object
		{
			return _loadedIntoLister;
		}
		
		/**
		 * @private
		 */
		public function set loadedIntoLister(value:Object):void
		{
			_loadedIntoLister = value;
		}
		
		[Transient]
		public function get data(): Object
		{
			return this; 
			//return self ... in future, override set data proprety 
			return this._data; //this;
		}
		
		public function set data(value:Object):void
		{
			_data = value;
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		public function set y(value:Number):void
		{
			_y = value;
		}
		
		public function get x():Number
		{
			return _x;
		}
		
		public function set x(value:Number):void
		{
			if ( _x == value )
				return; 
			/*if ( this.type == TextLayerVO.Type  && this.url != 'demo'  ) 
			{
				trace('thing'); 
			}*/
			_x = value;
		}
		
		public function set height ( value : Number ) : void
		{
			if ( this._height == value ) 
				return; 
			if ( value < 100 ) 
			{
				trace('LayerBaseVO','small ehight set', 'ListVO' ) ; 
			}
			/*if ( h != 237 ) 
			{
			trace('LayerBaseVO','not 237' ) ; 
			}
			if ( this.type == TextLayerVO.Type ) 
			{
			if ( h != 50 ) 
			{
			trace('texter layer type'); 
			}
			}*/
			this._height = value; 
		}
		public function get height () : Number 
		{
			return this._height 
		}		
		
		
		
		public function importObj ( on : Object, obj : Object) : void 
		{
			/*		ObjectUtil.getClassInfo(object)
			
			obj
			var props : Object = ObjectUtil.getClassInfo( obj[0] ) 
			
			
			for each ( var prop : QName in props.properties ) 
			{
			if ( on.hasOwnProperty( prop.localName ) )
			on[prop.localName] = obj[prop.localName] 
			}
			}*/
			for ( var k : Object in obj ) 
			{
				
				if ( k == 'type' ) continue; 
				
				try {
					on[k] = obj[k]
				}
				catch ( e : Error ) 
				{
					trace('skipped attribute' , k); 
				}
			}
			return ;
		}
		
		public function setXY(oldData:Object, oldData2:Object):void
		{
			var xx : Number = oldData as Number
			var yy : Number = oldData2 as Number
			this.x = xx
			this.y = yy; 
			if ( this.model != null ) 
			{
				this.model.x = xx
				this.model.y = yy; 
			}
			
		}
		
		public function setWH(oldData:Object, oldData2:Object):void
		{
			var ww : Number = oldData as Number
			var hh : Number = oldData2 as Number
			this.width = ww
			this.height = hh; 
			if ( this.model != null ) 
			{
				this.model.width = ww
				this.model.height = hh; 
			}
			
		}
		
		import flash.utils.describeType;
		import flash.utils.getDefinitionByName;
		import flash.utils.getQualifiedClassName;
		public function copyPropsTo(clone :  LayerBaseVO): void
		{
			/*	for   ( var prop  : String in this ) 
			{
			clone[prop] = this[prop]
			}*/
			copyData(this, clone ); 
		}
		
		
		public static function copyData(source:Object, destination:Object):void {
			
			//copies data from commonly named properties and getter/setter pairs
			if((source) && (destination)) {
				
				try {
					var sourceInfo:XML = describeType(source);
					var prop:XML;
					
					for each(prop in sourceInfo.variable) {
						
						if(destination.hasOwnProperty(prop.@name)) {
							destination[prop.@name] = source[prop.@name];
						}
						
					}
					
					for each(prop in sourceInfo.accessor) {
						if(prop.@access == "readwrite") {
							if(destination.hasOwnProperty(prop.@name)) {
								destination[prop.@name] = source[prop.@name];
							}
							
						}
					}
				}
				catch (err:Object) {
					;
				}
			}
		}
		
		public function clone() : LayerBaseVO
		{
			return null; 
		}
	}
}