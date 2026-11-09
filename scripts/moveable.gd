extends Node2D
class_name Moveable

var animation_speed: float = 0.15
var tile_size: int = 16
var tween: Tween
var moving: bool = false

func _enter_tree() -> void:
	Level.moveables.append(self)

func _exit_tree() -> void:
	Level.moveables.erase(self)
	
# Future Note For Self: Walk through simple example to understand recursion Player -> Box1 -> Box2 -> OpenTile
# Recursion collapses into a single true/false 
func can_move(direction: Vector2) -> bool:
	if Level.is_tile_wall(position / tile_size + direction):
		return false

	var moveable: Moveable = Level.get_moveable_at_tile(position / tile_size + direction)
	if moveable:
		return moveable.can_move(direction)
	return true

# A continuation of above, this function gets all of the moveables in the chain and recurses slide() on each of them
# The recursion also works here for tracking the moves. Each key press initiates an empty Array
# Recursion collapses each add_move_to_turn into the array
func move(direction: Vector2) -> void:
	var moveable: Moveable = Level.get_moveable_at_tile(position / tile_size + direction)
	if moveable:
		moveable.move(direction)
	slide(direction)
	
	Level.add_move_to_turn(self, direction)

func slide(direction: Vector2) -> void:
	tween = create_tween()
	tween.tween_property(self, "position",
		position + (direction * tile_size), animation_speed).set_trans(Tween.TRANS_SINE)
	moving = true
	await tween.finished
	moving = false
