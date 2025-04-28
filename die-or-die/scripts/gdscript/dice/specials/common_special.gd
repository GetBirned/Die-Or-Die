extends Node

# literally the least efficient thing in the whole game
func manual_special(this_being_scored: bool):
	if this_being_scored:
		var scores = SceneManager.get_die_scores()
		var dice = SceneManager.get_dice()
		var combos = []
		for i in range(scores.size()):
			for j in range(scores.size()):
				if scores[i] + scores[j] == 7 and not combos.has([dice[i],dice[j]]):
					combos.append([dice[i],dice[j]])
					combos.append([dice[j],dice[i]])
					GameInfo.mult_score(2)
		
		
	return false
