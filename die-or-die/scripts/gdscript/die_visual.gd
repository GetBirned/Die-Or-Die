extends CharacterBody2D

enum {DISPLAY, ROLLING, FACE, DRAGGING, RETURNING, HELD}

var rng
var status
var friction
var speed
var do_bounce
var return_position

var sides = ["1", "2", "3", "4", "5", "6"]
var current_side = sides[0]

func _ready():
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
			global_position = get_global_mouse_position()
		RETURNING:
			if abs(global_position.distance_to(return_position)) < 10:
				global_position = return_position
				status = FACE
			else:
				global_position.x += (return_position.x - global_position.x) * 0.2
				global_position.y += (return_position.y - global_position.y) * 0.2
		HELD:
			global_position = hold_space.global_position

func roll():
	if status != HELD:
		$Face.visible = false
		$Die.play("rolling")
		$Die.frame = rng.randi_range(0, 12)
		scale = Vector2(1,1)
		
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
var hold_spaces = {}
var hold_space
func add_space(space, position):
	hold_spaces[space] = position
	
func remove_space(space):
	hold_spaces.erase(space)

func _on_button_button_down():
	if status == FACE:
		return_position = global_position
		status = DRAGGING
	elif status == HELD:
		if hold_space != null:
			hold_space.clear_die()
			hold_space = null
		return_position = Vector2(0,0)
		status = DRAGGING

func _on_button_button_up():
	print(hold_spaces)
	if status == DRAGGING:
		if hold_spaces.is_empty():
			var collision_info = move_and_collide(Vector2(0,0))
			status = FACE
			
		else:
			var shortest = 100000
			for space in hold_spaces:
				var distance_to_space = hold_spaces[space].distance_to(global_position)

				if distance_to_space < shortest:
					hold_space = space
					shortest = distance_to_space

			hold_space.register_die(self)
			status = HELD

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
		scale = Vector2(0.75,0.75)
		
		# do particle effect
		$CPUParticles2D.amount = 25 * pow(get_value(), 2)
		$CPUParticles2D.emitting = true

func face():
	$Face.play(current_side)
	$Face.visible = true
	$Die.play("default")
