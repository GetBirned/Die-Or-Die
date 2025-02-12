using System.Dynamic;
using Godot;
using Godot.Collections;

public partial class Dice_Map : Dictionary<int, string>{

    private static Dictionary<int, string> map = new Dictionary<int, string>() {
        {00, "D6"},
        {01, "Marble"},
        {02, "Coin"},
        {03, "DSticks"}, // sticky die
        {04, "Devil Die"},
    }; 

    public static Dictionary<int, string> dice_map {
        get => map;
    }

}