package  org.syncon2.utils
{
	public class  MakeVOs 
	{
		
		static public function makeObjs(names  :  Array, class_ : Class, nameField : String ): Array
		{
			var output : Array = [] ; 
			for each ( var name : String in names ) 
			{
				var o : Object = new class_() 
				o[nameField] = name; 
				output.push(o)
			}
			
			return output
		}			
		
	}
}