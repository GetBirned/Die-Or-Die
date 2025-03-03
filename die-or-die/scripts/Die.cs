using System.Security.Cryptography;
using Godot;


public abstract partial class Die : Node2D {

	protected int[] faces;
	protected int current_value=-1;
	protected bool frozen=false;
	protected string description;
	protected int dieid;
	protected PackedScene die_visual;

	public override void _Ready(){
		
	}
	
	public abstract void __init__();

	// doesn't handle animation only runs a random number generator
	public int Roll() {
		return faces[RNG.get_rng().RandiRange(1, faces.Length-1)];
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
