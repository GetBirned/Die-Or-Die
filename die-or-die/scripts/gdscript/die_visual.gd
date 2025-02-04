extends Node2D

@export var top_face: int = 1
@export var left_face: int = 1
@export var right_face: int = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$TopFace.frame = top_face - 1
	$LeftFace.frame = left_face - 1
	$RightFace.frame = right_face - 1
	
	
