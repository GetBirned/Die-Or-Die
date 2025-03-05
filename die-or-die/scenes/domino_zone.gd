extends Area2D

var zone_bounds: Rect2
var rng: RandomNumberGenerator
var domino_stack = []

func _ready() -> void:
	zone_bounds = $CollisionShape2D.shape.get_rect()
	rng = RNG.get_rng()
	
func create_dominoes(count:int):
	for i in range(count):
		var top_domino = $DefaultDomino.duplicate()
		top_domino.calculate_difficulty()
		add_child(top_domino)
		domino_stack.push_front(top_domino)
	
	place_dominoes(domino_stack)
	
func place_dominoes(domino_stack):
	var count = domino_stack.size()
	for i in range(count):
		var domino = domino_stack[i]
		var offset = Vector2(count-i*5, count-i*(-3)) # gives the illusion of layers
	
		domino.position = zone_bounds.get_center() + offset
		domino.z_index = count-i # puts the top domino on the highest layer

func destroy_top():
	pass
		
func damage_dominoes(damage):
	var top_life = domino_stack.front().get_life()
	if damage < top_life:
		domino_stack.front().take_damage(damage)
	else:
		var remaining = top_life-damage
		destroy_top()
		if remaining > 0:
			damage_dominoes(remaining)
