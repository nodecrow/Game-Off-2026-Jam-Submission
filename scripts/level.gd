extends Node

class Move:
	var node: Moveable
	var direction: Vector2

class ColorShift:
	var old_hue: Palette.Hue

const WALL_ID = 0
const CRATE_ID = 1
const SPOT_ID = 2
const PLAYER_ID = 3

var level_hue: Palette.Hue = Palette.Hue.WHITE
var player: Player
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
		if node.cell == tile and not (node is Crate and node.hue == level_hue):
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
		for move in last_moves:
			if move is Move:
				move.node.slide(-move.direction)
				if move.node is Player:
					player.move_animation()
				if move.node is Crate:
					move.node.push_sound()
			if move is ColorShift:
				apply_hue(move.old_hue)

func is_all_spots_covered() -> bool:
	if spots.is_empty():
		return false
	for spot in spots:
		var moveable: Moveable = get_moveable_at_tile(spot.cell)
		if moveable is not Crate or moveable.hue != spot.hue:
			return false
	return true

func shift_color(new_hue: Palette.Hue) -> void:
	if not can_shift(new_hue):
		return
	
	past_turns.append([])
	var color_change = ColorShift.new()
	color_change.old_hue = level_hue
	past_turns.back().append(color_change)
	apply_hue(new_hue)

func apply_hue(new_hue: Palette.Hue) -> void:
	if new_hue == level_hue:
		return
	level_hue = new_hue
	await player.paint_animation()
	for layer: Layer in color_layers:
		layer.on_level_hue_changed(level_hue)
		
	for spot: Spot in spots:
		spot.on_level_hue_changed(level_hue)
	
	for moveable: Moveable in moveables:
		if moveable is Crate:
			moveable.on_level_hue_changed(level_hue)
			
	var tween := create_tween()
	tween.tween_property(floor_layer, "modulate", Palette.get_color(new_hue), 0.2)

## This shit is really confusing, I apologize to my future self for this. Also next time I seriously
## should just design the layers to be better because this is awful
func can_shift(new_hue: Palette.Hue) -> bool:
	
	if new_hue == level_hue:
		return true
	# Find current layer
	var current_layer = null
	for layer: Layer in color_layers:
		if layer.hue == level_hue:
			current_layer = layer
			break
	# For each player and crate check if there is a tile from the current
	# color layer
	if current_layer != null:
		for moveable: Moveable in moveables:
			if current_layer.get_cell_source_id(moveable.cell) == WALL_ID:
				return false
	
	# Checks if a crate OR player is in the spot of an invisible crate
	for moveable: Moveable in moveables:
		if moveable is Crate and moveable.hue == level_hue:
			if moveable.cell == player.cell:
				return false
			for different_moveable: Moveable in moveables:
				if different_moveable.cell == moveable.cell and different_moveable != moveable:
					return false
	return true

func game_over() -> void:
	print("WIN")
