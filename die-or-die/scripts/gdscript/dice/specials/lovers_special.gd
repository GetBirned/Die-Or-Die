extends Node

func manual_special(this_being_scored: bool):
	if this_being_scored:
		if GameInfo.hand == "pair" or GameInfo.hand == "three of a kind":
			GameInfo.mult_score(2)
			get_parent().do_shake()
			return true
				
		elif GameInfo.hand == "two pair" or GameInfo.hand == "full house" or GameInfo.hand == "four of a kind" or GameInfo.hand == "five of a kind":
			GameInfo.mult_score(4)
			get_parent().do_shake()
			return true
		
	return false
