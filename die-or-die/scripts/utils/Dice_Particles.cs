using Godot;

public partial class Dice_Particles : CpuParticles2D {

	public override void _Ready() {

		Curve scale_curve = new Curve();
		scale_curve.MaxValue = 1;
		scale_curve.MinValue = .01f;

		Curve accel_curve = new Curve();
		accel_curve.MaxValue = 80;
		accel_curve.MinValue = -10;
		
		ScaleAmountMax = 1000;
		ScaleAmountMin = 3;
		
		Emitting = false;
		OneShot = false;

		Explosiveness = .88f;
		SpeedScale = .9f;
		Randomness = .3f;
		Spread = 180f;
		ScaleAmountCurve = scale_curve;
		Color particle_color = new Color();
		particle_color.R = 255;
		particle_color.A = 255;
		LinearAccelCurve = accel_curve;

		Color = particle_color;
	}

	public override void _Process(double delta)
	{
	}


	private void explosion_vfx(Node die) {
		CharacterBody2D parent = (CharacterBody2D) die;
		
		Amount = 500; // temporary
		Position = new Vector2(100, 100);
		Emitting = true;
		//GD.Print(Amount);
	}

}
