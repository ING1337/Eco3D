package  
{
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	
	public class Eco3D_DrawObject extends Eco3D_Entity implements IRenderEco3D
	{
		public var vectors:Vector.<Number>;
		public var screenVector:Vector3D = new Vector3D();
		
		private var tVectors:Vector.<Number>;
		private var drawComm:Vector.<String> = new Vector.<String>(), drawData:Array = [];
		
		private var type:String, p0:uint, p1:uint, p2:uint, m:Matrix3D;
		
		public function Eco3D_DrawObject(xml:XML = null) {
			p0 = xml.vertex.length() * 3;
			vectors	= new Vector.<Number>(p0);
			tVectors	= new Vector.<Number>(p0);
			
			for each (var node:XML in xml.verticies.vertex) {
				p0 = parseInt(node.@index) * 3;
				vectors[p0++] = Number(node.@x);
				vectors[p0++] = Number(node.@y);
				vectors[p0]   = Number(node.@z);
			}
			
			for each (node in xml.draw.children()) {
				drawComm.push(type = String(node.name()));
				if (type == Eco3D_Utils.PEN || type == Eco3D_Utils.FILL) {
					drawData.push(Eco3D_Utils.mapGraphicsArray(type, node.@style));
				} else if (type != Eco3D_Utils.ENDFILL) {
					drawData.push(int(node.@index));
					if (type == Eco3D_Utils.CURVE) drawData.push(int(node.@index2));
				}
			}
			
			update();
		}
		
		// ########################################################################################################################
		// ########################################################################################################################
		// ########################################################################################################################
		
		public function render(renderTarget:Object, viewport:Eco3D_ViewPort = null, transformation:Matrix3D = null) : void {
			transform(viewport,  transformation);
			draw(renderTarget);
		}
		
		public function transform(viewport:Eco3D_ViewPort = null, transformation:Matrix3D = null) : void {
			if (viewport) {
				if (transformation) {
					viewport.transformCamera(transformation, this)
				} else {
					viewport.transformCamera(this);
				}
				viewport.transformVectors(vectors, tVectors);
				viewport.ecoVector(position, screenVector);
				//getPosition(screenVector, true, true);
				//viewport.ecoVector(screenVector, screenVector);
			} else {
				if (transformation) {
					(m = transformation.clone()).prepend(this);
					m.transformVectors(vectors, tVectors);
					screenVector = m.transformVector(position);
				} else {
					transformVectors(vectors, tVectors);
					screenVector = transformVector(position);
				}
			}
			//if (screenVector.z 
			//screenVector.z -= viewport.nearPlane;
			//trace(screenVector);
		}
		
		public function draw(renderTarget:Object) : void {
			if (screenVector.z < 0) return;
			
			p0 = 0;
			with (renderTarget.graphics) {
				for each (type in drawComm) {
					if (type == Eco3D_Utils.MOVE) {
						p1 = uint(drawData[p0++]) * 3;
						moveTo(tVectors[p1], tVectors[++p1]);
					} else if (type == Eco3D_Utils.LINE) {
						p1 = uint(drawData[p0++]) * 3;
						lineTo(tVectors[p1], tVectors[++p1]);
					} else if (type == Eco3D_Utils.CURVE) {
						p1 = uint(drawData[p0++]) * 3;
						p2 = uint(drawData[p0++]) * 3;
						curveTo(tVectors[p1], tVectors[++p1], tVectors[p2], tVectors[++p2]);
					} else if (type == Eco3D_Utils.PEN) {
						lineStyle.apply(this, drawData[p0++]);
					} else if (type == Eco3D_Utils.FILL) {
						beginFill.apply(this, drawData[p0++]);
					} else if (type == Eco3D_Utils.ENDFILL) {
						endFill();
					}
				}
			}
		}
		
		// ########################################################################################################################
		// ########################################################################################################################
		// ########################################################################################################################
		
		public function update() : void {
			var i:uint = 0, deltas:Array = [0, 0, 0, 0, 0, 0];
			while (i < vectors.length) {
				if (vectors[i] < deltas[0]) deltas[0] = vectors[i];
				if (vectors[i] > deltas[1]) deltas[1] = vectors[i]; i++;
				if (vectors[i] < deltas[2]) deltas[2] = vectors[i];
				if (vectors[i] > deltas[3]) deltas[3] = vectors[i]; i++;
				if (vectors[i] < deltas[4]) deltas[4] = vectors[i];
				if (vectors[i] > deltas[5]) deltas[5] = vectors[i]; i++;
			}
			origin = new Vector3D(-deltas[0], -deltas[2], -deltas[4]);
			size	 = new Vector3D(deltas[1] - deltas[0], deltas[3] - deltas[2], deltas[5] - deltas[4]);
		}
		
	}
}
