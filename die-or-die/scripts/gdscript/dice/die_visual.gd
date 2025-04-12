extends CharacterBody2D

signal connect_special
signal rolled

enum {DISPLAY = 0, ROLLING, FACE, DRAGGING, RETURNING, HELD, SHAKE}

var status
var friction
var speed
var do_bounce
var return_position
var held_by = null
var closest_space
var hover_count = 0

var sides = ["1", "2", "3", "4", "5", "6"]
var current_side;

@export var die_name: String
@export var description: String

@onready var shadow = $Shadow
var last_mouse_position := Vector2.ZERO

func _ready():
	status = DISPLAY
	friction = 0.999
	speed = 1500
	do_bounce = true
	current_side = $Sides.get_child(0)
	connect_special.emit()
	shadow.visible = false

func name_description():
	return [die_name, description]

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
			
			# sway based on mouse movement
			var velocity = get_global_mouse_position() - last_mouse_position
			rotation = clamp(velocity.x * 0.01, -0.5, 0.5)
			last_mouse_position = get_global_mouse_position()
			
		RETURNING:
			if abs(global_position.distance_to(return_position)) < 10:
				global_position = return_position
				status = FACE
			else:
				global_position.x += (return_position.x - global_position.x) * 0.2
				global_position.y += (return_position.y - global_position.y) * 0.2
		HELD:
			position = closest_space.global_position
		SHAKE:
			shake(delta)
	
	# restore rotation slowly when not dragging
	if status != DRAGGING:
		rotation = lerp_angle(rotation, 0.0, 0.1)

func roll(initial = false):
	if status != HELD:
		$DieFaces.visible = false
		$Die.play("rolling")
		$Die.set_frame(RNG.randi_range(0, $Die.sprite_frames.get_frame_count("rolling")-1))
		
		current_side = $Sides.get_children().pick_random()
		
		if not initial:
			rolled.emit()
			
		roll_physics()

@onready var shake_index = 0
@onready var shake_speed = 400
func shake(delta):
	if shake_index == 0:
		set_rotation_degrees(get_rotation_degrees() - (shake_speed * delta))
		if get_rotation_degrees() < -20:
			shake_index = 1
	elif shake_index == 1:
		set_rotation_degrees(get_rotation_degrees() + (shake_speed * delta))
		if get_rotation_degrees() > 20:
			shake_index = 2
	else:
		set_rotation_degrees(get_rotation_degrees() - (shake_speed * delta))
		if get_rotation_degrees() < 0:
			shake_index = 0
			status = HELD
			set_rotation_degrees(0)

func roll_physics():
	friction = 0.999
	velocity = Vector2(RNG.randf_range(-1,1), RNG.randf_range(-1,1)).normalized() * 1500
	status = ROLLING

func get_value():
	return current_side.get_value()
	
func score():
	current_side.score()
	do_shake()

func do_shake():
	if status == HELD:
		set_rotation_degrees(0)
		status = SHAKE

func call_special(this_being_scored):
	return $Special.manual_special(this_being_scored)

func rolling(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info and do_bounce:
		velocity = velocity.bounce(collision_info.get_normal())
		do_bounce = false
	else:
		do_bounce = true
		
	velocity *= friction
	friction -= 0.001
		
	if velocity.length() <= 200:
		velocity = Vector2(0,0)
		status = FACE
		
		if current_side.get_value() > 0:
			$CPUParticles2D.amount = 25 * pow(int(current_side.get_value()), 2)
			$CPUParticles2D.emitting = true

func face():
	$DieFaces.set_face(current_side)
	$DieFaces.visible = true
	$Die.play("default")

func set_closest(slot: Area2D):
	closest_space = slot

func _on_die_face_pressed() -> void:
	if status == FACE:
		return_position = global_position
		status = DRAGGING
		shadow.visible = true
		last_mouse_position = get_global_mouse_position()
	elif status == HELD:
		if held_by != null:
			held_by.clear_die()
			held_by = null
			
		return_position = Vector2(0,0)
		status = DRAGGING
		shadow.visible = true
		last_mouse_position = get_global_mouse_position()

func _on_die_face_released() -> void:
	if status == DRAGGING:
		shadow.visible = false
		if closest_space == null:
			move_and_collide(Vector2(0,0))
			status = FACE
		else:
			position = closest_space.position
			closest_space.register_die(self)
			held_by = closest_space
			status = HELD

func get_status():
	return status

func get_sides():
	return $Sides.get_children()
	
func get_rect():
	return Rect2(global_position.x-32, global_position.y-32, 64, 64)
