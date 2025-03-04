extends Node

var full_bag = []
var active_dice = []
var held = []
var rng
var money = 999999;

func _ready():
	CustomSignals.die_held.connect(Callable(self, "die_held"))
	rng = RNG.get_rng()
	for i in range(100):
		full_bag.append($DiceDictionary.dice_dict["D6"])

func add_die(key):
	full_bag.append($DiceDictionary.dice_dict[key])

func new_hand(hand_size: int):
	for i in range(hand_size):
		active_dice.append(full_bag.pop_front())
		
	return active_dice
	
func die_held(die, index):
	pass
