package  org.syncon.Customizer.vo
{
	public class TextLayerVO  extends  LayerBaseVO
	{
		public var text : String = ''; 
		
		public static var Type:String= 'TEX';
		public var fontSize:int = 12;
		public var fontFamily : String = ''; 
		public var color:*;
		public override function  get type():String
		{
			return Type;
		}
		
		override public function get displayName():String
		{
			return [this.name , '(', this.text, ')' ].join(' ');
		}
	}
}