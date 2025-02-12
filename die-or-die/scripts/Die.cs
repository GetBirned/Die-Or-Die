using Godot;

public abstract partial class Die : Node2D {

	protected int[] faces;
	protected int current_value;
	protected bool frozen;
	protected string description;
	protected int dieid;
	
	public abstract void __init__();

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

	private void Freeze() {
		frozen = true;
	}

    private void Unfreeze() {
		frozen = false;
	}

	private void Set_Value(int value) {
		current_value = value;
	}

	public void Change_Face(int value, int index) {
		faces[index] = value;
	}

}
