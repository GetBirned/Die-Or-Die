extends Node2D

enum { DISPLAY, ROLLING, FACE, DRAGGING, RETURNING, HELD }

var dice_in_bag := []
var selected_die = null

@onready var calculator = $Calculator

const COLUMNS := 5
const DICE_SPACING := Vector2(180, 180)

func update_calculator():
	calculator.set_money(GameInfo.get_money())
	calculator.update_display()

func _ready():
	await SceneManager.swipe_in_left_transition(self)
	update_calculator()

	DiceBag.refill()
	for die in DiceBag.get_dice():
		add_die_from_bag(die)

func add_die_from_bag(original_die):
	var die_scene = original_die.scene_file_path
	if die_scene == "":
		push_warning("❗ Die has no scene path — cannot display.")
		return

	var die = load(die_scene).instantiate()
	add_child(die)
	dice_in_bag.append(die)

	die.show()
	die.set_physics_process(true)
	die.set_process(true)
	die.input_pickable = true

	if die.has_method("face"):
		die.call_deferred("face")

	order_die(dice_in_bag.size() - 1)

func order_die(index):
	var die = dice_in_bag[index]
	var col = index % COLUMNS
	var row = index / COLUMNS

	var screen_size = get_viewport_rect().size
	var total_rows = int(ceil(dice_in_bag.size() / float(COLUMNS)))

	var is_last_row = (row == total_rows - 1)

	var dice_in_row = COLUMNS
	if is_last_row:
		dice_in_row = dice_in_bag.size() % COLUMNS
		if dice_in_row == 0:
			dice_in_row = COLUMNS

	var spacing = Vector2(250, 250)
	var row_width = dice_in_row * spacing.x
	var total_height = total_rows * spacing.y

	# Manually set the calculator X since we know it
	var calculator_center_x = 510  # <-- Your calculator's X value!

	var row_origin_x = calculator_center_x - row_width / 2.0
	var row_origin_y = (screen_size.y - total_height) / 2.0

	var position = Vector2(
		row_origin_x + col * spacing.x,
		row_origin_y + row * spacing.y
	)

	die.return_position = position
	die.position = position
	die.status = RETURNING
	die.show()
	
func sell_die(die):
	if die in dice_in_bag:
		if dice_in_bag.size() > 5:
			dice_in_bag.erase(die)
			GameInfo.add_money(1)
			die.queue_free()

			_order_all_dice()  # Re-layout after sell
			update_calculator()

			print("🎲 Dice remaining in bag:")
			for d in dice_in_bag:
				print("- ", d.name)
		else:
			print("🚫 Cannot sell! You must have at least 5 dice remaining.")

func _order_all_dice():
	for i in range(dice_in_bag.size()):
		order_die(i)

func _on_close_pressed():
	await SceneManager.swipe_transition(self)
	SceneManager.switch_scene(SceneManager.previous_scene)
