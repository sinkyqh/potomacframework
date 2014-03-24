package agile.core
{
	import flash.events.IEventDispatcher;

	/**
	 * IAgilePreloader is a marker interface which Potomac uses to 
	 * identify a Flex preloader that is participating in the Potomac
	 * specialized preloading.
	 * <p>
	 * A Agile preloader is kept visible until Potomac is completely
	 * initialized.  This includes the initiation of the BundleService 
	 * and the completion of any [StartupListener]s.
	 * </p>
	 */
	public interface IAgilePreloader extends IEventDispatcher
	{

	}
}