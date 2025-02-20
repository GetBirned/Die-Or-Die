extends CharacterBody2D


func _ready():
	velocity = Vector2(400,400)

func _physics_process(delta):
	
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	
	
