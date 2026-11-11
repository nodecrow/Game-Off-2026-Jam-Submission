extends TileMapLayer
class_name Layer

@export var hue: Palette.Hue

func _ready() -> void:
	set_color(Palette.get_color(hue))

func set_color(color: Color) -> void:
	self.self_modulate = color

func on_level_hue_changed(layer_hue: Palette.Hue) -> void:
	if hue == layer_hue:
		self.visible = false
	else:
		self.visible = true
