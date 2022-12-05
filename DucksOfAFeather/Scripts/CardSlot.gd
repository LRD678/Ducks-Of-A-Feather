extends TextureRect
class_name CardSlot

export (Vector2) var placement_id

var placement_manager
var card : Control = null

var surrounding_slots : Dictionary = {
	"Up" : null,
	"Down" : null,
	"Right" : null,
	"Left" : null
}

func set_placement(_placement_manager):
	placement_manager = _placement_manager
	_set_neighbours()

func set_card(child_index : int):
	card = get_child(child_index)

func _set_neighbours():
	if placement_id.x >1:
		surrounding_slots.Left = placement_manager.slot_dictionary[placement_id + Vector2.LEFT]
	if placement_id.x <5:
		surrounding_slots.Right = placement_manager.slot_dictionary[placement_id + Vector2.RIGHT]
	if placement_id.y >1:
		surrounding_slots.Up = placement_manager.slot_dictionary[placement_id + Vector2.UP]
	if placement_id.y <5:
		surrounding_slots.Down = placement_manager.slot_dictionary[placement_id + Vector2.DOWN]
