extends Node

enum Types {NUMBER, BLANK, MONEY, MULTIPLIER}

@export var value: int = 1

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
	GameInfo.last_scored_side = self
	if type == Types.NUMBER:
		GameInfo.add_score(value)
		return value
	elif type == Types.BLANK:
		GameInfo.add_score(GameInfo.blank_value)
		return GameInfo.blank_value
	elif type == Types.MONEY:
		GameInfo.add_money(value)
		return 0
	elif type == Types.MULTIPLIER:
		GameInfo.mult_score(value)
		return value
	else:
		return -1
		
func is_number():
	return type == Types.NUMBER

func is_blank():
	return type == Types.BLANK
	
func is_money():
	return type == Types.MONEY
	
func is_multiplier():
	return type == Types.MULTIPLIER
