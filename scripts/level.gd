extends Node

class Move:
	var node: Moveable
	var direction: Vector2

const WALL_ID = 0
const CRATE_ID = 2
const SPOT_ID = 3
const PLAYER_ID = 4

var tilemap: TileMapLayer
var moveables: Array[Moveable]
var past_turns: Array[Array]

func _ready() -> void:
	get_tree().scene_changed.connect(level_changed)
	level_changed()

func level_changed() -> void:
	tilemap = get_tree().get_first_node_in_group("LevelTileMap")
	past_turns.clear()
	

func is_tile_wall(tile: Vector2i) -> bool:
	return tilemap != null and tilemap.get_cell_source_id(tile) == WALL_ID

func get_moveable_at_tile(tile: Vector2i) -> Moveable:
	for node: Moveable in moveables:
		if node.cell == tile:
			return node
	return null

func add_move_to_turn(node: Moveable, direction: Vector2i) -> void:
	var move := Move.new()
	move.node = node
	move.direction = direction
	past_turns.back().append(move)

func undo_last_move() -> void:
	if not past_turns.is_empty():
		var last_moves: Array = past_turns.pop_back()
		for move: Move in last_moves:
			move.node.slide(-move.direction)

func is_all_spots_covered() -> bool:
	var spots: Array[Vector2i] = tilemap.get_used_cells_by_id(SPOT_ID)	
	for spot in spots:
		var object_on_spot: Moveable = get_moveable_at_tile(spot)
		if object_on_spot == null or object_on_spot is not Crate:
			return false
	return true

func game_over() -> void:
	print("WIN")
