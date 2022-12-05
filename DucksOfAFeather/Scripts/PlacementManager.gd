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

var held_card : Control = null
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
	if held_card == null:
		#Picking up the card
		if Input.is_action_just_pressed("LeftClick"):
			for selected_card in get_tree().get_nodes_in_group("Card"):
				if selected_card.get_global_rect().has_point(get_global_mouse_position()):
					if selected_card.has_been_placed == false:
						held_card = selected_card
						if held_card.eggs > Global.eggs:
							held_card = null
	elif held_card != null:
		#Moving the card to the mouse
		held_card.rect_global_position = get_global_mouse_position() - (held_card.rect_size / 2)
		#Placing the card
		if Input.is_action_just_pressed("LeftClick"):
			if selected_drop != null:
				if selected_drop.card == null:
					if held_card.eggs <= Global.eggs:
						#Reparents the card to the slot
						held_card.get_parent().remove_child(held_card)
						selected_drop.add_child(held_card)
						held_card.rect_position = Vector2.ZERO
						held_card.slot = selected_drop
						held_card.has_been_placed = true
						selected_drop.set_card(0)
						Global.eggs -= held_card.eggs
						get_parent().update_ui()
						held_card = null
						selected_drop = null
		#Setting selected_drop to whatever slot is under the cursor
		for slot in card_slots:
			if slot.get_global_rect().has_point(get_global_mouse_position()):
				selected_drop = slot
