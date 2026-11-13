extends Node

const LEVEL_SELECT = preload("uid://22ks2rd8fj0n")
const MENU = preload("uid://bbkwfd1iodqa5")
const CREDITS = preload("uid://dykbi6mfsof5c")
const SETTINGS = preload("uid://dh5vomjhe5gh3")

const LEVEL_1 = preload("uid://cqd2hwt0rwxkk")
const LEVEL_2 = preload("uid://ct57n2c3787mm")
const LEVEL_3 = preload("uid://cko3uoq0ug5yn")


var levels: Array[PackedScene] = [
	LEVEL_1,
	LEVEL_2,
	LEVEL_3
]

var current_level: int = 0
var highest_level_unlocked: int = 0

func start_level(index: int) -> void:
	current_level = index
	get_tree().change_scene_to_packed(levels[index])

func is_level_unlocked(index: int) -> bool:
	return highest_level_unlocked < index

func complete_level() -> void:
	if current_level == highest_level_unlocked:
		highest_level_unlocked += 1

func go_to_level_select() -> void:
	print("LEVEL SELECT")
	get_tree().change_scene_to_packed(LEVEL_SELECT)

func go_to_main_menu() -> void:
	print("MAIN MENU")
	get_tree().change_scene_to_packed(MENU)

func go_to_settings() -> void:
	print("SETTINGS")
	get_tree().change_scene_to_packed(SETTINGS)

func go_to_credits() -> void:
	print("CREDITS")
	get_tree().change_scene_to_packed(CREDITS)
