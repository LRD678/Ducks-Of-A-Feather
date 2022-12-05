extends Node

var eggs : int = 1
var update_turn : int = 1
var turn : int = 1
var turn_player : int = 1

func update_text_ui(ui_element : Control, value):
	ui_element.text = str(value)

func update_texture_ui(ui_element : Control, value):
	ui_element.texture = value
