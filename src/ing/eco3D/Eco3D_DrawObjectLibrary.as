package  
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class Eco3D_DrawObjectLibrary extends URLLoader
	{
		public var xmlData:XML;
		public var ready:Boolean = false;
		
		public function Eco3D_DrawObjectLibrary(file:String) {
			addEventListener(Event.COMPLETE, onXML);
			load(new URLRequest(file));
		}
		
		private function onXML(e:Event) : void {
			xmlData = new XML(data);
			ready = true;
		}
		
		public function getObject(objectName:String) : Eco3D_DrawObject {
			if (!ready) return null;
			return new Eco3D_DrawObject(xmlData.object.(@name == objectName)[0]);
		}
		
	}

}
