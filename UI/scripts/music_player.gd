extends Node

const TABLETOP_JAZZ_CAFE = preload("uid://diqs6dwm47l3a")

const ESCAPE_BLOCK_1 = preload("uid://cca3uq4x7ua81")
const ESCAPE_BLOCK_2 = preload("uid://chxxoklqe25wb")
const ESCAPE_BLOCK_3 = preload("uid://c58r0xcdldf64")
const ESCAPE_BLOCK_4 = preload("uid://b1guyaf8g3hjs")
const ESCAPE_BLOCK_5 = preload("uid://d18aul8p0b1lj")
const ESCAPE_BLOCK_6 = preload("uid://x0f3e54q4h7d")
const ESCAPE_BLOCK_7 = preload("uid://dkmyr4r702806")


var music_choices: Array[Resource] = [
	ESCAPE_BLOCK_1,
	ESCAPE_BLOCK_2,
	ESCAPE_BLOCK_3,
	ESCAPE_BLOCK_4,
	ESCAPE_BLOCK_5,
	ESCAPE_BLOCK_6,
	ESCAPE_BLOCK_7,
]

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func play_menu_music() -> void:
	audio_stream_player.stream = TABLETOP_JAZZ_CAFE
	audio_stream_player.play()

func play_random_track() -> void:
	var random_index: int = randi_range(0, music_choices.size() - 1)
	audio_stream_player.stream = music_choices[random_index]
	audio_stream_player.play()
	
