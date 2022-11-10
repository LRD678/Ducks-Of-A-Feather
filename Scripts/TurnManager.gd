extends Node

var turn = 1
var combat = false
var combat_countdown = 1
var turn_player = 1
#pass_turn signal to let other nodes know when the turn is changed
signal pass_turn

func pass_turn():
	#increments the turn by 1
	turn += 1
	#matches the current player and sets it
	match turn_player:
		1:
			turn_player = 2
		2:
			turn_player = 1
	#emits the pass_turn signal
	emit_signal("pass_turn")
	#handles toggling combat, it will add 1 to it everyturn and every 2 turns is a combat
	if combat_countdown == 2:
		combat = true
		combat_countdown = 0
	else:
		combat_countdown += 1
	Global.ui_manager.update_ui("ManaLabel", turn) #testing the ui_manager fuction

func _on_PassTurnButton_pressed():
	pass_turn()
