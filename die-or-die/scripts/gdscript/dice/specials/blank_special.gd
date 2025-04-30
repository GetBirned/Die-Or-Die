extends Node

func _on_connect_special():
	GameInfo.connect("bag_updated", signal_special)

func signal_special():
	var blank_total: int = 0
	for die in DiceBag.get_dice():
		for side in die.get_sides():
			if side.is_blank():
				blank_total += 1
	GameInfo.blank_value = blank_total/2

func manual_special(this_being_scored: bool):
	return false
