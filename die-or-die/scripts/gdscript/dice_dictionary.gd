extends Node

@onready var dice_dict: Dictionary = {"D6": 
	preload("res://scenes/default_die.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED),
	"Seven":
	preload("res://scenes/lucky_seven.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED),
	"Twoless":
	preload("res://scenes/twoless_die.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED),
	"Blank":
	preload("res://scenes/blank_die.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED),
	"Devil":
	preload("res://scenes/devil_die.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED),
	"Golden":
	preload("res://scenes/golden_die.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED),
	"Glass":
	preload("res://scenes/glass_die.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)}
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
