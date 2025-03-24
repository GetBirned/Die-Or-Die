extends Node2D

func switch_scene(scene:String):
	get_tree().change_scene_to_file("res://scenes/%s.tscn" % scene)
	
