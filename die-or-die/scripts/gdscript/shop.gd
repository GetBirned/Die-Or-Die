extends Node2D

enum {DISPLAY, ROLLING, FACE, DRAGGING, RETURNING, HELD}

var dice_in_shelf = []
var slots = []
var shelf_length
var dice_holder
var increment

# Called when the node enters the scene tree for the first time.
func _ready():
	shelf_length = $DiceShelfBottomEnd.global_position.x - $DiceShelfBottomStart.global_position.x
	increment = shelf_length / 3
	$BackgroundAnimated.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")


func _order_dice():
	var x = increment / 2
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

func _on_add_pressed():	
	var num_dice = dice_in_shelf.size()
	if num_dice < 6:	
		var die = $DiceDictionary.dice_dict[$DiceDictionary.dice_dict.keys().pick_random()].duplicate()
		die.hide()
		add_child(die)
		dice_in_shelf.append(die)
		die.face()
		order_die(num_dice)

func _on_remove_pressed():
	if dice_in_shelf.size() > 0:
		var die = dice_in_shelf.pop_back()
		die.queue_free()
