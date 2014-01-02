package  
{
	import flash.geom.Matrix;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	
	public class Eco3D_ViewPort extends Eco3D
	{
		public var centerX:int;
		public var centerY:int;
		
		//public var nearPlane:int;
		//public var farPlane:int;
		
		private var inverted:Matrix3D;
		private var focalLength:Number;
		private var vector:Vector3D, n:Number, i:int, j:int;
		
		public function Eco3D_ViewPort(x:int = 0, y:int = 0, fov:Number = 90, zOffset:Number = -500) { //, nearPlane:int = 1, farPlane:int = 2000
			centerX = x;
			centerY = y;
			this.fov = fov;
			z = zOffset;
		}
		
		// ########################################################################################################################
		// ########################################################################################################################
		// ########################################################################################################################
		
		public function transformCamera(...para:Array) : void { //...para:Array
			(inverted = clone()).invert();
			//inverted.prepend(transformation);
			while (para.length) inverted.prepend(Matrix3D(para.shift()));
		}
		
		public override function transformVectors(vin:Vector.<Number>, vout:Vector.<Number>) : void {
			inverted.transformVectors(vin, vout);
			j = vin.length;
			for (i = 0; i < j; i += 3) {
				n = focalLength / (focalLength + (vout[i + 2]));
				vout[i] = vout[i] * n + centerX;
				vout[i + 1] = vout[i + 1] * n + centerY;
			}
		}
		
		public override function ecoVector(vin:Vector3D, vout:Vector3D, delta:Boolean = false) : void {
			v2D[0] = vin.x;
			v2D[1] = vin.y;
			v2D[2] = vin.z;
			inverted.transformVectors(v2D, v2D);
			vout.w = focalLength / (focalLength + (vout.z = v2D[2]));
			vout.x = v2D[0] * vout.w + centerX;
			vout.y = v2D[1] * vout.w + centerY;
			//if (_delta) vout.decrementBy(inverted.position);
		}
		

		
		// ########################################################################################################################
		// ########################################################################################################################
		// ########################################################################################################################
		
		public function lookAt(x:Number, y:Number, z:Number) : void {
			pointAt(new Vector3D(x, y, z), Vector3D.X_AXIS, Vector3D.Y_AXIS);
			
		}
		
		public function set fov(fov:Number) : void {
			focalLength = 400 * Math.tan((90 - fov / 2) / 180 * Math.PI);
		}
	}
}
