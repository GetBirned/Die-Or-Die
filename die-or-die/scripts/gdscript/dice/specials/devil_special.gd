extends Node

func manual_special(this_being_scored: bool):
	if this_being_scored:
		var sixes = 0
		for face in SceneManager.get_die_scores():
			if face == 6:
				sixes += 1
			
		if sixes == 3:
			GameInfo.mult_score(4)
			get_parent().do_shake()
			return true
	return false
