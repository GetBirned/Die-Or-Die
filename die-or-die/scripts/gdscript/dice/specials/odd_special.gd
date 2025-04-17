extends Node


func manual_special(this_being_scored: bool):
	if GameInfo.last_scored_side.is_number() and GameInfo.last_scored_side.value%2==1:
		GameInfo.add_score(7)
		get_parent().do_shake()
		return true
	return false
