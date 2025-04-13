extends TextureRect

var origin_position: Vector2

func _ready():
	origin_position = position  # Save the original position
	sway()

func sway():
	var duration = randf_range(1.5, 2.5)
	var rotation_amount = deg_to_rad(randf_range(-0.4, 0.4))

	var max_drift = 5.0
	var target_offset = Vector2(
		randf_range(-max_drift, max_drift),
		randf_range(-max_drift, max_drift)
	)

	var new_position = origin_position + target_offset

	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(self, "rotation", rotation_amount, duration)
	tween.tween_property(self, "position", new_position, duration)
	tween.tween_callback(Callable(self, "sway"))
