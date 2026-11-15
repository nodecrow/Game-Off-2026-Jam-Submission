extends Node

@onready var button_click: AudioStreamPlayer = %ButtonClick
@onready var button_hover: AudioStreamPlayer = %ButtonHover
@onready var wheel_open: AudioStreamPlayer = %WheelOpen
@onready var wheel_hover: AudioStreamPlayer = %WheelHover
@onready var wheel_close: AudioStreamPlayer = %WheelClose

func play_button_click() -> void:
	button_click.play()

func play_button_hover() -> void:
	button_hover.play()

func play_wheel_open() -> void:
	wheel_open.play()

func play_wheel_hover() -> void:
	wheel_hover.play()

func play_wheel_close() -> void:
	wheel_close.play()
