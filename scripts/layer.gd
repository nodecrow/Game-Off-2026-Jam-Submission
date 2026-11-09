extends TileMapLayer
class_name Layer

@export var hue: Palette.Hue

func _ready() -> void:
	set_color(Palette.get_color(hue))

func set_color(color: Color) -> void:
	self.modulate = color
