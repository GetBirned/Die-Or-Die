extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$MenuMusicPlayer.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rolldebug_pressed():
	SceneManager.switch_scene("battle")

func _on_shopdebug_pressed():
	SceneManager.switch_scene("shop")


func _on_savedebug_pressed():
	DiceBag.save_bag("save.txt")

func _on_loaddebug_pressed():
	DiceBag.load_bag("save.txt")


func _on_dicebagdebug_pressed() -> void:
	SceneManager.switch_scene("dicebag_visual")
