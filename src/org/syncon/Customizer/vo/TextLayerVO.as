package  org.syncon.Customizer.vo
{
	public class TextLayerVO  extends  LayerBaseVO
	{
		public var text : String = ''; 
		
		public static var Type:String= 'TEX';
		public var fontSize:int = 12;
		public var fontFamily : String = ''; 
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
		public var subType:Object;
		public var orientation:String ="Horizontal";
		public function setFontSize () : void
		{
			if ( this.sizingSettings == TextLayerVO.SIZING_AUTO_SIZE ) 
			{
				var steps :  Number =( this.maxFontSize - this.minFontSize)/this.maxChars; 
				var charCount : int = this.text.length; 
				var newFontSize : Number = this.maxFontSize - charCount*steps
				/*this.dispatch( new EditProductCommandTriggerEvent ( 
				EditProductCommandTriggerEvent.CHANGE_FONT_SIZE, newFontSize 
				) )  */
				fontSize = int( newFontSize ); 
				update('fontSize'); 
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
			return textLayer; 
		}
	}
}