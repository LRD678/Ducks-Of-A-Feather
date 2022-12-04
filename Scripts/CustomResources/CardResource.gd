extends Resource
class_name Card

export (int, 0, 10) var eggs
export (int) var health
export (Dictionary) var attack_dictionary = {
	"Up" : 0,
	"Down" : 0,
	"Left" : 0,
	"Right" : 0
}
