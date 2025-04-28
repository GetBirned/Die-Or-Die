extends Node2D

@onready var thimble = $Thimble

var tile_positions = []
var level_names = []
var current_index = 0
var is_moving = false

func _ready():
	$LevelMusicPlayer.play()
	tile_positions = [
		Vector2(250, 53),
		Vector2(267, 124),
		Vector2(298, 199),
		Vector2(374, 226),
		Vector2(447, 202),
		Vector2(515, 165),
		Vector2(612, 149),
		Vector2(677, 197),
		Vector2(720, 261),
		Vector2(770, 306),
		Vector2(849, 297),
		Vector2(924, 272),
		Vector2(997, 300),
		Vector2(1013, 373),
		Vector2(989, 453),
		Vector2(945, 519),
		Vector2(894, 571),
		Vector2(826, 584),
		Vector2(765, 547),
		Vector2(725, 476),
		Vector2(686, 408),
		Vector2(614, 362),
		Vector2(542, 342),
		Vector2(473, 354),
		Vector2(418, 407),
		Vector2(367, 468),
		Vector2(341, 548),
		Vector2(382, 620),
		Vector2(457, 652)
	]
	
	level_names = [
		"World 1-1: Starting Tile",
		"World 1-2: Rolling Hills",
		"World 1-3: The Spinner's Path",
		"World 1-4: Candy Caverns",
		"World 1-5: Dice Drop Ditch",
		"World 1-6: Meeple Meadow",
		"World 1-7: Cardboard Crossing",
		"World 1-8: Rulebook Ridge",
		"World 1-9: Puzzle Piece Pit",
		"World 1-10: The Game Box",
		"World 2-1: Blazing Boardwalk",
		"World 2-2: Hot Hands Alley",
		"World 2-3: Deck of Flames",
		"World 2-4: Melted Miniatures",
		"World 2-5: Inferno Initiative",
		"World 2-6: Lava Tile Loop",
		"World 2-7: Burned-Out Backgammon",
		"World 2-8: Charred Checkers",
		"World 2-9: The Final Roll",
		"World 2-10: Boss Battle: The Board Lord",
		"World 3-1: Crystal Catan",
		"World 3-2: Tile Tundra",
		"World 3-3: The Dice Mines",
		"World 3-4: Shimmering Shuffles",
		"World 3-5: Settler’s Sanctuary",
		"World 3-6: The Card Tower",
		"World 3-7: Icebreaker Island",
		"World 3-8: Frozen Pieces",
		"World 3-9: Vault of Victory"
	]
	update_level_label()
	thimble.position = tile_positions[current_index]

func update_level_label():
	$CanvasLayer/LevelInfoLabel.text = level_names[current_index]

func _process(delta):
	if is_moving:
		return

	if Input.is_action_just_pressed("ui_right") and current_index < tile_positions.size() - 1:
		current_index += 1
		$MovePiecePlayer.stop()
		$MovePiecePlayer.play()
		move_thimble_to(tile_positions[current_index])
	elif Input.is_action_just_pressed("ui_left") and current_index > 0:
		$MovePiecePlayer.stop()
		$MovePiecePlayer.play()
		current_index -= 1
		move_thimble_to(tile_positions[current_index])

func move_thimble_to(target_pos: Vector2):
	is_moving = true
	var tween = get_tree().create_tween()
	tween.tween_property(thimble, "position", target_pos, 0.3) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_OUT)
	tween.tween_callback(Callable(self, "_on_thimble_move_finished"))
	update_level_label()

func _on_back_to_menu_button_pressed():
	await SceneManager.swipe_transition(self)
	SceneManager.switch_scene("title_screen")

func _on_thimble_move_finished():
	is_moving = false

func _on_open_dice_bag_pressed():
	await SceneManager.swipe_transition(self)
	SceneManager.switch_scene("dicebag_visual")

func _on_shop_button_pressed():
	await SceneManager.swipe_transition(self)
	SceneManager.switch_scene("shop")
