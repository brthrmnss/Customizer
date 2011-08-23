package  org.syncon.Customizer.controller
{
	import com.adobe.serialization.json.JSON;
	
	import org.robotlegs.mvcs.Command;
	import org.syncon.Customizer.model.NightStandModel;
	import org.syncon.Customizer.vo.LayerBaseVO;
	
	
	
	public class ExportJSONCommand extends Command
	{
		[Inject] public var model:NightStandModel;
		[Inject] public var event:ExportJSONCommandTriggerEvent;
		
		override public function execute():void
		{
			if ( event.type == ExportJSONCommandTriggerEvent.EXPORT_JSON ) 
			{
				//this.loadSound()
				//trace('bigbing');
				var layers:Array = new Array;
				for each( var layer: LayerBaseVO in this.model.layersVisible){
					
					var jsonLayer:Object = {};
					jsonLayer.x = layer.x;
					layers.push(jsonLayer);
					
					
				}
				var exportThis:String = JSON.encode(layers);
				trace(exportThis);
				
			}				
			
		}
/*		
		private function loadSound():void
		{
			
		}*/
		
		
	}
}