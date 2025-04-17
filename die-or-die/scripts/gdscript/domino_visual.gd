extends Node2D

var life
var lock_ins
var active
var SHAKING = false

func _ready() -> void:
	active = false

func _process(delta: float) -> void:
	if SHAKING:
		shake(delta)

func get_life():
	return life

func lock_in_used():
	lock_ins -= 1
	update_sprite()

func calculate_difficulty(domino_num):
	# difficulty calculation
	life = (DiceBag.full_bag.size()+DiceBag.active_dice.size())*domino_num
	lock_ins = min(6, max(roundi(life/8)-1, 1))

func take_damage(damage):
	life -= damage

func update_sprite():
	$Threshold.update(life)
	$LockIns.update(lock_ins)

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
	
	
