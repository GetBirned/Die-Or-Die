extends Node2D

var domino_stack = []
var held_queue = []
var live_dice = []
var rng

func _ready() -> void:
	rng = RNG.get_rng()
	load_dice(5)
	$DominoZone/DefaultDomino.calculate_difficulty()
	domino_stack.push_front($DominoZone/DefaultDomino)
	$DominoZone.create_dominoes(3)
	
func load_dice(num):
	live_dice = DiceBag.new_hand(num)
	for die in live_dice:
		var new_die = die.duplicate()
		$Dice.add_child(new_die)
		new_die.roll() # temporary solution, we need to figure out the bounds

func _on_roll_button_pressed():
	var dice = $Dice.get_children()
	for die in dice:
		die.roll()

func _on_back_button_pressed():
	live_dice.clear()
	DiceBag.full_bag.append_array(DiceBag.active_dice)
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")

func _on_turn_locked_in() -> void:
	var damage = 0
	for die in held_queue:
		damage += die.get_value() # not ready for specials yet 
	
