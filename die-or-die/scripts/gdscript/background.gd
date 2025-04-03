extends ColorRect

@onready var shader_mat := material as ShaderMaterial

func _process(delta):
	var mouse_uv = get_local_mouse_position() / size
	shader_mat.set_shader_parameter("mouse_position", mouse_uv)
