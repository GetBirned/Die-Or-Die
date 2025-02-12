using Godot;
using Godot.Collections;

public partial class D6 : Die {

    public override void __init__() {
        faces = new int[]{1, 2, 3, 4, 5, 6};
        current_value = -1;
        frozen = false;
        description = "Ol'reliable.";
        dieid = 00;
    }
}