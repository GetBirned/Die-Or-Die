extends Node2D

var domino_stack = []
var rolls
var top_domino

@onready var calculator = $Calculator

func _ready() -> void:
	$DeathScreenUI/BattleSway/DeathScreen.visible = false
	$DeathScreenUI/BattleSway/DeathScreenShadow.visible = false
	$DeathScreenUI/BattleSway/YouHaveImage.visible = false
	$DeathScreenUI/BattleSway/DiedImage.visible = false
	$DeathScreenUI/BattleSway/ScoreLabel.visible = false
	$DeathScreenUI/BattleSway/DiceCountLabel.visible = false
	$DeathScreenUI/BattleSway/RetryButton.visible = false
	$DeathScreenUI/BattleSway/QuitButton.visible = false
	
	await SceneManager.swipe_in_left_transition(self)
	$BattleMusicPlayer.play()
	DiceBag.reset_to_bag()
	load_dice()
	GameInfo.money_changed.connect(update_calculator)
	update_calculator()
	domino_stack = $DominoZone.create_dominoes(4+log(GameInfo.current_level+1))
	top_domino = domino_stack.front()
	
func _process(delta: float) -> void:
	update_calculator()
	
func update_calculator():
	$Calculator.set_money(GameInfo.get_money())
	$Calculator.update_display()
	
func load_dice():
	GameInfo.reset_score()
	var new_dice = DiceBag.new_hand()
	$RollDicePlayer.stop()
	$RollDicePlayer.play() # dice rolling sound effect
	for die in new_dice:
		die.global_position = $Tray/Sprite2D.position
		die.roll(true) # temporary solution, we need to figure out the bounds


func _on_roll_button_pressed():
	var dice = DiceBag.get_dice_on_board()
	if top_domino.lock_ins > 0:
		if not dice.is_empty() and dice[0].get_status() != 1:
		
			if $Calculator.money > 0:
				GameInfo.add_money(-1)
				
				$RollDicePlayer.stop()
				$RollDicePlayer.play() # dice rolling sound effect
				for die in dice:
					die.roll()
			else:
				$Calculator._quack_duck()

func _on_back_button_pressed():
	DiceBag.reset_to_bag()
	SceneManager.switch_scene("title_screen")

func _on_turn_locked_in() -> void:
	top_domino.lock_in_used()
	var held_queue = $DiceHolder.get_dice()
	var num_held = held_queue.size() # number to track how many new dice need to be loaded 
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
	DiceBag.discard()
	
	if domino_stack.is_empty():
		DiceBag.reset_to_bag()
		GameInfo.current_level += 1
		await SceneManager.swipe_transition(self)
		SceneManager.switch_scene("shop")
	else:
		if top_domino == domino_stack.front() and top_domino.lock_ins == 0:
			# HANDLE LOSS HERE
			DiceBag.reset_to_bag()
			await on_loss()
		else:	
			top_domino = domino_stack.front()
			load_dice()
			
	
func on_loss() -> void:
	$RollNode/RollButton.disabled = true
	$LockNode/LockInButton.disabled = true
	$BackButton.disabled = true

	var death_screen = $DeathScreenUI/BattleSway/DeathScreen
	var death_screen_shadow = $DeathScreenUI/BattleSway/DeathScreenShadow
	var you_have_img = $DeathScreenUI/BattleSway/YouHaveImage
	var died_img = $DeathScreenUI/BattleSway/DiedImage
	var score_label = $DeathScreenUI/BattleSway/ScoreLabel
	var dice_label = $DeathScreenUI/BattleSway/DiceCountLabel
	var quit_button = $DeathScreenUI/BattleSway/QuitButton
	var retry_button = $DeathScreenUI/BattleSway/RetryButton

	death_screen.visible = true
	death_screen_shadow.visible = true
	death_screen.modulate.a = 0.0
	death_screen_shadow.modulate.a = 0.0

	var tween = create_tween()
	tween.tween_property(death_screen, "modulate:a", 1.0, 0.4).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(death_screen_shadow, "modulate:a", 1.0, 0.4).set_trans(Tween.TRANS_LINEAR)
	await tween.finished
	
	await get_tree().create_timer(1.0).timeout
	you_have_img.visible = true

	await get_tree().create_timer(2.0).timeout
	you_have_img.visible = false
	died_img.visible = true
	retry_button.visible = true
	quit_button.visible = true
	score_label.text = "%d" % GameInfo.total_score
	score_label.visible = true

	dice_label.text = "%d" % DiceBag.get_dice_in_bag().size()
	dice_label.visible = true

func _on_bag_button_pressed() -> void:
	SceneManager.switch_scene("dicebag_visual")

func _on_retry_button_pressed() -> void:
	await SceneManager.swipe_transition(self)
	SceneManager.switch_scene("title_screen")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
