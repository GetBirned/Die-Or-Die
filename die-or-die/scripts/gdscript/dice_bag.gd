extends Node

var full_bag = []
var active_dice = []
var held = []
var used_dice = []
var rng
var money = 999999;

func _ready():
	CustomSignals.die_held.connect(Callable(self, "die_held"))
	rng = RNG.get_rng()
	for i in range(100):
		full_bag.append($DiceDictionary.dice_dict["Seven"])

func add_die(key):
	full_bag.append($DiceDictionary.dice_dict[key])

func new_hand(hand_size: int):
	var new_hand = []
	for i in range(hand_size):
		new_hand.append(full_bag.pop_front())
	
	active_dice.append_array(new_hand)
		
	return new_hand
	
func discard_die(die):
	active_dice.pop_at(active_dice.find(die))
	used_dice.push_front(die)
	
func die_held(die, index):
	pass
