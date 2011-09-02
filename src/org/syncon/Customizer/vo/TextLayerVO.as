package  org.syncon.Customizer.vo
{
	public class TextLayerVO  extends  LayerBaseVO
	{
		
		static public const PROP_TEXT_ALIGN : String = 'PROP_TEXT_ALIGN' ; 
		static public const PROP_VERTICAL_TEXT_ALIGN : String = 'PROP_VERTICAL_TEXT_ALIGN'; 
		public var text : String = ''; 
		
		public static var Type:String= 'TEX';
		public var fontSize:int = 12;
		public var fontFamily : String;// = ''; 
		public var color:*;
		public var sizingSettings: String;
		/**
		 * maxChars must be set for this to work.
		 * */
		public static var SIZING_AUTO_SIZE: String = 'sizingAuto';
		public var maxChars: int = -1 ;
		public var minFontSize: Number = -1 ;
		public var maxFontSize: Number = -1 ;
		public var default_text:String= 'Add Text';
		public var orientation:String ="Horizontal";
		[Transient] public var  fonts : Array = []; 
		
		/**
		 * Adjusts the font size based on autosizing options
		 * */
		public function setFontSize () : void
		{
			if ( this.sizingSettings == TextLayerVO.SIZING_AUTO_SIZE ) 
			{
				if ( this.maxChars <= 0 ) 
					throw 'Max Chars for layer ' + this.name + ' is too small: ' + this.maxChars
				var steps :  Number =( this.maxFontSize - this.minFontSize)/this.maxChars; 
				var dbg : Array = [this.maxFontSize - this.minFontSize, this.maxFontSize, this.minFontSize]
				var charCount : int = this.text.length; 
				var newFontSize : Number = this.maxFontSize - charCount*steps
				/*this.dispatch( new EditProductCommandTriggerEvent ( 
				EditProductCommandTriggerEvent.CHANGE_FONT_SIZE, newFontSize 
				) )  */
				var newFontSize2 : int = int( newFontSize ); 
				if ( fontSize ==  newFontSize2   )
					return; 
				fontSize =newFontSize2
				update('fontSize'); 
			}
		}
		public var horizontalTextAlignment : String = 'center'; 
		public var verticalTextAlignment : String = 'middle'; 
		
		public var verticalText : Boolean = false; 
		/**
		 * Thsi is the setting that the textinput uses to show text ... 
		 * */
		public var displayText : String = ''; 
		
		public function adjustDisplayText () : void
		{
			if ( this.verticalText )
			{
				var newText: String = ''; 
				for ( var i : int= 0; i < this.text.length ; i++ )
				{
					var char :  String = this.text.charAt( i ) 
					newText += char 
					if ( i != this.text.length -1 )
					{
						newText += '\n'
					}
				}
				this.displayText =  newText
				//
			}
			else
			{
				this.displayText = this.text; 
			}
			
		}
		
		
		public override function  get type():String
		{
			return Type;
		}
		
		override public function get displayName():String
		{
			return [this.name , '(', this.text, ')' ].join(' ');
		}
		
		
		override  public function clone() : LayerBaseVO
		{
			var textLayer : TextLayerVO = new TextLayerVO()
			this.copyPropsTo(textLayer)  
			textLayer.text = this.text; 
			textLayer.fontSize = this.fontSize
			textLayer.fontFamily = this.fontFamily
			textLayer.color = this.color
			textLayer.sizingSettings = this.sizingSettings
			textLayer.maxChars = this.maxChars
			textLayer.minFontSize = this.minFontSize
			textLayer.maxFontSize = this.maxFontSize
			textLayer.default_text = this.default_text
			textLayer.orientation = this.orientation
			textLayer.verticalText = this.verticalText; 
			textLayer.verticalTextAlignment = verticalTextAlignment; 
			textLayer.horizontalTextAlignment = horizontalTextAlignment; 
			textLayer.displayText = this.displayText
			textLayer.fonts = this.fonts
			return textLayer; 
		}
	}
}