extends Node

var unlocked_dice = [
	"D6", "Lucky 7", "Twoless Die", "Blank Die", "D666", "Golden Die",
	"Glass Die", "Odd Die", "Even Die", "Lovers Die"
]

func _ready():
	GameInfo.purchasing.connect(add_die)
	for i in range(5):
		add_die("D6")

func add_die(key):
	var die = load($DiceDictionary.dice_dict[key]).instantiate()
	$Bag.call_deferred("add_child", die)
	GameInfo.call_deferred("emit_bag_updated")

func new_hand():
	var new_hand = []
	var num = 5 - get_dice_on_board().size()
	
	if num > $Bag.get_child_count():
		refill()
	
	for i in range(num):
		var die = grab_die()
		if die != null:
			new_hand.append(die)
		
	return new_hand

func reset_to_bag():
	while $Board.get_child_count() > 0:
		$Board.get_child(0).reparent($Bag)
	while $Discard.get_child_count() > 0:
		$Discard.get_child(0).reparent($Bag)
	while $Held.get_child_count() > 0:
		$Held.get_child(0).reparent($Bag)
	for die in $Bag.get_children():
		die.set_hidden()

func grab_die():
	if $Bag.get_child_count() > 0:
		var die = get_dice_in_bag().pick_random()
		die.reparent($Board)
		die.set_hidden()
		return die
	return null

func hold(die):
	if die != null and die.is_in_group("die"):
		die.call_deferred("reparent", $Held)

func unhold(die):
	if die != null and die.is_in_group("die"):
		die.call_deferred("reparent", $Board)

func refill():
	while $Discard.get_child_count() > 0:
		$Discard.get_child(0).reparent($Bag)

func discard():
	while $Held.get_child_count() > 0:
		var die = $Held.get_child(0)
		die.set_hidden()
		die.reparent($Discard)

func kill_die(die):
	CustomSignals.kill_die.emit(die) # potentially redundant now, but leaving anyway
	$Bag.remove_child(die)
	$Board.remove_child(die)
	$Discard.remove_child(die)
	$Held.remove_child(die)
	die.queue_free()
	
func clear_bag():
	while $Bag.get_child_count() > 0:
		kill_die($Bag.get_child(0))
	while $Board.get_child_count() > 0:
		kill_die($Board.get_child(0))
	while $Discard.get_child_count() > 0:
		kill_die($Discard.get_child(0))
	while $Held.get_child_count() > 0:
		kill_die($Held.get_child(0))

func get_dice():
	var dice = get_dice_in_bag()
	dice.append_array(get_dice_on_board())
	dice.append_array(get_held_dice())
	dice.append_array(get_discarded_dice())
	return dice

func get_dice_in_bag():
	return $Bag.get_children()

func get_dice_on_board():
	return $Board.get_children()
	
func get_held_dice():
	return $Held.get_children()

func get_discarded_dice():
	return $Discard.get_children()


func save_bag(file):
	var save_file = FileAccess.open("user://" + str(file), FileAccess.WRITE)
	var data = {
		"dice": [],
		"unlocked": unlocked_dice,
		"achievements":GameInfo.Achievements,
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
		
func unlock_die(key):
	unlocked_dice.append(key)
	
