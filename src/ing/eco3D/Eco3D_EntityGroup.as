package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	
	public class Eco3D_EntityGroup extends Eco3D_Entity implements IRenderEco3D
	{
		//public var vertexBuffer:Vector.<Number>;
		
		public var objects:Vector.<IRenderEco3D> = new Vector.<IRenderEco3D>();
		private var object:IRenderEco3D;
		
		public var drawObjects:Vector.<Eco3D_DrawObject> = new Vector.<Eco3D_DrawObject>();
		private var listener:Vector.<Eco3D_EntityGroup> = new Vector.<Eco3D_EntityGroup>();
		

		//public function Eco3D_EntityGroup(parent:Eco3D_EntityGroup = null) : void { //vertexBuffer:Vector.<Number> = null
			//this.vertexBuffer = parent ? parent.vertexBuffer : new Vector.<Number>(); //vertexBuffer || new Vector.<Number>();
		//}
		
		// ########################################################################################################################
		// ########################################################################################################################
		// ########################################################################################################################
		
		public function transform(viewport:Eco3D_ViewPort = null,  transformation:Matrix3D = null) : void {
			transformation ? (transformation = transformation.clone()).prepend(this) : transformation = this;
			for each (object in objects) object.transform(viewport,  transformation);
		}
		
		public function draw(renderTarget:Object) : void {
			for each (object in objects) object.draw(renderTarget);
		}
		
		public function render(renderTarget:Object, viewport:Eco3D_ViewPort = null,  transformation:Matrix3D = null) : void {
			transform(viewport,  transformation);
			draw(renderTarget);
		}
		
		// ########################################################################################################################
		// ########################################################################################################################
		// ########################################################################################################################
		
		public function update() : void {
			var deltas:Array = [0, 0, 0, 0, 0, 0];
			for each (var eco:Eco3D_Entity in objects) {
				eco.getPosition(origin);
				eco.getSize(size);
				if (origin.x				< deltas[0]) deltas[0] = origin.x;
				if (origin.x + size.x	> deltas[1]) deltas[1] = origin.x + size.x;
				if (origin.y				< deltas[2]) deltas[2] = origin.y;
				if (origin.y + size.y	> deltas[3]) deltas[3] = origin.y + size.y;
				if (origin.z				< deltas[4]) deltas[4] = origin.z;
				if (origin.z + size.z	> deltas[5]) deltas[5] = origin.z + size.z;
			}
			origin = new Vector3D(-deltas[0], -deltas[2], -deltas[4]);
			size	 = new Vector3D(deltas[1] - deltas[0], deltas[3] - deltas[2], deltas[5] - deltas[4]);
		}
		
		public function indexDraws() : void {
			drawObjects.length = 0;
			
			for each (object in objects) {
				if (object is Eco3D_DrawObject) {
					drawObjects.push(object);
				} else if (object is Eco3D_EntityGroup) {
					drawObjects = drawObjects.concat(Eco3D_EntityGroup(object).drawObjects);
				}
			}
			
			for each (object in listener) Eco3D_EntityGroup(object).indexDraws();
		}
		
		// ########################################################################################################################
		// ########################################################################################################################
		// ########################################################################################################################
		
		public function newGroup() : Eco3D_EntityGroup {
			var group:Eco3D_EntityGroup = new Eco3D_EntityGroup();
			addObject(group);
			return group;
		}
		
		public function getObject(index:uint) : Eco3D_Entity {
			return Eco3D_Entity(objects[index]);
		}
		
		public function addObject(...para:Array) : void {
			for (var i:int = 0; i < para.length; i++) {
				if (para[i] is Array) {
					addObject.apply(this, para[i]);
				} else {
					objects.push(para[i]);
					if (para[i] is Eco3D_EntityGroup) Eco3D_EntityGroup(para[i]).addListener(this);
				}
			}
			update();
			indexDraws();
		}
		
		public function removeObject(...para:Array) : void {
			for (var i:int = 0; i < para.length; i++) {
				if (para[i] is Array) {
					removeObject.apply(this, para[i]);
				} else if (para[i] is Number) {
					objects.splice(para[i], 1);
				} else {
					var pos:int = objects.indexOf(para[i]);
					if (pos + 1) {
						if (objects[pos] is Eco3D_EntityGroup) Eco3D_EntityGroup(objects[pos]).removeListener(this);
						objects.splice(pos, 1);
					}
				}
			}
			update();
		}
		
		public function swapObject(target:Eco3D_EntityGroup, ...para:Array) : void {
			for (var i:int = 0; i < para.length; i++) {
				target.addObject(para[i]);
				removeObject(para[i]);
			}
		}
		
		public function addListener(target:Eco3D_EntityGroup) : void {
			listener.push(target);
		}
		
		public function removeListener(target:Eco3D_EntityGroup) : void {
			var pos:int = objects.indexOf(target);
			if (pos) listener.splice(pos, 1);
		}
	}
}
