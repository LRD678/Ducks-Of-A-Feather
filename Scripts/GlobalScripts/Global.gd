extends Node

var eggs = 1

func update_text_ui(ui_element : Control, value):
	ui_element.text = str(value)

func update_texture_ui(ui_element : Control, value):
	ui_element.texture = value
