extends Node2D
enum {DISPLAY, ROLLING, FACE, DRAGGING, RETURNING, HELD}

var dice_in_shelf = []
var shelf_length
var die_in_bag = null
var increment

@onready var calculator = $Calculator

# Called when the node enters the scene tree for the first time.
func _ready():
	await SceneManager.swipe_in_left_transition(self)
	GameInfo.purchasing.connect(_on_purchase)
	GameInfo.checking_out.connect(_on_checking_out)
	shelf_length = $DiceShelfBottomEnd.global_position.x - $DiceShelfBottomStart.global_position.x
	increment = shelf_length / 3
	update_calculator()
	$BackgroundAnimated.play("default")
	$BackgroundAnimatedSHADOW.play("default")
	for i in range(6):
		add_die()

func _on_checking_out(die):
	die_in_bag = die
	
func update_calculator():
	calculator.set_money(GameInfo.money)

func _on_purchase(key):
	# purchase logic here
	#print('buying %s' % (key))
	#print(dice_in_shelf)
	dice_in_shelf.erase(die_in_bag)
	#print(dice_in_shelf)
	die_in_bag.free()
	_order_dice()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")

func _refresh_shop():
	if GameInfo.get_money() > 3:
		GameInfo.add_money(-3)
		update_calculator()
		for i in range(6):
			_on_remove_pressed()
		for i in range(6):
			add_die()

func _order_dice():
	var num_dice = dice_in_shelf.size()
	for die_index in num_dice:
		order_die(die_index)

func order_die(die_index):
	var die = dice_in_shelf[die_index]
	die.show()
	var x = increment / 2
	if die_index >= 3:
		x += increment * (die_index-3)
		die.return_position = Vector2($DiceShelfTopStart.global_position.x + x, $DiceShelfTopStart.global_position.y)
	else:
		x += increment * (die_index)
		die.return_position = Vector2($DiceShelfBottomStart.global_position.x + x, $DiceShelfBottomStart.global_position.y)
	die.status = RETURNING

func add_die():
	var num_dice = dice_in_shelf.size()
	var die = load($DiceDictionary.dice_dict[$DiceDictionary.dice_dict.keys().pick_random()]).instantiate()
	die.hide()
	add_child(die)
	dice_in_shelf.append(die)
	die.face()
	order_die(num_dice)

func _on_add_pressed():	
	var num_dice = dice_in_shelf.size()
	if num_dice < 6:	
		add_die()

func _on_remove_pressed():
	if dice_in_shelf.size() > 0:
		var die = dice_in_shelf.pop_back()
		die.queue_free()
		
func _on_continue_pressed():
		await SceneManager.swipe_transition(self)
		SceneManager.switch_scene("level_select")
