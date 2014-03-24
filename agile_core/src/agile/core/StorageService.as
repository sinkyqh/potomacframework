package agile.core
{
	import flash.net.SharedObject;
	
	[Injectable(singleton="true")]
	/**
	 * @private
	 */
	public class StorageService
	{
		internal var sharedObject:SharedObject; /* Internal scope to allow unit test to flush storage */
		
		public function StorageService()
		{
			sharedObject = SharedObject.getLocal("potomac");
		}
		
		public function retrieve():void
		{
			//TODO: need to allow for async storage (ie. on server)
		}

		public function setProperty(name:String,value:Object=null):void
		{
			sharedObject.setProperty(name,value);
		}
		
		public function getProperty(name:String):Object
		{
			return sharedObject.data[name];
		}
		
		public function hasProperty(name:String):Boolean
		{
			return sharedObject.data.hasOwnProperty(name);
		}
		
		public function save():void
		{
			sharedObject.flush();
		}

	}
}