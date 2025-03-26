extends Node2D

enum {DISPLAY, ROLLING, FACE, DRAGGING, RETURNING, HELD}

var dice_in_shelf = []
var slots = []
var shelf_length
var dice_holder

# Called when the node enters the scene tree for the first time.
func _ready():
	shelf_length = $DiceShelfBottomEnd.global_position.x - $DiceShelfBottomStart.global_position.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")

func order_dice():
	var increment = shelf_length / 3
	var x = increment / 2
	var num_dice = dice_in_shelf.size()
	for die_index in num_dice:
		var die = dice_in_shelf[die_index]
		die.show()
		if die_index >= 3:
			if die_index == 3:
				x -= increment*3
			die.return_position = Vector2($DiceShelfTopStart.global_position.x + x, $DiceShelfTopStart.global_position.y)
			die.status = RETURNING
			x += increment			
		else:
			die.return_position = Vector2($DiceShelfBottomStart.global_position.x + x, $DiceShelfBottomStart.global_position.y)
			die.status = RETURNING
			x += increment

func _on_add_pressed():	
	if dice_in_shelf.size() < 6:	
		var rng = RNG.get_rng()
		#var rand_type = DiceBag.get_child(0).dice_dict.keys().pick_random()
		var die = $DiceDictionary.dice_dict[$DiceDictionary.dice_dict.keys().pick_random()].duplicate()
		#var die = DiceBag.get_child(0).dice_dict[rand_type].duplicate()
		die.hide()
		add_child(die)
		dice_in_shelf.append(die)
		die.face()
		order_dice()


func _on_remove_pressed():
	if dice_in_shelf.size() > 0:
		var die = dice_in_shelf.pop_back()
		die.queue_free()
		order_dice()
