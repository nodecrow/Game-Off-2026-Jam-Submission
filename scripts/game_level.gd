extends Node2D
class_name GameLevel

@export var available_colors: Array[Palette.Hue] = []
@export var optimal_moves: int

func _ready() -> void:
	MusicPlayer.play_random_track()
	var radial_menu_button: ColorWheel = get_tree().get_first_node_in_group("ColorWheel")
	radial_menu_button.set_available_colors(available_colors)
