extends Node


func manual_special(this_being_scored: bool):
	if this_being_scored:
		var ones = 0
		for face in SceneManager.get_die_scores():
			if face == 1:
				ones += 1
		
		if ones == 2:
			GameInfo.mult_score(5)
			get_parent().do_shake()
			return true
	return false
