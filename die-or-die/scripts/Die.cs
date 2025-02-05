using Godot;

public abstract partial class Die : Node2D {

    int[] faces;
    int current_value;
    bool frozen;
    string description;
    int dieid;
    
    public void __init__() {
        // constructor   
    }

    public int Roll() {
        return -1;
    }

    public void Show_Tooltip() {

    }

    public bool Get_Frozen() {
        return frozen;
    }

    public int Get_Value() {
        return current_value;
    }

    private void Cycle_Freeze() {
        frozen = !frozen;
    }
    private void Set_Value(int value) {
        current_value = value;
    }

    public void Change_Face(int value, int index) {
        faces[index] = value;
    }

}