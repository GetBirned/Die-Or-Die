extends CharacterBody2D

enum {DISPLAY, ROLLING, FACE, DRAGGING, RETURNING, HELD}

var rng
var status
var friction
var speed
var do_bounce
var return_position
var held_by = null
var closest_space
var die_name

var sides = ["1", "2", "3", "4", "5", "6"]
var current_side = sides[0]

func _ready():
	die_name = "D6"
	rng = RNG.get_rng()
	status = DISPLAY
	friction = 0.999
	speed = 1500
	do_bounce = true
	
func _physics_process(delta):
	match status:
		DISPLAY:
			pass
		ROLLING:
			rolling(delta)
		FACE:
			face()
		DRAGGING:
			position = get_global_mouse_position()
		RETURNING:
			if abs(global_position.distance_to(return_position)) < 10:
				global_position = return_position
				status = FACE
			else:
				global_position.x += (return_position.x - global_position.x) * 0.2
				global_position.y += (return_position.y - global_position.y) * 0.2
		HELD:
			position = closest_space.global_position

func roll():
	if status != HELD:
		$Face.visible = false
		$Die.play("rolling")
		$Die.enable_blur()
		$Die.frame = rng.randi_range(0, 12)
		scale = Vector2(.66,.66)
		
		current_side = sides[rng.randi_range(0, sides.size()-1)]
		roll_physics()

func roll_physics():
	friction = 0.999
	velocity = Vector2(rng.randf_range(-1,1), rng.randf_range(-1,1)).normalized() * speed
	status = ROLLING

func get_value():
	if current_side.is_valid_int():
		return current_side.to_int()
	else:
		return 0

# holding logic
func set_closest(slot: Area2D):
	closest_space = slot

# rolling logic
func rolling(delta):
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
		status = FACE
		scale = Vector2(0.50,0.50)
		$Die.disable_blur()
		
		# do particle effect
		$CPUParticles2D.amount = 25 * pow(get_value(), 2)
		$CPUParticles2D.emitting = true

func face():
	$Face.play(current_side)
	$Face.visible = true
	$Die.play("default")


func _on_die_face_pressed() -> void:
	if status == FACE:
		return_position = global_position
		status = DRAGGING
	elif status == HELD:
		if held_by != null:
			held_by.clear_die()
			held_by = null
			
		return_position = Vector2(0,0)
		status = DRAGGING

func _on_die_face_released() -> void:
	if status == DRAGGING:
		if closest_space == null:
			move_and_collide(Vector2(0,0))
			status = FACE
		else:
			position = closest_space.position
			closest_space.register_die(self)
			held_by = closest_space
			status = HELD
