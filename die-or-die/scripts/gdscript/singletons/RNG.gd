extends Node

var rng: RandomNumberGenerator

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	rng.randomize()
	
	
func randf_range(l, h):
	return rng.randf_range(l, h)

func randi_range(l, h):
	return rng.randi_range(l, h)
