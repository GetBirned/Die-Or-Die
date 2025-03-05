extends Node2D

var life
var rerolls
var signals = CustomSignals

func _ready() -> void:
	life = 10

func get_life():
	return life

func calculate_difficulty():
	# difficulty calculation
	pass

func take_damage(damage):
	life -= damage
