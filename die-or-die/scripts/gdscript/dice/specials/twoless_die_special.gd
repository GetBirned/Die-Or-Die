extends Node


func manual_special():
	if GameInfo.last_scored_side.is_number() and GameInfo.last_scored_side.value == 2:
		GameInfo.mult_score(2)
		get_parent().do_shake()
		return true
	return false
