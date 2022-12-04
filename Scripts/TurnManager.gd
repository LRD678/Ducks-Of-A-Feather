extends Node
class_name TurnManager

#Nodes
onready var egg_anim = get_node(egg_anim_nodepath)

#Nodepaths
export (NodePath) var egg_anim_nodepath

var turn = 1
var turn_player = 1

func pass_turn():
	match turn_player:
		1:
			#Resets eggs
			Global.eggs = turn
			egg_anim.play("EggUpdate")
			get_parent().update_ui()
			#Passes to player 2
			turn += 1
			turn_player = 2
		2:
			#Triggers update phase
			update_phase()
			#Resets the rounds eggs
			Global.eggs = turn
			get_parent().update_ui()

func update_phase():
	#Do combat
	combat()
	#Reset the turn player
	turn_player = 1
	#Reset the eggs
	Global.eggs += 1
	egg_anim.play("EggUpdate")
	get_parent().update_ui()

func combat():
	for slot in get_tree().get_nodes_in_group("CardSlot"):
		if slot.placement_id == Vector2.ONE:
			for sur_slot in slot.surrounding_slots.keys():
				if slot.surrounding_slots[sur_slot] != null:
					var damage = slot.card.attack_dictionary[sur_slot]
					if slot.surrounding_slots[sur_slot].card != null: # slot.surrounding_slots[sur_slot].has_card
						slot.surrounding_slots[sur_slot].card.take_damage(damage)

func _on_PassTurnButton_pressed():
	pass_turn()
