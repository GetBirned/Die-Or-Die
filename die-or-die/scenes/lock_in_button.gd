extends Button

func _process(delta: float) -> void:
	pass
	
func _pressed() -> void:
	CustomSignals.dice_locked_in.emit()
	disabled = true
