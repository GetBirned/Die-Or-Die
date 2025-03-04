extends Area2D

var held_die
# Called when the node enters the scene tree for the first time.
func _ready():
	held_die = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func register_die(die):
	held_die = die
	
func clear_die():
	held_die = null

func _on_body_entered(body):
	if held_die == null and body.is_in_group("die"):
		body.add_space(self, global_position)

func _on_body_exited(body):
	if body.is_in_group("die"):
		body.remove_space(self)
