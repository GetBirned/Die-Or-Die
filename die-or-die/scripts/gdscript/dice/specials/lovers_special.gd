extends Node

func manual_special(this_being_scored: bool):
	if this_being_scored:
		if GameInfo.hand == "pair":
			GameInfo.mult_score(2)
			get_parent().do_shake()
			return true
				
		elif GameInfo.hand == "two pair":
			GameInfo.mult_score(4)
			get_parent().do_shake()
			return true
		
	return false
