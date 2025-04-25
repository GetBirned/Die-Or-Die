extends Area2D

var held_die

# Called when the node enters the scene tree for the first time.
func _ready():
	held_die = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_die():
	return held_die

func register_die(die):
	held_die = die
	GameInfo.emit_holder_updated()
	DiceBag.hold(die)
	
func is_free():
	return held_die == null
	
func clear_die():
	DiceBag.unhold(held_die)
	held_die = null
	GameInfo.emit_holder_updated()
