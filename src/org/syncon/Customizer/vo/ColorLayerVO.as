package  org.syncon.Customizer.vo
{
	/**
	 * url refers to mask image, 
	 * color is color of background .... 
	 * */
	public class ColorLayerVO  extends  LayerBaseVO
	{
		public var text : String = ''; 
		
		public static var Type:String= 'Color';
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