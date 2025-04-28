extends Node2D

@onready var shader_mat: ShaderMaterial = $Background.material as ShaderMaterial

func set_colors(color_a: Color, color_b: Color):
	shader_mat.set_shader_parameter("color_a", color_a)
	shader_mat.set_shader_parameter("color_b", color_b)
	print("Color A:", shader_mat.get_shader_parameter("color_a"))
	print("Color B:", shader_mat.get_shader_parameter("color_b"))

func show_achievement(str):
	$Achievement.show()
	$Achievement/Label.text = str
	$Achievement/Timer.start()
	await $Achievement/Timer.timeout
	$Achievement.hide()
