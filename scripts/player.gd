extends Moveable

var inputs = {
	"right": Vector2i.RIGHT,
	"left": Vector2i.LEFT,
	"up": Vector2i.UP,
	"down": Vector2i.DOWN
	}

func _unhandled_input(event: InputEvent) -> void:
	if moving:
		return
	for direction in inputs.keys():
		if event.is_action_pressed(direction):
			if can_move(inputs[direction]):
				Level.past_turns.append([])
				move(inputs[direction])
				if Level.is_all_spots_covered():
					Level.game_over()
	
	if event.is_action_pressed("undo", true):
		Level.undo_last_move()
	
	if event.is_action_pressed("blue"):
		Level.shift_color(Palette.Hue.BLUE)
	if event.is_action_pressed("red"):
		Level.shift_color(Palette.Hue.RED)
	if event.is_action_pressed("yellow"):
		Level.shift_color(Palette.Hue.YELLOW)
	if event.is_action_pressed("green"):
		Level.shift_color(Palette.Hue.GREEN)
