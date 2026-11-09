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
	
	if event.is_action_pressed("undo"):
		Level.undo_last_move()
