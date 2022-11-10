extends Node

var scenes : Dictionary = {
	"GameScene" : preload("res://Scenes/GameScene.tscn")
}

var active_scene

func _ready():
	load_scene(scenes["GameScene"])

func load_scene(scene : PackedScene):
	cleanup()
	active_scene = scene.instance()
	add_child(active_scene)

func cleanup():
	if(active_scene != null):
		active_scene.queue_free()
