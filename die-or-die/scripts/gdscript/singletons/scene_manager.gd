extends Node2D

@onready var current_scene = null

func switch_scene(scene:String):
	get_tree().change_scene_to_file("res://scenes/%s.tscn" % scene)
	current_scene = scene
	
func get_die_scores():
	if current_scene == "battle":
		var dice = get_tree().current_scene.get_node("DiceHolder").get_dice()
		var faces = []
		for die in dice:
			faces.append(die.get_value())
		return faces
	else:
		return []
