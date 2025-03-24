extends Node2D

var life
var rerolls
var active
var SHAKING = false

func _ready() -> void:
	active = false
	calculate_difficulty()
	update_sprite()

func _process(delta: float) -> void:
	if SHAKING:
		shake(delta)

func get_life():
	return life

func reroll_used():
	rerolls -= 1
	update_sprite()

func calculate_difficulty():
	# difficulty calculation
	life = 10 # just for now
	rerolls = 2

func take_damage(damage):
	life -= damage

func update_sprite():
	$Threshold.play(str(life))
	$Rerolls.play(str(rerolls))


@onready var shake_index = 0
@onready var shake_speed = 300
func shake(delta):
	if !SHAKING:
		SHAKING = true
		
	if shake_index == 0:
		set_rotation_degrees(get_rotation_degrees() - (shake_speed*delta))
		if get_rotation_degrees() < -5:
			shake_index = 1
	elif shake_index == 1:
		set_rotation_degrees(get_rotation_degrees() + (shake_speed*delta))
		if get_rotation_degrees() > 5:
			shake_index = 2
	else:
		set_rotation_degrees(get_rotation_degrees() - (shake_speed*delta))
		if get_rotation_degrees() < 0:
			shake_index = 0
			SHAKING = false
			set_rotation_degrees(0)
	
	
