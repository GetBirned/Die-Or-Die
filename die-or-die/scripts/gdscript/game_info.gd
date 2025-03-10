extends Node

enum GameStates {BATTLE, SHOP}

@onready var current_score: float = 1

@onready var state = GameStates.BATTLE

@onready var money = 0

@onready var blank_value = 0

func reset_score():
	current_score = 0
