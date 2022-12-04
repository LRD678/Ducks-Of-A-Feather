extends Control
class_name GameManager

onready var mana_label = get_node(mana_label_nodepath)

export (NodePath) var mana_label_nodepath

func update_ui():
	Global.update_text_ui(mana_label, str(Global.eggs))
