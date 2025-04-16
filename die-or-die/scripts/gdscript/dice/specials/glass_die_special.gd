extends Node


func _on_glass_die_connect_special():
	get_parent().connect("rolled", signal_special)

func signal_special():
	if RNG.randi_range(0, 9) == 0:
		print("bye bye")
		DiceBag.kill_die(get_parent())

func manual_special(this_being_scored: bool):
	return false
