extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_pressed():
	DiceBag.erase_save()
	DiceBag.load_default()
	await SceneManager.swipe_transition(self)
	SceneManager.switch_scene("level_select")

func _on_quit_pressed():
	get_tree().quit()

func _on_SettingsButton_pressed():
	var settings_overlay = preload("res://scenes/SettingsOverlay.tscn").instantiate()
	get_tree().current_scene.add_child(settings_overlay)


func _on_continue_pressed():
	DiceBag.load_bag()
	await SceneManager.swipe_transition(self)
	SceneManager.switch_scene("level_select")
