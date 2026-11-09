extends Moveable
class_name Crate

@export var hue: Palette.Hue

@onready var crate_sprite: Sprite2D = %Sprite2D

func _ready() -> void:
	super()
	set_color(Palette.get_color(hue))

func set_color(color: Color) -> void:
	crate_sprite.modulate = color
