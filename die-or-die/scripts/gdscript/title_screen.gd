extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$MenuMusicPlayer.play()
	$TitleScreenUI/SaveLabel.text = get_save_info()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_save_info():
	if not DiceBag.save_exists():
		return "No save file"
	
	var save_file = FileAccess.open("user://save.txt", FileAccess.READ)
	
	var ret = ""
	
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		
		var json = JSON.new()
		
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
			
		var data = json.data
		
		ret += "Dice: " + str(data["dice"].size()) + "   "
		
		ret += "Level: " + str(data["level"]) + "   "
		
		ret += "Money: " + str(data["money"])
	
	return ret


func _on_rolldebug_pressed():
	SceneManager.switch_scene("battle")

func _on_shopdebug_pressed():
	SceneManager.switch_scene("shop")


func _on_savedebug_pressed():
	DiceBag.save_bag()

func _on_loaddebug_pressed():
	DiceBag.load_bag()


func _on_dicebagdebug_pressed() -> void:
	SceneManager.switch_scene("dicebag_visual")
