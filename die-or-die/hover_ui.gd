extends Node2D
enum {NONE, HOVERING, DISPLAYING}
var state = NONE
var hovering_counter = 0
var parent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	init_tooltip()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match (state):
		NONE:
			$ToolTipBox.hide()
			
		HOVERING:
			if hovering_counter >= 10:
				state = DISPLAYING
			hovering_counter += 1
			
		DISPLAYING:
			$ToolTipBox.show()

func init_tooltip():
	$ToolTipBox/Label.text = parent.description

func _on_mouse_shape_entered(shape_idx: int) -> void:
	print("entered")
	state = HOVERING

func _on_mouse_shape_exited(shape_idx: int) -> void:
	print("exited")
	state = NONE


func _on_mouse_entered() -> void:
	print("entered")
	state = HOVERING


func _on_mouse_exited() -> void:
	print("exited")
	state = NONE
