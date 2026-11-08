extends Node2D
class_name Moveable


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
	position += direction * tile_size
