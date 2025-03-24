extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rolldebug_pressed():
	SceneManager.switch_scene("battle")


func _on_shopdebug_pressed():
	SceneManager.switch_scene("shop")
