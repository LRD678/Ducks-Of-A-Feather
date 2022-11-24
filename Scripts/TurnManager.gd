extends Node

var turn_player = 1

func pass_turn():
	match turn_player:
		1:
			turn_player = 2
		2:
			update_phase()

func update_phase():
	turn_player = 1
	get_parent().add_mana()

func _on_PassTurnButton_pressed():
	pass_turn()
