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
			break
	$Dice.remove_child(die)
	die.queue_free()
	
func clear_bag():
	while $Dice.get_child_count() > 0:
		kill_die($Dice.get_child(0))

func get_dice():
	return $Dice.get_children()


func save_bag(file):
	var save_file = FileAccess.open("user://" + str(file), FileAccess.WRITE)
	var data = {
		"dice": [],
		"money": GameInfo.get_money(),
		"level": GameInfo.current_level
	}
	for die in get_dice():
		data["dice"].append(die.die_name)
	save_file.store_line(JSON.stringify(data))

func load_bag(file):
	clear_bag()
	if not FileAccess.file_exists("user://" + str(file)):
		load_default()
		return
	
	var save_file = FileAccess.open("user://" + str(file), FileAccess.READ)
	
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		
		var json = JSON.new()
		
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
			
		var data = json.data
		
		GameInfo.set_money(data["money"])
		GameInfo.current_level = data["level"]
		for die_name in data["dice"]:
			add_die(die_name)
			
	
func load_default():
	GameInfo.set_money(10)
	GameInfo.current_level = 1
	for i in range(5):
		add_die("D6")
