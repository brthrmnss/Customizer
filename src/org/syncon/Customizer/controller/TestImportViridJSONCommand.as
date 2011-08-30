package  org.syncon.Customizer.controller
{
	import org.robotlegs.mvcs.Command;
	import org.syncon.Customizer.model.NightStandModel;
	
	/**
	 * This class imports a json string into virid json importer
	 * to avoid having to use browser params 
	 * this is called automatically fromcontext, 
	 * but will not run if json is set on flashvars. 
	 * */
	public class TestImportViridJSONCommand extends Command
	{
		[Inject] public var model:NightStandModel;
		[Inject] public var event:TestImportViridJSONCommandTriggerEvent;
		
		override public function execute():void
		{
			if ( event.type == TestImportViridJSONCommandTriggerEvent.TEST_IMPORT_VIRID_JSON ) 
			{
				this.importJSON()
			}	
			
			
		}
		
		
		private function importJSON():void
		{
			var importString : String = ''
			var productionJSON_onelayer : String = '{"name":"testname", "sku":"1234", "desc":"lorem isum description of testname", "Faces":[{"name":"front", "image":"assets/products/352B-000034-Z_Configure.jpg", "mask":"", "Layers":[{"name":"color", "type":"color", "Media":{"source":"0xffffff", "type":"color"}, "Fonts":null, "transform":{"width":"100%", "height":"100%", "x":null, "y":null, "rotation":null}, "orientation":"horizontal", "required":true, "default":null}, {"name":"color", "type":"image", "Media":{"source":"", "Fonts":null, "type":"image"}, "transform":{"width":"100", "height":"100", "x":"10", "y":"10", "rotation":"0"}, "orientation":"horizontal", "required":false, "default":null}, {"name":"Color Layer", "type":"text", "Media":{"source":"helloworld", "type":"text"}, "Fonts":[{"name":"arial", "size":"10", "weight":"normal"}, {"name":"bebas", "size":"15", "weight":"bold"}], "transform":{"width":"100", "height":"100", "x":"10", "y":"10", "rotation":"0"}, "orientation":"horizontal", "required":false, "default":null}, {"name":"Clipart Layer 1", "type":"clipart", "Media":{"source":"assets/images/pokemon.png", "type":"clipart"}, "Fonts":null, "transform":{"width":"100", "height":"100", "x":"50", "y":"50", "rotation":"0"}, "orientation":"horizontal", "required":false, "default":null}, {"name":"Clipart Layer 2", "type":"clipart", "Media":{"source":null, "type":"clipart"}, "Fonts":null, "transform":{"width":null, "height":null, "x":null, "y":null, "rotation":null}, "orientation":"horizontal", "required":false, "default":null}, {"name":"Clipart Layer 3", "type":"clipart", "Media":{"source":null, "type":"clipart"}, "Fonts":null, "transform":{"width":null, "height":null, "x":null, "y":null, "rotation":null}, "orientation":"horizontal", "required":false, "default":null}]}]}';
			
			
			importString = productionJSON_onelayer;
			if ( importString == '' || importString == null ) 
				return;
			this.dispatch( new ImportViridJSONCommandTriggerEvent(
				ImportViridJSONCommandTriggerEvent.IMPORT_JSON,importString)) ;
			
		}
		
		
	}
}