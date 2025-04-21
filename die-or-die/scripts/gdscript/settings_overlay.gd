extends Node2D

@onready var bg = get_node("/root/Background")  # Adjust if it's under a different node

func _on_close_button_pressed() -> void:
	queue_free()

func _on_color_a_picker_color_changed(color: Color) -> void:
	bg.set_colors(color, $ColorBPicker.color)

func _on_color_b_picker_color_changed(color: Color) -> void:
	bg.set_colors($ColorAPicker.color, color)
