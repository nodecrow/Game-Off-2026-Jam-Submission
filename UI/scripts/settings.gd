extends CanvasLayer

var master_bus = AudioServer.get_bus_index("Master")
var sfx_bus = AudioServer.get_bus_index("SFX")
var music_bus = AudioServer.get_bus_index("Music")
var ui_bus = AudioServer.get_bus_index("UI")

@onready var back_button: JuicyButton = %BackButton

@onready var master_slider: HSlider = %MasterSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SFXSlider
@onready var ui_slider: HSlider = %UISlider

@onready var fullscreen_toggle: CheckBox = %FullscreenToggle

signal closed

func _ready() -> void:

	
	back_button.pressed.connect(func() -> void:
		closed.emit()
		self.hide())
	
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		fullscreen_toggle.button_pressed = true
	fullscreen_toggle.toggled.connect(func(toggle: bool) -> void:
		if toggle:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	)

	
	master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(master_bus))
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus))
	ui_slider.value = db_to_linear(AudioServer.get_bus_volume_db(ui_bus))
	
	master_slider.value_changed.connect(change_volume.bind(master_bus))
	music_slider.value_changed.connect(change_volume.bind(music_bus))
	sfx_slider.value_changed.connect(change_volume.bind(sfx_bus))
	ui_slider.value_changed.connect(change_volume.bind(ui_bus))


func change_volume(value: float, bus: int) -> void:
	AudioServer.set_bus_volume_db(bus, linear_to_db(value))
	match bus:
		0:
			master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(master_bus))
		1:
			music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus))
			
		2:
			sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus))
			
		3:
			ui_slider.value = db_to_linear(AudioServer.get_bus_volume_db(ui_bus))
	
