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
		}
	}
}
