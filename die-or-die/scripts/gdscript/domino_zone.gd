extends Area2D

var zone_bounds: Rect2
var rng: RandomNumberGenerator
var domino_stack = []
var rerolls

func _ready() -> void:
	zone_bounds = $CollisionShape2D.shape.get_rect()
	rng = RNG.get_rng()
	
func create_dominoes(count:int):
	for i in range(count):
		var top_domino = $DefaultDomino.duplicate()
		top_domino.calculate_difficulty()
		add_child(top_domino)
		top_domino.show()
		domino_stack.push_front(top_domino)
		
	domino_stack.front().active = true
	place_dominoes()
	return domino_stack
	
func place_dominoes():
	var count = domino_stack.size()
	for i in range(count):
		var domino = domino_stack[i]
		var offset = Vector2(count-i*5, count-i*(-3)) # gives the illusion of layers
	
		domino.position = zone_bounds.get_center() + offset
		domino.z_index = count-i # puts the top domino on the highest layer

func destroy_top():
	var active_domino = domino_stack.pop_front()
	active_domino.active = false
	remove_child(active_domino)
	
	rerolls = domino_stack.front()
		
# damages the top domino
func damage_dominoes(damage):
	if domino_stack.is_empty():
		get_tree().change_scene_to_file("res://scenes/shop.tscn")
		return
		
	var active_domino = domino_stack.front()
	var top_life = active_domino.get_life()
	if damage < top_life:
		active_domino.take_damage(damage)
		active_domino.update_sprite()
	else:
		var remaining = top_life-damage
		destroy_top()
		if remaining > 0:
			damage_dominoes(remaining)
			
		elif domino_stack.is_empty():
			get_tree().change_scene_to_file("res://scenes/shop.tscn")
			return

func get_rerolls():
	return rerolls
