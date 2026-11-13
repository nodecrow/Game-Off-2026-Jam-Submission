extends Node2D

@export var available_colors: Array[Palette.Hue] = []

func _ready() -> void:
	var radial_menu_button: ColorWheel = get_tree().get_first_node_in_group("ColorWheel")
	radial_menu_button.set_available_colors(available_colors)
