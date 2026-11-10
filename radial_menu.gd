extends Control

@export var radius = 120
@onready var buttons: Control = %Buttons

var num
var active = false

func _ready() -> void:
	buttons.hide()
	num = buttons.get_child_count()
	for b in buttons.get_children():
		b.position = position
