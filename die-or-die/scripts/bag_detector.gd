extends Area2D


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
		# this is where you need to start opening the bag!
		$BagVisual.play("open")
		# Add purchase logic here.
		# die is "over bag"
		
		
		
		
func _on_body_exited(body):
	if body.is_in_group("die"):
		# this is where you need to start closing the bag!
		$BagVisual.play("close")
