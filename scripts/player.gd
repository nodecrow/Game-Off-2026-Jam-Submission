extends Moveable
class_name Player


var inputs = {
	"right": Vector2i.RIGHT,
	"left": Vector2i.LEFT,
	"up": Vector2i.UP,
	"down": Vector2i.DOWN
	}

@onready var player_sprite: Sprite2D = %Sprite2D
@onready var movement_sound: AudioStreamPlayer2D = %MovementSound
@onready var shift_error_sound: AudioStreamPlayer2D = %ShiftErrorSound
@onready var animation: AnimationPlayer = %AnimationPlayer

func _ready() -> void:
	super()
	Level.player = self

func _unhandled_input(event: InputEvent) -> void:
	if moving:
		return
	for direction in inputs.keys():
		if event.is_action_pressed(direction):
			if can_move(inputs[direction]):
				Level.past_turns.append([]) # Add turn to history
				move_animation()
				move(inputs[direction])
				if Level.is_all_spots_covered():
					Level.game_over()
	
	if event.is_action_pressed("undo", true):
		Level.undo_last_move()

func move_animation() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(player_sprite, "scale", Vector2(0.75, 1.25), 0.05)
	tween.tween_property(player_sprite, "scale", Vector2(1.25, 0.75), 0.05)
	tween.tween_property(player_sprite, "scale", Vector2(1.0, 1.0), 0.05)
	movement_sound.play()

func paint_animation() -> void:
	animation.play("paint")
	await animation.animation_finished

func shift_error() -> void:
	shift_error_sound.play()
