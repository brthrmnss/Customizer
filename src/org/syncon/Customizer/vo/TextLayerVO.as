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
		
		
		override  public function clone() : LayerBaseVO
		{
			//var d :  Object = super.clone(); 
			var img : TextLayerVO = new TextLayerVO()
			this.copyPropsTo(img)  
			img.text = this.text; 
			img.fontSize = this.fontSize
			img.fontFamily = this.fontFamily
			img.color = this.color
			img.fontSize = this.fontSize
			return img; 
		}
	}
}