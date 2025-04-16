extends Node2D


func update(n: int):
	if n > 99:
		var hundreds = str(n)[0]
		var tens = str(n)[1]
		var ones = str(n)[2]
		$Hundreds.show()
		$Tens.show()
		$Ones.position.x = 8
		$Ones.scale = Vector2(.8, .8)
		$Ones.set_frame_and_progress(int(ones), 0.0)
		$Tens.position.x = 12
		$Tens.scale = Vector2(.8, .8)
		$Tens.set_frame_and_progress(int(tens), 0.0)
		$Hundreds.scale = Vector2(.8, .8)
		$Hundreds.position.x = -7
		$Hundreds.set_frame_and_progress(int(hundreds), 0.0)
	elif n > 9:
		if $Hundreds:
			$Hundreds.hide()
		var tens = str(n)[0]
		var ones = str(n)[1]
		$Tens.scale = Vector2(1,1)
		$Tens.position.x = 0
		$Tens.show()
		$Ones.position.x = 0
		$Ones.scale = Vector2(1, 1)
		$Ones.set_frame_and_progress(int(ones), 0.0)
		$Tens.set_frame_and_progress(int(tens), 0.0)
	else:
		if $Hundreds:
			$Hundreds.hide()
		$Ones.position.x = -18
		$Tens.hide()
		$Ones.scale = Vector2(1.2, 1.2)
		$Ones.set_frame_and_progress(n, 0.0)
		
