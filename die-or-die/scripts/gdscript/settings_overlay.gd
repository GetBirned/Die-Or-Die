extends Node2D

@onready var bg = get_node("/root/Background")

func _ready():
	# Load saved colors
	$ColorAPicker.color = GameInfo.saved_color_a
	$ColorBPicker.color = GameInfo.saved_color_b

	# Also update background with saved colors
	bg.set_colors(GameInfo.saved_color_a, GameInfo.saved_color_b)

func _on_close_button_pressed() -> void:
	queue_free()

func _on_color_a_picker_color_changed(color: Color) -> void:
	GameInfo.saved_color_a = color
	bg.set_colors(color, $ColorBPicker.color)
	$ColorAPicker.color = color

func _on_color_b_picker_color_changed(color: Color) -> void:
	GameInfo.saved_color_b = color
	bg.set_colors($ColorAPicker.color, color)
	$ColorBPicker.color = color
