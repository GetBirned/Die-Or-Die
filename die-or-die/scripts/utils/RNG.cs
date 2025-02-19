using System;
using Godot;

public partial class RNG : Node {

    private static RandomNumberGenerator rng;

    public override void _Ready() {
        rng = new RandomNumberGenerator(); 
        rng.Seed = (ulong) rng.RandfRange("austinsnow".GetHashCode()/"adam".GetHashCode(), "austinsnow".GetHashCode()^(2^1024));
    }

    public static RandomNumberGenerator get_rng() {
        return rng;
    }
}