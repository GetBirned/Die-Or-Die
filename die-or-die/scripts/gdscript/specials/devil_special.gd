extends Node

func manual_special():
	if false: #TODO check if hand has exactly 3 sixes
		GameInfo.current_score *= 4
		get_parent().do_shake()
		return true
	return false
