extends Control

const SCROLL_SPEED = 12

@onready var v_box_container: VBoxContainer = %VBoxContainer
@onready var scroll: Control = %Scroll

func _ready() -> void:
	await get_tree().process_frame
	
	var content_height = v_box_container.size.y
	var window_height = scroll.size.y
	var distance = content_height - window_height
	var duration = distance / SCROLL_SPEED
	
	var tween := create_tween()
	tween.tween_interval(2.5)
	tween.tween_property(v_box_container, "position:y", -distance, duration)
	
