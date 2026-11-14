extends Control



const UI_CLICK_BUBBLE_POP_V_01 = preload("uid://c8rjmighxy53r")
const UI_HOVER_BUBBLE_BLIP_V_02 = preload("uid://da8uwv526noka")

@onready var play: Button = %Play
@onready var settings: Button = %Settings
@onready var credits: Button = %Credits
@onready var black: ColorRect = %Black
@onready var quit: Button = %Quit
@onready var button_sound: AudioStreamPlayer = %ButtonSound

func _ready() -> void:
	_fade_in()
	play.pressed.connect(_on_play_pressed)
	settings.pressed.connect(_on_settings_pressed)
	credits.pressed.connect(_on_credits_pressed)	
	quit.pressed.connect(_on_quit_pressed)
	
	play.mouse_entered.connect(_on_play_hovered)
	settings.mouse_entered.connect(_on_settings_hovered)
	credits.mouse_entered.connect(_on_credits_hovered)
	quit.mouse_entered.connect(_on_quit_hovered)
	
func _fade_in() -> void:
	var tween := create_tween()
	tween.tween_property(black, "modulate:a", 0.0, 3.0)

func _on_play_pressed() -> void:
	await _on_button_pressed_sound()
	GameManager.go_to_level_select()

func _on_settings_pressed() -> void:
	await _on_button_pressed_sound()
	GameManager.go_to_settings()

func _on_credits_pressed() -> void:
	await _on_button_pressed_sound()
	GameManager.go_to_credits()

func _on_quit_pressed() -> void:
	_on_button_pressed_sound()
	get_tree().quit()

func _on_play_hovered() -> void:
	_on_button_hovered_sound()

func _on_settings_hovered() -> void:
	_on_button_hovered_sound()

func _on_credits_hovered() -> void:
	_on_button_hovered_sound()

func _on_quit_hovered() -> void:
	_on_button_hovered_sound()

func _on_button_pressed_sound() -> void:
	button_sound.stream = UI_CLICK_BUBBLE_POP_V_01
	button_sound.play()
	await button_sound.finished

func _on_button_hovered_sound() -> void:
	button_sound.stream = UI_HOVER_BUBBLE_BLIP_V_02
	button_sound.play()
