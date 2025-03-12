extends Node

@onready var dice_dict: Dictionary = {"D6": 
	preload("res://scenes/default_die.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED),
	"Seven":
	preload("res://scenes/lucky_seven.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)}
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
