extends CharacterBody2D

var rng

var status

var friction
var speed

var do_bounce

func _ready():
	rng = RNG.get_rng()
	status = "display"
	friction = 0.999
	speed = 1500
	do_bounce = true
	

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
				status = "face"
		"face":
			pass

func roll():
	roll_physics()

func roll_physics():
	friction = 0.999
	velocity = Vector2(rng.randf_range(-1,1), rng.randf_range(-1,1)).normalized() * speed
	status = "rolling"
