extends Node2D
class_name Spot

@export var hue: Palette.Hue

var cell: Vector2i 
var base_layer: TileMapLayer = Level.base_layer

@onready var spot_sprite: Sprite2D = %Sprite2D

func _enter_tree() -> void:
	Level.spots.append(self)

func _exit_tree() -> void:
	Level.spots.erase(self)

func _ready() -> void:
	cell = base_layer.local_to_map(base_layer.to_local(global_position))
	set_color(Palette.get_color(hue))

func set_color(color: Color) -> void:
	spot_sprite.modulate = color

func on_level_hue_changed(layer_hue: Palette.Hue) -> void:
	if hue == layer_hue:
		self.visible = false
	else:
		self.visible = true
