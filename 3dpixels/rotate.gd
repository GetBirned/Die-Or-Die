extends MeshInstance3D


var rotation_speed = 60

func _process(delta):
	rotate_y(deg_to_rad(rotation_speed*delta))
	rotate_x(deg_to_rad(rotation_speed*delta))


func _on_area_2d_mouse_entered():
	rotation_speed = 120


func _on_area_2d_mouse_exited():
	rotation_speed = 60
