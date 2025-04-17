extends Node

var full_bag = []
var active_dice = []

func _ready():
	GameInfo.purchasing.connect(add_die)
	for i in range(5):
		full_bag.append($DiceDictionary.dice_dict["D6"])

func add_die(key):
	full_bag.append($DiceDictionary.dice_dict[key].duplicate())

func new_hand(hand_size: int):
	var new_hand = []
	for i in range(hand_size):
		new_hand.append(full_bag.pop_front())
	
	active_dice.append_array(new_hand)
		
	return new_hand
	
func replace_dice():
	full_bag.append_array(active_dice)
	active_dice = []
	
func kill_die(die):
	CustomSignals.kill_die.emit(die)
	for i in range(full_bag.size()):
		if full_bag[i] == die:
			full_bag.remove_at(i)
