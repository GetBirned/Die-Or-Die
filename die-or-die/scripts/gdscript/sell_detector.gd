extends Area2D

var open = false

@onready var calculator = get_node("../Calculator")

func _ready() -> void:
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func update_calculator():
	calculator.set_money(GameInfo.money)

func _on_body_entered(body):
	if body.is_in_group("die"):
		var num_dice = DiceBag.get_dice_in_bag().size()
		if num_dice > 5:
			open = true
			GameInfo.add_money(1)
			update_calculator()

			# Remove die from DiceBag
			var die_name = body.name_description()[0]
			
			# Find and remove one matching die inside DiceBag
			for die in DiceBag.get_dice_in_bag():
				if die.name_description()[0] == die_name:
					DiceBag.kill_die(die)
					break

			# Remove visual clone
			body.queue_free()

			print("💸 Sold die! Money is now: $%s" % GameInfo.get_money())

			# Print updated dice list
			var dice_names = []
			for die in DiceBag.get_dice_in_bag():
				dice_names.append(die.name_description()[0])
			print("🎲 Dice still in bag:", dice_names)

		else:
			print("🚫 Not enough dice to sell! Only %s dice left." % num_dice)

func _on_body_exited(body):
	if body.is_in_group("die") and open:
		open = false
