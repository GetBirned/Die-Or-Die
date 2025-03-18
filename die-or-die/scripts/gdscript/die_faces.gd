extends AnimatedSprite2D

func set_face(side):
	var value = side.get_value()
	var sprite = side.get_sprite()
	
	if sprite == "money" or sprite == "multiplier" or sprite == "blank" or value <= 9:
		$Digits.visible = false
		play(sprite)
		set_frame(value)
	else:
		play("blank")
		$Digits.visible = true
		$Digits/Ones.set_frame(value - ((value / 10) * 10))
		$Digits/Tens.set_frame(value / 10)
