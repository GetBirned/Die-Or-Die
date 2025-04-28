extends Sprite2D
enum {NONE, HOVERING, DISPLAYING}
var state = NONE
var hovering_counter = 0
var parent
var area_rect: Rect2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# this sucks but I need to query it every frame
	area_rect = parent.get_rect() 
	var hover = detect_hover()
	match state:
		NONE:
			hide()
			hovering_counter = 0
			if hover:
				state = HOVERING
		HOVERING:
			if hovering_counter >= 25:
				state = DISPLAYING
				global_position = area_rect.end + Vector2(75, 30)
			hovering_counter += 1
			
		DISPLAYING:
			
			if parent.get_status() == 1 or parent.get_status() == 3:
				state = NONE
			else:
				global_position = get_global_mouse_position()
				global_position.y = get_global_mouse_position().y + 15
				if Input.is_action_pressed("ui_shift"):
					init_tooltip()
					$DescLabel.text = parent.name_description()[1]
					
					show()
				elif Input.is_action_pressed("ui_ctrl"):
					init_tooltip()
					$DescLabel.text = str(parent.get_side_numbers())
					show()
				else:
					hide()
				
				if !hover:
					state = NONE

func init_tooltip():
	$NameLabel.text = parent.name_description()[0]
	$DescLabel.text = parent.name_description()[1]

func detect_hover():
	var mouse_pos = get_global_mouse_position()
	return area_rect.has_point(mouse_pos)
	
