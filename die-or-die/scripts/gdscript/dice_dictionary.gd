extends Node

@onready var dice_dict = {"D6": {
							"visual": default_visual(),
							"script": default_script()},
						"Marble": {
							"visual": default_visual(),
							"script": default_script()},
						"Coin": {
							"visual": default_visual(),
							"script": default_script()},
						"Sticky": {
							"visual": default_visual(),
							"script": default_script()},
						"Devil": {
							"visual": default_visual(),
							"script": default_script()},
						"Glass": {
							"visual": default_visual(),
							"script": default_script()},
						"Greedy": {
							"visual": default_visual(),
							"script": default_script()},
						"Random": {
							"visual": default_visual(),
							"script": default_script()},
						"Seven": {
							"visual": default_visual(),
							"script": default_script()},
						"Shy": {
							"visual": default_visual(),
							"script": default_script()}}
						
func default_visual():
	return "" #TODO path to a d6 visual scene

func default_script():
	return "" #TODO path to a d6 script scene
