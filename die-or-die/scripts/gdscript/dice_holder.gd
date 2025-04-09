extends Node2D

var slots = []
var die_in_body = null

func _ready() -> void:
	setup_slots()
	#print(slots)
	
func _process(delta: float) -> void:
	if die_in_body != null and die_in_body.get_status() == 3:
		die_in_body.set_closest(detect_closest_free())
			
# grabs each of the holder slots in order
func setup_slots():
	for child in get_children():
		if child.is_in_group("slot"):
			slots.append(child)

# detects if a die enters the TRAY area2d
func _on_holder_tray_entered(body) -> void:
	if body.is_in_group("die"):
		die_in_body = body;
	
# detects if a die leaves the TRAY area2d
func _on_holder_tray_exited(body):
	if body.is_in_group("die"):
		body.set_closest(null)
		die_in_body = null
	
# detects the closest free slot
func detect_closest_free():
	var pos = die_in_body.global_position # comparisons are global
	var close = null # reference to closest space
	var dist = Vector2(1000000, 100000)
	
	for slot in slots:
		#print(slot)
		#print(dist)
		if slot.is_free(): # if not free then not considered
			if close == null:
				dist = abs(pos - slot.global_position)
				close = slot
			else:
				if dist > abs(pos - slot.global_position):
					dist = abs(pos - slot.global_position)
					close = slot
	return close
			
func clear_dice():
	for slot in slots:
		slot.clear_die()
		
func get_dice():
	var dice = []
	for slot in slots:
		if not slot.is_free():
			dice.append(slot.get_die())
			
	return dice
