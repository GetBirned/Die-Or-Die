extends CharacterBody2D

var rng

var status

var friction
var speed

var do_bounce

var held

var return_position

var transition

var signals

var explosion_vfx

var particle_script

var particle_controller

@onready var sides = ["1", "2", "3", "4", "5", "6"]

@onready var current_side = "1"

func _ready():
	rng = RNG.get_rng()
	status = "display"
	friction = 0.999
	speed = 1500
	do_bounce = true
	held = false
	transition = false
	signals = CustomSignals.get_instance()
	explosion_vfx = signals.ExplosionVFX

	particle_script = load("res://scripts/utils/Dice_Particles.cs")
	particle_controller = particle_script.new()
	add_child(particle_controller)
	
func _physics_process(delta):
	match status:
		"display":
			pass
		"rolling":
			var collision_info = move_and_collide(velocity * delta)
			if collision_info and do_bounce:
				velocity = velocity.bounce(collision_info.get_normal())
				do_bounce = false
			else:
				do_bounce = true
				
			velocity = velocity * friction
			friction -= 0.001
				
			if velocity.length() <= 200:
				velocity = Vector2(0,0)
				#$CollisionShape2D.disabled = true
				status = "face"
				transition = true
				scale = Vector2(0.75,0.75)
				
				# do particle effect
				$CPUParticles2D.amount = 50 * get_value()
				$CPUParticles2D.emitting = true
		"face":
			if transition:
				particle_controller.explosion_vfx(current_side)
				transition = false
			$Face.play(current_side)
			$Face.visible = true
			$Die.play("default")
		"dragging":
			global_position = get_global_mouse_position()
		"dropping":
			if abs(global_position.distance_to(return_position)) < 10:
				global_position = return_position
				status = "face"
			else:
				global_position.x += (return_position.x - global_position.x) * 0.2
				global_position.y += (return_position.y - global_position.y) * 0.2
				

func roll():
	if not held:
		#$CollisionShape2D.disabled = false
		$Face.visible = false
		$Die.play("rolling")
		$Die.frame = rng.randi_range(0, 12)
		scale = Vector2(1,1)
		
		current_side = sides[rng.randi_range(0, sides.size()-1)]
		roll_physics()

func roll_physics():
	friction = 0.999
	velocity = Vector2(rng.randf_range(-1,1), rng.randf_range(-1,1)).normalized() * speed
	status = "rolling"


func get_value():
	if current_side.is_valid_int():
		return current_side.to_int()
	else:
		return 0

func _on_button_button_down():
	if status == "face":
		return_position = global_position
		status = "dragging"


func _on_button_button_up():
	if status == "dragging":
		status = "dropping"
