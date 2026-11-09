extends Node

class Move:
	var node: Moveable
	var direction: Vector2

const WALL_ID = 0
const CRATE_ID = 1
const SPOT_ID = 2
const PLAYER_ID = 3

var level_hue: Palette.Hue = Palette.Hue.WHITE
var base_layer: TileMapLayer
var floor_layer: TileMapLayer
var color_layers: Array[Node]
var spots: Array[Spot]
var moveables: Array[Moveable]
var past_turns: Array[Array]

func _ready() -> void:
	get_tree().scene_changed.connect(level_changed)
	level_changed()

func level_changed() -> void:
	floor_layer = get_tree().get_first_node_in_group("FloorLayer")
	base_layer = get_tree().get_first_node_in_group("LevelTileMap")
	color_layers = get_tree().get_nodes_in_group("ColorLayers")
	past_turns.clear()

func is_tile_wall(tile: Vector2i) -> bool:
	for layer: TileMapLayer in color_layers:
		if layer.get_cell_source_id(tile) == WALL_ID and layer.hue != level_hue:
			return true
	return base_layer != null and base_layer.get_cell_source_id(tile) == WALL_ID

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
	if spots.is_empty():
		return false
	for spot in spots:
		var moveable: Moveable = get_moveable_at_tile(spot.cell)
		if moveable is not Crate or moveable.hue != spot.hue:
			return false
	return true

func shift_color(hue: Palette.Hue) -> void:
	level_hue = hue
	for layer: Layer in color_layers:
		layer.on_level_hue_changed(level_hue)
		
	for spot: Spot in spots:
		spot.on_level_hue_changed(level_hue)
	
	for moveable: Moveable in moveables:
		if moveable is Crate:
			moveable.on_level_hue_changed(level_hue)
	
	floor_layer.modulate = Palette.get_color(hue)

func game_over() -> void:
	print("WIN")
