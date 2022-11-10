extends Node
class_name UIManager

#Dictionary for ui nodes to be updated
onready var ui_nodes : Dictionary = {
	"DiscardLabel" : get_node(discard_label_nodepath),
	"DeckLabel" : get_node(deck_label_nodepath),
	"ManaLabel" : get_node(mana_label_nodepath)
}

#Nodepath variables instead of direct pathing incase of scene tree changing
export (NodePath) var discard_label_nodepath
export (NodePath) var deck_label_nodepath
export (NodePath) var mana_label_nodepath

func update_ui(ui_element, value):
	#a function to update the selected visual of the ui, call this after any changes that affect ui
	var selected_element = ui_nodes[ui_element]
	if selected_element.is_class("Label"):
		selected_element.text = str(value)
	if selected_element.is_class("Button") or selected_element.is_class("TextureRect"):
		selected_element.texture = value
