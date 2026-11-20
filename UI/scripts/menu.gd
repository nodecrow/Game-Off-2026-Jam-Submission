extends Control

@onready var play_button: JuicyButton = %PlayButton
@onready var credits_button: JuicyButton = %CreditsButton
@onready var black: ColorRect = %Black
@onready var credits: Control = %Credits


func _ready() -> void:
	
	MusicPlayer.play_menu_music()
	credits.hide()
	_fade_in()
	play_button.pressed.connect(_on_play_pressed)
	credits_button.pressed.connect(_on_credits_pressed)	
	
	
func _fade_in() -> void:
	var tween := create_tween()
	tween.tween_property(black, "modulate:a", 0.0, 3.0)

func _on_play_pressed() -> void:
	GameManager.go_to_level_select()

func _on_credits_pressed() -> void:
	credits.show()
