extends Moveable

var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN}

func _unhandled_input(event: InputEvent) -> void:
	if moving:
		return
	for direction in inputs.keys():
		if event.is_action_pressed(direction):
			if can_move(inputs[direction]):
				move(inputs[direction])
