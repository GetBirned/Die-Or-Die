extends Node

enum GameStates {BATTLE, SHOP, ROLLING}

signal rolling
signal battle
signal money_changed
signal dice_locked
signal bag_updated
signal score_updated
signal holder_updated
signal checking_out
signal purchasing

@onready var current_score: float = 1
@onready var state = GameStates.BATTLE
@onready var money = 10
@onready var blank_value = 0
@onready var last_scored_side = null
@onready var hand_multiplier = 1
@onready var hand = null
@onready var id = 0

func increment_and_get():
	id += 1
	return id

func reset_score():
	current_score = 0
	score_updated.emit()

func emit_rolling():
	rolling.emit()
	
func emit_battle():
	battle.emit()
	
func emit_checking_out(die):
	checking_out.emit(die)
	
	
func emit_purchasing(key):
	purchasing.emit(key)

func emit_bag_updated():
	bag_updated.emit()

func add_money(value):
	money += value
	money_changed.emit()
	
func get_money():
	return money
	
func add_score(value):
	current_score += value
	if value != 0:
		score_updated.emit()
	
func mult_score(value):
	current_score *= value
	score_updated.emit()

func emit_holder_updated():
	holder_updated.emit(SceneManager.get_die_scores())
