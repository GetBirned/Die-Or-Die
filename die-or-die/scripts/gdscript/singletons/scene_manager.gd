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


func swipe_transition(source_root: Node):
	var children = []
	for child in source_root.get_children():
		if child is Node2D:
			children.append(child)
		
	var shift = Vector2(10, 0)
	for i in range(7):
		if i > 5:
			Background.position += shift*Vector2(9-i, 0)
		else:
			Background.position += shift*Vector2(i, 0)
		$Timer.start()
		await $Timer.timeout
		
	for i in range(35):
		Background.position -= shift*Vector2(.75*i, 0)
		$Timer.start()
		await $Timer.timeout
		
	for child in children:
		child.hide()
	Background.position = Vector2(0,0)
		
func shrink_transition(source_root: Node):
	var children = []
	for child in source_root.get_children():
		if child is Node2D:
			children.append(child)
	
	var dest = Vector2(640, 360)
	for i in range(33):
		for child in children:
			if child.scale <= Vector2.ZERO:
				break
			var shift = (dest-child.global_position)/(33-i)
			child.global_position += shift
			child.scale -= Vector2(.03,.03)
			
		$Timer.start()
		await $Timer.timeout
			
