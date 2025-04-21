extends Node2D


func update(n: int):
	if n > 999:
		
		var thousands = str(n)[0]
		var hundreds = str(n)[1]
		var tens = str(n)[2]
		var ones = str(n)[3]
		$Thousands.show()
		$Hundreds.show()
		$Tens.show()
		$Ones.position.x = 11
		$Tens.position.x = 16
		$Hundreds.position.x = -16
		$Thousands.position.x = -11
		$Ones.set_frame_and_progress(int(ones), 0.0)
		$Tens.set_frame_and_progress(int(tens), 0.0)
		$Hundreds.set_frame_and_progress(int(hundreds), 0.0)
		$Thousands.set_frame_and_progress(int(thousands), 0.0)
		$Hundreds.scale = Vector2(.65, .65)
		$Tens.scale = Vector2(.65, .65)
		$Ones.scale = Vector2(.65, .65)
		$Thousands.scale = Vector2(.65, .65)
	elif n > 99:
		var hundreds = str(n)[0]
		var tens = str(n)[1]
		var ones = str(n)[2]
		$Thousands.hide()
		$Hundreds.show()
		$Tens.show()
		$Ones.position.x = 8
		$Ones.scale = Vector2(.8, .8)
		$Ones.set_frame_and_progress(int(ones), 0.0)
		$Tens.position.x = 12
		$Tens.scale = Vector2(.8, .8)
		$Tens.set_frame_and_progress(int(tens), 0.0)
		$Hundreds.scale = Vector2(.8, .8)
		$Hundreds.position.x = -30
		$Hundreds.set_frame_and_progress(int(hundreds), 0.0)
	elif n > 9:
		$Thousands.hide()
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
		$Thousands.hide()
		if $Hundreds:
			$Hundreds.hide()
		$Ones.position.x = -18
		$Tens.hide()
		$Ones.scale = Vector2(1.2, 1.2)
		$Ones.set_frame_and_progress(n, 0.0)
		
