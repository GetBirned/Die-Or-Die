using System;
using Godot;

public partial class RNG : Node {

    private static RandomNumberGenerator rng;

    public override void _Ready() {
        rng = new RandomNumberGenerator(); 
        rng.Randomize();
    }

    public static RandomNumberGenerator get_rng() {
        return rng;
    }
}