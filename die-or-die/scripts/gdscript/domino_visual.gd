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
	#life = (DiceBag.get_dice().size())*domino_num*pow(GameInfo.current_level,2)
	life = max(12+pow(2,domino_num+1),(DiceBag.get_dice().size()*(GameInfo.current_level + domino_num)))
	lock_ins = min(6, max(roundi(life/12)-1, 1)) # max number of rerolls is 6

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
	
	
