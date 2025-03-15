extends Node


func _on_glass_die_connect_special():
	get_parent().connect("rolled", special)

func special():
	if get_parent().rng.randi_range(0, 9) == 0:
		get_parent().queue_free()
