extends Label

var flip = false

func _process(delta: float) -> void:
	if flip:
		if modulate.a >= 1:
			flip = false
		else:
			modulate.a += .03
			$flashTimer.start()
			await $flashTimer.timeout
	else:
		if modulate.a <= 0:
			flip = true
		else:
			modulate.a -= .03
			$flashTimer.start()
			await $flashTimer.timeout
