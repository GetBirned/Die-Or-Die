extends Node

@onready var dice_dict: Dictionary = {
	"D6": 
	preload("res://scenes/dice/default_die.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
	,
	"Lucky 777":
	preload("res://scenes/dice/lucky_seven.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
	,
	"Twoless Die":
	preload("res://scenes/dice/twoless_die.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
	,
	"Blank Die":
	preload("res://scenes/dice/blank_die.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
	,
	"D666":
	preload("res://scenes/dice/devil_die.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
	,
	"Golden Die":
	preload("res://scenes/dice/golden_die.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
	,
	"Glass Die":
	preload("res://scenes/dice/glass_die.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
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
