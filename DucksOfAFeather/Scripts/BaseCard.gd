extends Control
class_name BaseCard

#Nodes
onready var up_attack_label : Label = get_node(up_attack_label_nodepath)
onready var down_attack_label : Label = get_node(down_attack_label_nodepath)
onready var left_attack_label : Label = get_node(left_attack_label_nodepath)
onready var right_attack_label : Label = get_node(right_attack_label_nodepath)
onready var health_label : Label = get_node(health_label_nodepath)
onready var egg_label : Label = get_node(egg_label_nodepath)

#Nodepaths
export (NodePath) var up_attack_label_nodepath
export (NodePath) var down_attack_label_nodepath
export (NodePath) var right_attack_label_nodepath
export (NodePath) var left_attack_label_nodepath
export (NodePath) var health_label_nodepath
export (NodePath) var egg_label_nodepath

#The resource that the card grabs all the info off, later it will use a database with resources                            
export (Resource) var card_resource

#If the card has been placed during the game
var has_been_placed = false

#The slot the card is placed on
var slot = null

#Cards stats
var attack_dictionary : Dictionary = {
	"Up" : null,
	"Down" : null,
	"Right" : null,
	"Left" : null
}
var eggs
var health = 1

func _process(delta):
	#Checks if card should die
	if health <= 0:
		die()

func _ready():
	set_stats()

func set_stats():
	#Set cards variables
	attack_dictionary = card_resource.attack_dictionary
	eggs = card_resource.eggs
	health = card_resource.health
	#Set cards labels
	up_attack_label.text = str(attack_dictionary.Up)
	down_attack_label.text = str(attack_dictionary.Down)
	right_attack_label.text = str(attack_dictionary.Right)
	left_attack_label.text = str(attack_dictionary.Left)
	health_label.text = str(card_resource.health)
	egg_label.text = str(card_resource.eggs)

#Takes damage equal to the passed in variable
func take_damage(damage):
	health -= damage
	Global.update_text_ui(health_label, str(health))

func die():
	slot.card = null
	queue_free()
