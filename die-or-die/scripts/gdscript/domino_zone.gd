extends Area2D

var zone_bounds: Rect2
var domino_stack = []
var lock_ins

func _ready() -> void:
	zone_bounds = $CollisionShape2D.shape.get_rect()
	
func create_dominoes(count:int):
	for i in range(count):
		var top_domino = $DefaultDomino.duplicate()
		top_domino.calculate_difficulty(count-i)
		top_domino.update_sprite()
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
	$DominoDeathPlayer.play() # play a noise when the domino is destroyed.
	remove_child(active_domino)
		
# damages the top domino
func damage_dominoes(damage):
	if domino_stack.is_empty():
		return
		
	var active_domino = domino_stack.front()
	var dmg = 1
	for i in range(damage):
		if active_domino.get_life() == 0:
			destroy_top()
			if domino_stack.is_empty():
				return
			active_domino = domino_stack.front()
			
		active_domino.take_damage(dmg)
		
		# damage noise for domino
		var pitch_base = 1.0
		var pitch_scale = 0.01  # tune pitch here
		$DamagePlayer.stop()
		$DamagePlayer.pitch_scale = pitch_base + i * pitch_scale # pitch will increase as more damage is taken
		$DamagePlayer.play()
		
		active_domino.shake(0)
		active_domino.update_sprite()
		if i > 15:
			$FastTimer.start()
			await $FastTimer.timeout
		else:
			$Timer.start()
			await $Timer.timeout
			
	if active_domino.get_life() == 0:
		destroy_top()

func get_lock_ins():
	return lock_ins
