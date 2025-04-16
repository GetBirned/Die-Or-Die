extends Node

var full_bag = []
var active_dice = []
var money = 999999;

func _ready():
	for i in range(10):
		full_bag.append($DiceDictionary.dice_dict[$DiceDictionary.dice_dict.keys().pick_random()])

func add_die(die):
	if $"/root/GameInfo" > die.price():
		full_bag.append(die)
		$"/root/GameInfo".add_money(-die.price())
	else:
		print("broke")
		
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
	
