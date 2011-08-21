package  org.syncon.Customizer.vo
{
	public class ImageLayerVO  extends  LayerBaseVO
	{
		public var hiSpeedMode : Boolean = true; 
		
		public static var Type:String= 'IMAGE';
		public var mask:Boolean;
		public override function get type():String 	{ return Type; }
		
	}
}