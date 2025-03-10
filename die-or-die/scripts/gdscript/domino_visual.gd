extends Node2D

var life
var rerolls
var active

func _ready() -> void:
	active = false
	calculate_difficulty()
	update_sprite()

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
