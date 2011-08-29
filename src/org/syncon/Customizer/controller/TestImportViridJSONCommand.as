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
			var productionJSON_onelayer : String = '{ "name": "Armor&#8482;", "sku": "1023753", "desc": "<br>&#8226;Brushed Brass<br>&#8226;1.5 times as thick as a standard sterling silver case<br>&#8226;Packaged in an environmentally friendly gift box<br>&#8226;Lifetime Guarantee<br>&#8226;Fill with Zippo premium lighter fluid", "Faces": [ { "name": "front", "image": "assets/products/162-000003-Z_Configure.jpg", "mask": "assets/products/162-000003-Z_ConfigureMask.png", "Layers": [ { "name": "MonogramLayer", "type": "monogram", "price": 4.95, "Media": { "source": "", "type": "engrave", "max": 3 }, "Fonts": [ { "name": "Avalon", "size": "12", "weight": "normal" }, { "name": "Century", "size": "12", "weight": "normal" }, { "name": "Century", "size": "12", "weight": "normal" }, { "name": "OldEnglish", "size": "12", "weight": "normal" }, { "name": "RomanUL", "size": "12", "weight": "normal" }, { "name": "Script", "size": "12", "weight": "normal" } ], "transform": { "width": "22", "height": "62", "x": "63", "y": "-21", "rotation": null }, "orientation": "vertical", "required": true, "default": null } ] } ] }';
			
			
			importString = productionJSON_onelayer;
			if ( importString == '' || importString == null ) 
				return;
			this.dispatch( new ImportViridJSONCommandTriggerEvent(
				ImportViridJSONCommandTriggerEvent.IMPORT_JSON,importString)) ;
			
		}
		
		
	}
}