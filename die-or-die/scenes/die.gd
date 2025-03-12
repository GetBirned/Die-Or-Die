extends AnimatedSprite2D

func enable_blur():
	material.set_shader_parameter("enabled", true)
	
func disable_blur():
	material.set_shader_parameter("enabled", false)
