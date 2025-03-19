extends Node


func manual_special():
	if GameInfo.last_scored_side.is_number() and GameInfo.last_scored_side.value == 2:
		GameInfo.current_score *= 2
