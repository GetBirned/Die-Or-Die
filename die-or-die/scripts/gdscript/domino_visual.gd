extends Node2D

var threshold
var rerolls
var signals = CustomSignals

func _ready() -> void:
	CustomSignals.dice_locked_in.connect(Callable(self, "calculate_damage"))

func calculate_difficulty():
	pass

func calculate_damage():
	print("Signal received")
