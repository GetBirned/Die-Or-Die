extends Node

enum GameStates {BATTLE, SHOP, ROLLING}

signal rolling
signal battle
signal money_changed
signal dice_locked


@onready var current_score: float = 1
@onready var state = GameStates.BATTLE
@onready var money = 0
@onready var blank_value = 0

func reset_score():
	current_score = 0

func emit_rolling():
	rolling.emit()
	
func emit_battle():
	battle.emit()

func add_money(value):
	money += value
	money_changed.emit()
