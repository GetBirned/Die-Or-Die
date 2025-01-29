extends Camera3D

@onready var target_fov = fov

var rate = 30

func _process(delta):
	if abs(fov - target_fov) < 1:
		fov = target_fov
	elif fov < target_fov:
		fov += rate * delta
	else:
		fov -= rate * delta


func _on_area_2d_mouse_entered():
	target_fov = 30


func _on_area_2d_mouse_exited():
	target_fov = 35
