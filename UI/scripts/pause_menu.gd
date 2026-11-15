extends CanvasLayer

@onready var resume_button: JuicyButton = %ResumeButton
@onready var settings_button: JuicyButton = $Control/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/SettingsButton
@onready var level_select_button: JuicyButton = %LevelSelectButton
@onready var main_menu_button: JuicyButton = %MainMenuButton
@onready var control: Control = %Control
@onready var settings: CanvasLayer = %Settings
@onready var dim: ColorRect = %Dim

func _ready() -> void:
	settings.hide()
	
	resume_button.pressed.connect(func() -> void:
		hide()
		get_tree().paused = false)
	
	settings_button.pressed.connect(func() -> void:
		control.hide()
		settings.show()
		dim.hide()
		)

	settings.closed.connect(func() -> void:
		control.show()
		dim.show()
		)

	level_select_button.pressed.connect(func() -> void:
		get_tree().paused = false
		hide()
		GameManager.go_to_level_select())
		
	main_menu_button.pressed.connect(func() -> void:
		get_tree().paused = false
		hide()
		GameManager.go_to_main_menu())
	hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if get_tree().current_scene is not GameLevel:
			return
		if not visible:
			show()
			get_tree().paused = true
		else:
			hide()
			get_tree().paused = false
