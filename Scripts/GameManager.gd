extends Control

onready var mana_label = get_node(mana_label_nodepath)

export (NodePath) var mana_label_nodepath

var mana = 1

func update_ui():
	Global.update_text_ui(mana_label, str(mana))

func add_mana():
	mana += 1
	Global.update_text_ui(mana_label, str(mana))
