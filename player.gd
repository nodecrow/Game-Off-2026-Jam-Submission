extends Area2D

@onready var ray: RayCast2D = %RayCast2D

var tile_size = 16
var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

func _ready() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2

func _unhandled_input(event: InputEvent) -> void:
	for direction in inputs.keys():
		if event.is_action_pressed(direction):
			move(direction)

func move(direction) -> void:
	ray.target_position = inputs[direction] * tile_size
	ray.force_raycast_update() # Apparently target_position isn't updated until the next physics frame
	if not ray.is_colliding():
		position += inputs[direction] * tile_size
