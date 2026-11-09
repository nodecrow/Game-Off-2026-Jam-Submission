extends Node2D
class_name Moveable

var animation_speed: float = 0.15
var tween: Tween
var moving: bool = false
var cell: Vector2i
var tilemap: TileMapLayer = Level.tilemap

func _enter_tree() -> void:
	Level.moveables.append(self)

func _exit_tree() -> void:
	Level.moveables.erase(self)

func _ready() -> void:
	cell = tilemap.local_to_map(tilemap.to_local(global_position))

# Future Note For Self: Walk through simple example to understand recursion Player -> Box1 -> Box2 -> OpenTile
# Recursion collapses into a single true/false 
func can_move(direction: Vector2i) -> bool:
	if Level.is_tile_wall(cell + direction):
		return false

	var moveable: Moveable = Level.get_moveable_at_tile(cell + direction)
	if moveable:
		return moveable.can_move(direction)
	return true

# A continuation of above, this function gets all of the moveables in the chain and recurses slide() on each of them
# The recursion also works here for tracking the moves. Each key press initiates an empty Array
# Recursion collapses each add_move_to_turn into the array
func move(direction: Vector2i) -> void:
	var moveable: Moveable = Level.get_moveable_at_tile(cell + direction)
	if moveable:
		moveable.move(direction)
	slide(direction)
	Level.add_move_to_turn(self, direction)


func slide(direction: Vector2i) -> void:
	cell += direction
	tween = create_tween()
	tween.tween_property(self, "global_position",
		tilemap.to_global(tilemap.map_to_local(cell)), animation_speed).set_trans(Tween.TRANS_SINE)
	moving = true
	await tween.finished
	moving = false
