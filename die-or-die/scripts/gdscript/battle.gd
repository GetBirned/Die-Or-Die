extends Node2D

var domino_stack = []
var held_queue = []
var live_dice = []
var rng
var rolls
var top_domino

func _ready() -> void:
	rng = RNG.get_rng()
	load_dice(5)
	domino_stack = $DominoZone.create_dominoes(1)
	top_domino = domino_stack.front()
	print(domino_stack.front())
	
func load_dice(num):
	live_dice = DiceBag.new_hand(num)
	for die in live_dice:
		var new_die = die.duplicate()
		$Dice.add_child(new_die)
		new_die.position = $Tray/Sprite2D.position
		new_die.roll(true) # temporary solution, we need to figure out the bounds

func _on_roll_button_pressed():
	if top_domino.rerolls > 0:
		var dice = $Dice.get_children()
		top_domino.reroll_used()
		for die in dice:
			die.roll()

func _on_back_button_pressed():
	live_dice.clear()
	DiceBag.full_bag.append_array(DiceBag.active_dice)
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")

func _on_turn_locked_in() -> void:
	var num = 0
	held_queue = $DiceHolder.get_dice()
	GameInfo.reset_score()
	for die in held_queue:
		die.score()
		DiceBag.discard_die(die) # moves dice from active to used
		die.queue_free() # removes dice from the scene
		num += 1
	print(GameInfo.current_score)
	$DominoZone.damage_dominoes(GameInfo.current_score)
	
	load_dice(num)
	
