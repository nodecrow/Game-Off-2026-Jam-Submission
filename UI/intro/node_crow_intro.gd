extends Control


@onready var godot: Control = $Godot
@onready var nodecrow: Control = %Nodecrow
@onready var black_screen: ColorRect = %BlackScreen


func _ready() -> void:
	godot.hide()
	nodecrow.hide()
	
	await _fade_in_and_out(godot)
	await _fade_in_and_out(nodecrow)
	pass

func _fade_in_and_out(scene: Control) -> void:
	scene.show()
	var tween := create_tween()
	tween.tween_property(black_screen, "modulate:a", 0.0, 4.0)
	tween.tween_property(black_screen, "modulate:a", 1.0, 2.0)
	await tween.finished
	scene.hide()
