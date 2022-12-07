extends Node

var card_scenes : Array = [
	preload("res://Resources/Duck.tres"),
	preload("res://Resources/RoboDuck.tres"),
	preload("res://Resources/PilonDuck.tres")
]

var cards : Dictionary = {
	"Duck" : card_scenes[0],
	"RoboDuck" : card_scenes[1],
	"PylonDuck" : card_scenes[2]
}

func get_card(card_name : String):
	var scene =  cards.get(card_name).value
