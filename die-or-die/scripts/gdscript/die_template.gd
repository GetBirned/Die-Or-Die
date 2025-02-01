extends Node

signal special

@export var sides: Array = ['1','2','3','4','5','6']

func do_special():
	special.emit()
