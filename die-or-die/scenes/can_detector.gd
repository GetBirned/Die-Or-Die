extends Area2D

var open = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body):
	if body.is_in_group("die"):
		#var price = body.price
		#GameInfo.add_money(price - 1)
		GameInfo.emit_checking_out(body)
		GameInfo.emit_purchasing(body.name_description()[0])

func _on_body_exited(body):
	pass
