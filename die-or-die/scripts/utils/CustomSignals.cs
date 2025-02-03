using Godot;

public partial class CustomSignals : Node
{
	// To use custom signals create a local reference to CustomSignals.Instance in whichever class
	// connect that instance to your class using the syntax: 
	// custom_signals_instance_local_ref.connect(nameof(<whichever signal you're trying to connect>), new Callable(this, nameof(<local method you're trying to signal>)))
	
	public static CustomSignals Instance;
	public override void _Ready()
	{
		Instance = this;
	}

	// make new signals down here
	[Signal] public delegate void DoSpecialEventHandler();
}
