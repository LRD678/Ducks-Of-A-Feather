extends Node
class_name TurnManager

onready var card = preload("res://Scenes/BaseCard.tscn")

#Nodes
onready var egg_anim = get_node(egg_anim_nodepath)

#Nodepaths
export (NodePath) var egg_anim_nodepath

var turn_order:Array = [[1,2], [2,1]]
var current_turn_order = 0
var current_phase = 0

class custom_sort:
	static func sort_ascending(a, b):
		if a.health < b.health:
			return true
		return false
		
func start_game():
	Global.turn = 1
	current_phase = 0
	begin_phase(current_phase)

func pass_turn():
	#Drawing cards: VERY TEMPORARY, ADD THIS TO A CARD MANAGER LATER USING SIGNALS
	var hand = get_parent().get_node("GamePlay/HBox/Hand" + str(Global.turn_player) + "/CanvasLayer/VBox")
	if hand.get_child_count() < 5:
		var card_inst = card.instance()
		hand.add_child(card_inst)
		card_inst.set_player(Global.turn_player)
	#Increments the phase
	current_phase += 1
	if current_phase > 1:
		#Checks if player 2 has gone, then it updates
		begin_update_phase()
	else:
		begin_phase(current_phase)

func begin_phase(phase:int):
	#Resets the turn player
	Global.turn_player = turn_order[current_turn_order][phase]
	#Updates the UI and resets the eggs
	Global.eggs = Global.rounds
	egg_anim.play("EggUpdate")
	get_parent().update_ui()

func begin_update_phase():
	update_phase()
	current_turn_order += 1
	if current_turn_order > 1:
		current_turn_order = 0
	current_phase = 0
	begin_phase(current_phase)

func update_phase():
	#Do combat
	combat()
	#End the game when the turn = 10
	if Global.rounds == 10:
		get_tree().quit()
	#Reset the turn player
	Global.rounds += 1

func combat():
	var card_slots = get_tree().get_nodes_in_group("CardSlot")
	var cards : Array = []
	for slot in card_slots:
		if slot.card != null:
			cards.append(slot.card)
	cards.sort_custom(custom_sort, "sort_ascending")
	for card in cards:
		var surrounding_slots = card.slot.surrounding_slots
		#Goes through each slot around the card
		for sur_slot in surrounding_slots.keys():
			if surrounding_slots[sur_slot] != null:
				var damage = card.attack_dictionary[sur_slot]
				#Makes sure the card isnt null
				if surrounding_slots[sur_slot].card != null: # slot.surrounding_slots[sur_slot].has_card
					var target_card = surrounding_slots[sur_slot].card
					#Checks if it belongs to the other player
					if target_card.player != card.player:
						#Deals the damage
						target_card.take_damage(damage)
						#Checks if the card would die, if so it removes it from the queue
						if target_card.health <= 0:
							cards.erase(card)

func _on_PassTurnButton_pressed():
	pass_turn()
