package 
{
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	
	public class Eco3D extends Matrix3D
	{
		public var pivotLocal:Vector3D;
		public var pivotGlobal:Vector3D;
		public var v2D:Vector.<Number> = new Vector.<Number>(3); //private
		
		public function Eco3D(pivotGlobal:Vector3D = null, pivotLocal:Vector3D = null) {
			this.pivotGlobal = pivotGlobal || new Vector3D();
			this.pivotLocal  = pivotLocal  || new Vector3D();
		}
		
		// ########################################################################################################################
		// ########################################################################################################################
		// ########################################################################################################################
		
		public function placeGlobal(x:Number, y:Number, z:Number = 0) : void {
			moveGlobal(
				-position.x + x + pivotGlobal.x,
				-position.y + y + pivotGlobal.y,
				-position.z + z + pivotGlobal.z
			);
		}
		
		public function placeLocal(x:Number, y:Number, z:Number = 0) : void {
			moveLocal(
				-position.x + x + pivotLocal.x,
				-position.y + y + pivotLocal.y,
				-position.z + z + pivotLocal.z
			);
		}
		
		public function moveGlobal(x:Number, y:Number, z:Number = 0) : void {
			appendTranslation(x, y, z);
		}
		
		public function moveLocal(x:Number, y:Number, z:Number = 0) : void {
			prependTranslation(x, y, z);
		}
		
		public function rotateGlobal(x:Number, y:Number, z:Number = 0, pivot:Vector3D = null) : void {
			pivot = pivot || pivotGlobal;
			if (z) appendRotation( -z, Vector3D.Z_AXIS, pivot);
			if (y) appendRotation( -y, Vector3D.Y_AXIS, pivot);
			if (x) appendRotation( -x, Vector3D.X_AXIS, pivot);
		}
		
		public function rotateLocal(x:Number, y:Number, z:Number = 0, pivot:Vector3D = null) : void {
			pivot = pivot || pivotLocal;
			if (z) prependRotation( -z, Vector3D.Z_AXIS, pivot);
			if (y) prependRotation( -y, Vector3D.Y_AXIS, pivot);
			if (x) prependRotation( -x, Vector3D.X_AXIS, pivot);
		}
		
		public function scaleGlobal(x:Number, y:Number, z:Number = 1) : void {
			appendScale(x, y, z);
		}
		
		public function scaleLocal(x:Number, y:Number, z:Number = 1) : void {
			prependScale(x, y, z);
		}
		
		// ########################################################################################################################
		// ########################################################################################################################
		// ########################################################################################################################
		
		public function ecoVector(vin:Vector3D, vout:Vector3D, delta:Boolean = false) : void {
			v2D[0] = vin.x;
			v2D[1] = vin.y;
			v2D[2] = vin.z;
			transformVectors(v2D, v2D);
			vout.x = v2D[0];
			vout.y = v2D[1];
			vout.z = v2D[2];
			if (delta) vout.decrementBy(position);
		}
		
		// ########################################################################################################################
		// ########################################################################################################################
		// ########################################################################################################################
		
		public function set x(x:Number) : void { placeGlobal(x, position.y, position.z); }
		public function set y(y:Number) : void { placeGlobal(position.x, y, position.z); }
		public function set z(z:Number) : void { placeGlobal(position.x, position.y, z); }
		
		public function get x() : Number { return position.x; }
		public function get y() : Number { return position.y; }
		public function get z() : Number { return position.z; }
		
		
	}

}
