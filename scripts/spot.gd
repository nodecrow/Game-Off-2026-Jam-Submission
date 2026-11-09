extends Node2D
class_name Spot

@export var hue: Palette.Hue

var cell: Vector2i 
var tilemap: TileMapLayer = Level.tilemap

@onready var spot_sprite: Sprite2D = %Sprite2D

func _enter_tree() -> void:
	Level.spots.append(self)

func _exit_tree() -> void:
	Level.spots.erase(self)

func _ready() -> void:
	cell = tilemap.local_to_map(tilemap.to_local(global_position))
	set_color(Palette.get_color(hue))

func set_color(color: Color) -> void:
	spot_sprite.modulate = color
