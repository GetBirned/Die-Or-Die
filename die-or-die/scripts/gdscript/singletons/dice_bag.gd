extends Node

var in_bag = []
var money = 999999;

func _ready():
	GameInfo.purchasing.connect(add_die)
	for i in range(5):
		add_die("D6")

func add_die(key):
	var die = load($DiceDictionary.dice_dict[key]).instantiate()
	$Dice.call_deferred("add_child", die)
	GameInfo.emit_bag_updated()
	in_bag.append(die)

func new_hand(hand_size: int):
	var new_hand = []
	print("getting" + str(hand_size))
	
	if hand_size > in_bag.size():
		refill()
		hand_size = 5
	
	for i in range(hand_size):
		new_hand.append(in_bag.pop_front())
		
	return new_hand

func refill():
	in_bag = []
	for die in $Dice.get_children():
		in_bag.append(die)
		die.set_hidden()
	in_bag.shuffle()
	
func kill_die(die):
	CustomSignals.kill_die.emit(die)
	for i in range(in_bag.size()):
		if in_bag[i].id == die.id:
			in_bag.remove_at(i)
	$Dice.remove_child(die)
	die.queue_free()

func get_dice():
	return $Dice.get_children()
