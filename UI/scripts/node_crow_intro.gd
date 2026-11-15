extends Control

# Intro Nodes
@onready var game_off: Control = %"Game Off"
@onready var nodecrow: Control = %Nodecrow
@onready var black_screen: ColorRect = %BlackScreen

func _ready() -> void:
	# Intro Sequence
	game_off.hide()
	nodecrow.hide()

	await _fade_in_and_out(game_off)
	game_off.queue_free()
	await _fade_in_and_out(nodecrow)
	nodecrow.queue_free()
	
	GameManager.go_to_main_menu()

func _fade_in_and_out(scene: Control) -> void:
	scene.show()
	var tween := create_tween()
	tween.tween_property(black_screen, "modulate:a", 0.0, 4.0)
	tween.tween_property(black_screen, "modulate:a", 1.0, 2.0)
	await tween.finished
