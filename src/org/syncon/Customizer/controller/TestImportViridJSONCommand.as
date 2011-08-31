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
			var designProcessFull : String = '{"name":"testname", "sku":"1234", "desc":"lorem isum description of testname", "Faces":[{"name":"front", "image":"assets/products/162-000003-Z_Configure.jpg", "mask":"assets/products/162-000003-Z_ConfigureMask.png", "layer_lock":true, "Layers":[{"name":"Background Layer", "type":"color", "Media":{"source":"assets/products/162-000003-Z_ConfigureMask.png", "type":"color"}, "Fonts":null, "transform":{"width":"100%", "height":"100%", "x":null, "y":null, "rotation":null}, "orientation":"horizontal", "required":true, "default":null}, {"name":"Image Layer", "type":"image", "Media":{"source":"assets/images/pokemon.png", "Fonts":null, "type":"image"}, "transform":{"width":"100", "height":"100", "x":"10", "y":"10", "rotation":"0"}, "orientation":"horizontal", "required":false, "default":null}, {"name":"Text Layer", "type":"text", "price":"14.95", "Media":{"source":"helloworld", "type":"text"}, "Fonts":[{"name":"arial", "size":"10", "weight":"normal"}, {"name":"bebas", "size":"15", "weight":"bold"}], "transform":{"width":"100", "height":"100", "x":"10", "y":"10", "rotation":"0"}, "orientation":"horizontal", "required":false, "default":null}, {"name":"Clipart Layer 1", "type":"clipart", "Media":{"source":null, "type":"clipart"}, "Fonts":null, "transform":{"width":null, "height":null, "x":null, "y":null, "rotation":null}, "orientation":"horizontal", "required":false, "default":null}, {"name":"Clipart Layer 3", "type":"clipart", "Media":{"source":null, "type":"clipart"}, "Fonts":null, "transform":{"width":null, "height":null, "x":null, "y":null, "rotation":null}, "orientation":"horizontal", "required":false, "default":null}]}]}';
			var engraveVerticalAndNormal : String = '{"name":"Armor&#8482;", "sku":"1023753", "desc":"<br>&#8226;Brushed Brass<br>&#8226;1.5 times as thick as a standard sterling silver case<br>&#8226;Packaged in an environmentally friendly gift box<br>&#8226;Lifetime Guarantee<br>&#8226;Fill with Zippo premium lighter fluid", "Faces":[{"name":"front", "image":"assets/products/162-000003-Z_Configure.jpg", "mask":"null", "Layers":[{"name":"Engrave", "type":"engrave", "price":4.95, "Media":{"source":"", "type":"engrave", "max":7}, "Fonts":[{"name":"Avalon", "swfname":"Avalon", "size":"22", "weight":"normal"}, {"name":"Century", "size":"12", "weight":"normal"}, {"name":"Century", "size":"12", "weight":"normal"}, {"name":"OldEnglish", "size":"12", "weight":"normal"}, {"name":"RomanUL", "size":"12", "weight":"normal"}, {"name":"Script", "size":"12", "weight":"normal"}], "transform":{"width":"100", "height":"22", "x":"63", "y":"40", "rotation":null}, "orientation":"horizontal", "required":true, "default":null}, {"name":"Monogram", "type":"monogram", "price":4.95, "Media":{"source":"", "type":"engrave", "max":3}, "Fonts":[{"name":"Avalon", "size":"30", "weight":"normal"}, {"name":"Century", "size":"12", "weight":"normal"}, {"name":"Century", "size":"12", "weight":"normal"}, {"name":"OldEnglish", "size":"12", "weight":"normal"}, {"name":"RomanUL", "size":"12", "weight":"normal"}, {"name":"Script", "size":"12", "weight":"normal"}], "transform":{"width":"22", "height":"120", "x":"63", "y":"80", "rotation":null}, "orientation":"vertical", "required":true, "default":null}]}]}';
			importString = designProcessFull;
			//importString = engraveVerticalAndNormal;
			if ( importString == '' || importString == null ) 
				return;
			this.dispatch( new ImportViridJSONCommandTriggerEvent(
				ImportViridJSONCommandTriggerEvent.IMPORT_JSON,importString)) ;
			
		}
		
		
	}
}