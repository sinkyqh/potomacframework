package agile.core
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import agile.bundle.Extension;
	import agile.bundle.IBundleService;
	import agile.inject.Injector;
	
	[ExtensionPoint(id="Serializer",type="agile.core.ISerializer",declaredOn="classes",
	                 serializes="*class")]
	[Injectable(singleton="true")]
	/**
	 * @private
	 */
	public class SerializationService
	{
		private var _injector:Injector;
		private var _exts:Array;
		
		[Inject]
		public function SerializationService(bundleService:IBundleService,injector:Injector)
		{
			_exts = bundleService.getExtensions("Serializer");
			_injector = injector;
		}
		
		public function serialize(object:Object):String
		{
			if (object == null)
				return "null";
			
			var className:String = getQualifiedClassName(object);				
			var serializer:ISerializer = getSerializer(className);
			
			var data:String = serializer.serialize(object);
			return className + ":" + data;		
		}
		
		public function deserialize(data:String):Object
		{
			if (data == "null")
				return null;
			
			var className:String = data.substring(0,data.indexOf(":"));
			var data:String = data.substr(data.indexOf(":") + 1);
			
			return getSerializer(className).deserialize(data);
		}
		
		private function getSerializer(className:String):ISerializer
		{
			var ext:Extension;
			for (var i:int = 0; i < _exts.length; i++)
			{
				if (Extension(_exts[i]).serializes == className)
				{
					ext = _exts[i];
					break;
				}	
			}
			
			if (ext == null)
				throw new Error("Unable to find Serializer for " + className +".");
				
			return _injector.getInstanceImmediate(getDefinitionByName(ext.className) as Class) as ISerializer;			
		}

	}
}