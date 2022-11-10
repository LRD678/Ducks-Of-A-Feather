extends Node

onready var ui_manager : UIManager

func _ready():
	#Timer is in place to offer a short delay after running, otherwise it may throw an error for an inexistant ui_manager
	yield(get_tree().create_timer(0.00001), "timeout")
	ui_manager = get_tree().get_nodes_in_group("UIManager")[0]
