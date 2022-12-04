extends Node2D
class_name PlacementManager

#External Scenes
onready var card = preload("res://Scenes/BaseCard.tscn")

#Nodes
onready var hand1 = get_node(hand1_nodepath)
onready var hand2 = get_node(hand2_nodepath)

#Nodepaths
export (NodePath) var hand1_nodepath
export (NodePath) var hand2_nodepath

var held_object : Control = null
var selected_drop : Control = null
var card_slots : Array
var slot_dictionary : Dictionary

func _ready():
	card_slots = get_tree().get_nodes_in_group("CardSlot")
	for slot in card_slots:
		slot_dictionary[slot.placement_id] = slot
	for slot in card_slots:
		slot.set_placement(self)
	spawn_cards()

func spawn_cards():
	#This is a temporary function, later this script will probably be transfered to a card manager to globalize
	for hand_card in 5:
		var card_inst = card.instance()
		hand1.add_child(card_inst)
	for hand_card in 5:
		var card_inst = card.instance()
		hand2.add_child(card_inst)

func _process(delta):
	if held_object == null:
		#Picking up the card
		if Input.is_action_just_pressed("LeftClick"):
			for selected_card in get_tree().get_nodes_in_group("Card"):
				if selected_card.get_global_rect().has_point(get_global_mouse_position()):
					if selected_card.has_been_placed == false:
						held_object = selected_card
						if held_object.eggs > Global.eggs:
							held_object = null
	elif held_object != null:
		#Moving the card to the mouse
		held_object.rect_global_position = get_global_mouse_position() - (held_object.rect_size / 2)
		#Placing the card
		if Input.is_action_just_pressed("LeftClick"):
			if selected_drop != null:
				if selected_drop.card == null:
					if held_object.eggs <= Global.eggs:
						held_object.rect_global_position = selected_drop.rect_global_position + Vector2(3, 3)
						selected_drop.card = held_object
						held_object.slot = selected_drop
						held_object.has_been_placed = true
						Global.eggs -= held_object.eggs
						get_parent().update_ui()
						held_object = null
						selected_drop = null
		#Setting selected_drop to whatever slot is under the cursor
		for slot in card_slots:
			if slot.get_global_rect().has_point(get_global_mouse_position()):
				selected_drop = slot
