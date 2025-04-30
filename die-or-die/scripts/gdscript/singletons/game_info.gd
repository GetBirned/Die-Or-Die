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

var saved_color_a : Color = Color(1, 0, 0)  # Default red
var saved_color_b : Color = Color(0, 0, 0)  # Default black

@onready var current_score: float = 1
@onready var state = GameStates.BATTLE
@onready var money = 10
@onready var blank_value = 0
@onready var last_scored_side = null
@onready var hand_multiplier = 1
@onready var id: int = 0
@onready var hand = null
@onready var current_level = 1

var Achievements = {
	"Beginner":false, # beat level 2
	"Collector":false, # have 15 dice in your bag 
	"High Roller":false, # get a score over 1000
	"The Don":false, # beat 10 levels
	"Filthy Rich":false, # have $100
	"Wanted":false, # get a score over 10000
}

func _process(delta: float) -> void:
	if not Achievements["Beginner"] and current_level > 2:
		Achievements["Beginner"] = true
		Background.show_achievement("Beginner")
		DiceBag.unlock_die("Frequent Die")
	if not Achievements["Collector"] and DiceBag.get_dice_in_bag().size() >= 15:
		Achievements["Collector"] = true
		Background.show_achievement("Collector")
	if not Achievements["High Roller"] and current_score >= 1000:
		Achievements["High Roller"] = true
		Background.show_achievement("High Roller")
		DiceBag.unlock_die("Ouroboros Die")
	if not Achievements["The Don"] and current_level > 10:
		Achievements["The Don"] = true
		Background.show_achievement("The Don")
	if not Achievements["Filthy Rich"] and GameInfo.get_money() >= 100:
		Achievements["Filthy Rich"] = true
		Background.show_achievement("Filthy Rich")
	if not Achievements["Wanted"] and current_score >= 10000:
		Achievements["Wanted"] = true
		Background.show_achievement("Wanted")
	

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
	$ChaChing.stop()
	$ChaChing.play()
	money += value
	money_changed.emit()

func set_money(value):
	money = value
	money_changed.emit()
	
func get_money():
	return money
	
func add_score(value):
	current_score += value
	if current_score < 0:
		current_score = 0
	if value != 0:
		score_updated.emit()
	
func mult_score(value):
	current_score *= value
	score_updated.emit()

func emit_holder_updated():
	holder_updated.emit(SceneManager.get_die_scores())
