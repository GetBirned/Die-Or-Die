extends Node

enum Types {NUMBER, BLANK, MONEY, MULTIPLIER}

@export var value: float = 1

@export var type: Types

func get_value():
	if type == Types.BLANK:
		return 0
	return value
	
func get_sprite():
	match type:
		Types.NUMBER:
			return "number"
		Types.BLANK:
			return "blank"
		Types.MONEY:
			return "money"
		Types.MULTIPLIER:
			return "multiplier"
	
func score():
	if type == Types.NUMBER:
		GameInfo.current_score += value
		return value
	elif type == Types.BLANK:
		GameInfo.current_score += GameInfo.blank_value
		return GameInfo.blank_value
	elif type == Types.MONEY:
		GameInfo.money += value
		return 0
	elif type == Types.MULTIPLIER:
		GameInfo.current_score *= value
		return value
	else:
		return -1
		
