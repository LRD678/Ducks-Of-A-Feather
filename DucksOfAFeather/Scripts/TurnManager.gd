extends Node
class_name TurnManager

#Nodes
onready var egg_anim = get_node(egg_anim_nodepath)

#Nodepaths
export (NodePath) var egg_anim_nodepath

func pass_turn():
	match turn_player:
		1:
			#Resets eggs
			Global.eggs = Global.turn
			egg_anim.play("EggUpdate")
			get_parent().update_ui()
			#Passes to player 2
			Global.turn += 1
			Global.turn_player = 2
		2:
			#Triggers update phase
			update_phase()
			#Resets the rounds eggs
			Global.eggs = Global.turn
			egg_anim.play("EggUpdate")
			get_parent().update_ui()

func update_phase():
	#Do combat
	combat()
	#End the game when the turn = 10
	if Global.update_turn == 10:
		get_tree().quit()
	#Reset the turn player
	Global.update_turn += 1
	Global.turn_player = 1

func combat():
	var card_slots = get_tree().get_nodes_in_group("CardSlot")
	for slot in card_slots:
		if slot.placement_id == Vector2.ONE:
			for sur_slot in slot.surrounding_slots.keys():
				if slot.surrounding_slots[sur_slot] != null:
					var damage = slot.card.attack_dictionary[sur_slot]
					if slot.surrounding_slots[sur_slot].card != null: # slot.surrounding_slots[sur_slot].has_card
						slot.surrounding_slots[sur_slot].card.take_damage(damage)

func _on_PassTurnButton_pressed():
	pass_turn()
