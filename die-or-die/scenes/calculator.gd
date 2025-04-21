extends Node2D

@onready var calc_digits: Array[AnimatedSprite2D] = [
	$BaseCalc/Digits/Digit6,
	$BaseCalc/Digits/Digit5,
	$BaseCalc/Digits/Digit4,
	$BaseCalc/Digits/Digit3,
	$BaseCalc/Digits/Digit2,
	$BaseCalc/Digits/Digit1,
	$BaseCalc/Digits/Digit0
]

@onready var duck_button: AnimatedSprite2D = $DuckButton
@onready var plus_button: AnimatedSprite2D = $PlusButton
@onready var minus_button: AnimatedSprite2D = $MinusButton
@onready var button_sound: AudioStreamPlayer = $ButtonSound

var money: int = 0
var last_money: int = 0

func set_money(value: int):
	last_money = money
	money = value
	update_display()

func update_display():
	var digits_str = str(money)
	var total_slots = calc_digits.size()
	var num_digits = digits_str.length()

	# Hide all digits first
	for digit in calc_digits:
		digit.visible = false

	# Show digits right-aligned
	for i in range(num_digits):
		var digit_char = digits_str[i]
		var sprite = calc_digits[i]
		sprite.visible = true
		sprite.stop()
		sprite.frame = int(digit_char)

	# Trigger button animation based on change
	if money > last_money:
		plus_button.frame = 1
		await get_tree().create_timer(0.1).timeout
		plus_button.frame = 0
	elif money < last_money:
		minus_button.frame = 1
		await get_tree().create_timer(0.1).timeout
		minus_button.frame = 0

func _quack_duck():
	duck_button.frame = 1
	$DuckSound.play()
	await get_tree().create_timer(0.15).timeout
	duck_button.frame = 0

func _on_click_duck_pressed() -> void:
	print("CLICKED THE DUCK!")
	_quack_duck()
