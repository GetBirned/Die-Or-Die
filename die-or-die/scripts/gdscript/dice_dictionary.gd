extends Node

@onready var dice_dict: Dictionary = {
	"D6": 
	preload("res://scenes/dice/default_die.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
	,
	"Seven":
	preload("res://scenes/dice/lucky_seven.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
	,
	"Twoless":
	preload("res://scenes/dice/twoless_die.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
	,
	"Blank":
	preload("res://scenes/dice/blank_die.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
	,
	"Devil":
	preload("res://scenes/dice/devil_die.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
	,
	"Golden":
	preload("res://scenes/dice/golden_die.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
	,
	"Glass":
	preload("res://scenes/dice/glass_die.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
	,
	"Odd":
	preload("res://scenes/dice/odd_die.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
	,
	"Even":
	preload("res://scenes/dice/even_die.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
	,
	"Lovers":
	preload("res://scenes/dice/lovers_die.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
	,
	}
						#"Marble": {
							#"visual": default_visual(),
							#"script": default_script()},
						#"Coin": {
							#"visual": default_visual(),
							#"script": default_script()},
						#"Sticky": {
							#"visual": default_visual(),
							#"script": default_script()},
						#"Devil": {
							#"visual": default_visual(),
							#"script": default_script()},
						#"Glass": {
							#"visual": default_visual(),
							#"script": default_script()},
						#"Greedy": {
							#"visual": default_visual(),
							#"script": default_script()},
						#"Random": {
							#"visual": default_visual(),
							#"script": default_script()},
						#"Seven": {
							#"visual": default_visual(),
							#"script": default_script()},
						#"Shy": {
							#"visual": default_visual(),
							#"script": default_script()}}
