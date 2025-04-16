extends Node2D

var domino_stack = []
var held_queue = []
var live_dice = []
var rolls
var top_domino

@onready var calculator = $Calculator

func _ready() -> void:
	$BattleMusicPlayer.play()
	CustomSignals.kill_die.connect(Callable(self, "kill_die"))
	load_dice(5)
	GameInfo.money_changed.connect(update_calculator)
	update_calculator()
	domino_stack = $DominoZone.create_dominoes(4)
	top_domino = domino_stack.front()
	
func update_calculator():
	calculator.set_money(GameInfo.money)
	
func load_dice(num):
	GameInfo.reset_score()
	live_dice = DiceBag.new_hand(num)
	$RollDicePlayer.stop()
	$RollDicePlayer.play() # dice rolling sound effect
	for die in live_dice:
		var new_die = die.duplicate()
		$Dice.add_child(new_die)
		new_die.position = $Tray/Sprite2D.position
		new_die.roll(true) # temporary solution, we need to figure out the bounds


func _on_roll_button_pressed():
	if top_domino.lock_ins > 0:
		var dice = $Dice.get_children()
		$RollDicePlayer.stop()
		$RollDicePlayer.play() # dice rolling sound effect
		for die in dice:
			die.roll()

func _on_back_button_pressed():
	live_dice.clear()
	DiceBag.full_bag.append_array(DiceBag.active_dice)
	SceneManager.switch_scene("title_screen")

func _on_turn_locked_in() -> void:
	top_domino.lock_in_used()
	held_queue = $DiceHolder.get_dice()
	var num = held_queue.size() # number to track how many new dice need to be loaded 
	GameInfo.reset_score()
	for die in held_queue:
		die.score()
		$Timer.start()
		await $Timer.timeout
		
		for special in held_queue:
			if special.call_special(die == special):
				$Timer.start()
				await $Timer.timeout
	
	GameInfo.mult_score(GameInfo.hand_multiplier)
	$Timer.start()
	await $Timer.timeout
	
	#print(GameInfo.current_score)
	await $DominoZone.damage_dominoes(GameInfo.current_score)
	
	$DiceHolder.clear_dice()
	
	for die in held_queue:
		$Dice.remove_child(die)
	
	held_queue = []
	
	if domino_stack.is_empty():
		await SceneManager.swipe_transition(self)
		SceneManager.switch_scene("shop")
	else:
		if top_domino == domino_stack.front() and top_domino.lock_ins == 0:
			await SceneManager.swipe_transition(self)
			SceneManager.switch_scene("title_screen")
		else:	
			top_domino = domino_stack.front()
			load_dice(num)
			DiceBag.replace_dice()
	
func kill_die(die):
	for d in held_queue:
		if die == d:
			held_queue.remove_at(held_queue.find(die))
	
	for d in live_dice:
		if d == die:
			live_dice.remove_at(live_dice.find(die))
			
		
