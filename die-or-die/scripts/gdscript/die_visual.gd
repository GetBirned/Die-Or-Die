extends CharacterBody2D

var rng

var status

var friction
var speed

var do_bounce

var held

@onready var sides = ["1", "2", "3", "4", "5", "6"]

@onready var current_side = "1"

func _ready():
	rng = RNG.get_rng()
	status = "display"
	friction = 0.999
	speed = 1500
	do_bounce = true
	held = false
	
	

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
				
			if velocity.length() <= 100:
				velocity = Vector2(0,0)
				$CollisionShape2D.disabled = true
				status = "face"
		"face":
			$Face.play(current_side)
		#"dragging":
			#global_position = get_global_mouse_position()

func roll():
	if not held:
		$CollisionShape2D.disabled = false
		current_side = sides[rng.randi_range(0, sides.size()-1)]
		roll_physics()

func roll_physics():
	friction = 0.999
	velocity = Vector2(rng.randf_range(-1,1), rng.randf_range(-1,1)).normalized() * speed
	status = "rolling"


func _on_button_button_down():
	if status == "face":
		status = "dragging"


func _on_button_button_up():
	status = "face"
