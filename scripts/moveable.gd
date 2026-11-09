extends Node2D
class_name Moveable

var animation_speed: float = 0.2
var tile_size: int = 16
var tween: Tween

func _ready() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2

func can_move(direction: Vector2) -> bool:
	return true
	
func move(direction: Vector2) -> void:
	slide(direction)

func slide(direction: Vector2) -> void:
	tween = create_tween()
	tween.tween_property(self, "position",
		position + direction * tile_size, animation_speed).set_trans(Tween.TRANS_SINE)
