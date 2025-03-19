extends Node


func _on_glass_die_connect_special():
	get_parent().connect("rolled", signal_special)

func signal_special():
	if get_parent().rng.randi_range(0, 9) == 0:
		get_parent().queue_free()

func manual_special():
	return true
