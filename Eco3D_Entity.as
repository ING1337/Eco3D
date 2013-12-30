package  
{
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	
	public class Eco3D_Entity extends Eco3D
	{
		public var size:Vector3D	= new Vector3D();
		public var origin:Vector3D	= new Vector3D();

		// ########################################################################################################################
		// ########################################################################################################################
		// ########################################################################################################################
		
		public function align(x:Number, y:Number, z:Number, alignX:Number = 0.5, alignY:Number = 0.5, alignZ:Number = 0.5) : void {
			placeGlobal(
				origin.x - alignX * size.x + x, 
				origin.y - alignY * size.y + y, 
				origin.z - alignZ * size.z + z
			);
		}
		
		public function getPosition(target:Vector3D, observeOrigin:Boolean = true, global:Boolean = true) : void {
			if (observeOrigin) {
				if (global) {
					target.x = x - origin.x * rawData[0];
					target.y = y - origin.y * rawData[5];
					target.z = z - origin.z * rawData[10];
				} else {
					target.x = x - origin.x;
					target.y = y - origin.y;
					target.z = z - origin.z;
				}
			} else {
				target.x = x;
				target.y = y;
				target.z = z;
			}
			//target.x = x - (observeOrigin ? (global ? origin.x * rawData[0]  : origin.x) : 0);
			//target.y = y - (observeOrigin ? (global ? origin.y * rawData[5]  : origin.y) : 0);
			//target.z = z - (observeOrigin ? (global ? origin.z * rawData[10] : origin.z) : 0);
		}
		
		public function getSize(target:Vector3D, global:Boolean = true) : void {
			if (global) {
				target.x = size.x * rawData[0];
				target.y = size.y * rawData[5];
				target.z = size.z * rawData[10];
			} else {
				target.x = size.x;
				target.y = size.y;
				target.z = size.z;
			}
			//target.x = (global ? size.x * rawData[0]  : size.x);
			//target.y = (global ? size.y * rawData[5]  : size.y);
			//target.z = (global ? size.z * rawData[10] : size.z);
		}
		
		
		//public function getOrigin(target:Vector3D, global:Boolean = true) : void {
			//target.x = (global ? origin.x * rawData[0]  : origin.x);
			//target.y = (global ? origin.y * rawData[5]  : origin.y);
			//target.z = (global ? origin.z * rawData[10] : origin.z);
		//}
		
		//public function get width()  : Number { return size.x * rawData[0]; }
		//public function get height() : Number { return size.y * rawData[5]; }
		//public function get depth()  : Number { return size.z * rawData[10]; }
	}
}
