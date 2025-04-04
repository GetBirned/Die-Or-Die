extends Node2D

var slots = []
var die_in_body = null

func _ready() -> void:
	setup_slots()
	#print(slots)
	
func _process(delta: float) -> void:
	if die_in_body != null:
		die_in_body.set_closest(get_closest())
			
func setup_slots():
	for child in get_children():
		if child.is_in_group("slot"):
			slots.append(child)

func _on_holder_tray_entered(body) -> void:
	if body.is_in_group("die"):
		die_in_body = body;
		
func _on_holder_tray_exited(body):
	if body.is_in_group("die"):
		body.set_closest(null)
	die_in_body = null
	
func get_dice():
	var dice = []
	for slot in slots:
		var die = slot.get_die()
		if die != null:
			dice.append(die)
			
	return dice

func get_closest() -> Area2D:
	var closest = null
	var distance = Vector2(-1, -1)
	for slot in slots:
		var slot_distance = abs(slot.global_position-die_in_body.global_position)
		if closest == null or distance == Vector2(-1, -1):
			closest = slot
			distance = slot_distance
		
		if slot_distance < distance:
			closest = slot
			distance = slot_distance
	return closest
	
func clear_dice():
	for slot in slots:
		slot.clear_die()
