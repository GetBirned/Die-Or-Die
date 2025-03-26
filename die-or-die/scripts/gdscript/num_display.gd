extends Node2D


func update(n: int):
	if n > 9:
		var tens = str(n)[0]
		var ones = str(n)[1]
		$Tens.show()
		$Ones.position.x = 0
		$Ones.scale = Vector2(1, 1)
		$Ones.set_frame_and_progress(int(ones), 0.0)
		$Tens.set_frame_and_progress(int(tens), 0.0)
	else:
		$Ones.position.x = -18
		$Tens.hide()
		$Ones.scale = Vector2(1.2, 1.2)
		$Ones.set_frame_and_progress(n, 0.0)
		
