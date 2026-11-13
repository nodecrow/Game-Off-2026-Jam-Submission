extends Moveable
class_name Crate

@export var hue: Palette.Hue

@onready var crate_sprite: Sprite2D = %Sprite2D
@onready var audio: AudioStreamPlayer2D = %AudioStreamPlayer2D


func _ready() -> void:
	super()
	set_color(Palette.get_color(hue))

func set_color(color: Color) -> void:
	crate_sprite.self_modulate = color

func on_level_hue_changed(layer_hue: Palette.Hue) -> void:
	if hue == layer_hue:
		self.modulate.a = 0.3
	else:
		self.modulate.a = 1.0

func push_sound() -> void:
	audio.play()
