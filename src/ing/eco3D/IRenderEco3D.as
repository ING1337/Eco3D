package  
{
	import flash.geom.Matrix3D;
	
	public interface IRenderEco3D {
		function transform(viewport:Eco3D_ViewPort = null, transform:Matrix3D = null) : void;
		function draw(renderTarget:Object) : void;
	}
}
