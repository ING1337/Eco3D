package  
{
	public class Eco3D_Utils
	{
		
		public static const MOVE:String		= "move";
		public static const LINE:String		= "line";
		public static const CURVE:String		= "curve";
		public static const PEN:String		= "pen";
		public static const FILL:String		= "fill";
		public static const ENDFILL:String	= "endfill";
		
		public static function mapGraphicsArray(type:String, data:String) : Array {
			var a:Array = data.split(",");
			if (type == PEN) {
				a[0] = parseInt(a[0]);
				a[1] = parseInt(a[1]);
				a[2] = parseFloat(a[2]);
			} else if (type == FILL) {
				a[0] = parseInt(a[0]);
				a[1] = parseFloat(a[2]);
			}
			return a;
		}
		
	}

}
