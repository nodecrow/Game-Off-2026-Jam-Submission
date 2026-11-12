extends Control

@onready var play: Button = %Play
@onready var settings: Button = %Settings
@onready var credits: Button = %Credits

func _ready() -> void:

	play.pressed.connect(GameManager.go_to_level_select)
	settings.pressed.connect(GameManager.go_to_settings)
	credits.pressed.connect(GameManager.go_to_credits)	
