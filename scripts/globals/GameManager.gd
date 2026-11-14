extends Node

const LEVEL_SELECT = preload("uid://22ks2rd8fj0n")
const MENU = preload("uid://bbkwfd1iodqa5")
const CREDITS = preload("uid://dykbi6mfsof5c")
const SETTINGS = preload("uid://dh5vomjhe5gh3")

const LEVEL_1 = preload("uid://cqd2hwt0rwxkk")
const LEVEL_2 = preload("uid://ct57n2c3787mm")
const LEVEL_3 = preload("uid://crijlpstipcb6")
const LEVEL_4 = preload("uid://d3xb4j5ryonub")
const LEVEL_5 = preload("uid://b2mplkfwyr3yn")
const LEVEL_6 = preload("uid://b5ka88ghuvrv8")
const LEVEL_7 = preload("uid://dt11qi8ka2rp3")
const LEVEL_8 = preload("uid://dv7m77jh5yeaj")
const LEVEL_9 = preload("uid://bipu8l8q21axh")
const LEVEL_10 = preload("uid://eqa46i5b2p1j")
const LEVEL_11 = preload("uid://b08y0rop3j7n")
const LEVEL_12 = preload("uid://xm04shlwl30j")
const LEVEL_13 = preload("uid://eolhx7lvi2sl")
const LEVEL_14 = preload("uid://jyqjoldj1461")
const LEVEL_15 = preload("uid://w0jvwx7n55ju")
const LEVEL_16 = preload("uid://5h63p27xqn53")
const LEVEL_17 = preload("uid://mbyum11j6q8w")
const LEVEL_18 = preload("uid://xlah0l21hhp2")
const LEVEL_19 = preload("uid://8545qopdpgtl")
const LEVEL_20 = preload("uid://b27fk4i21le0l")



var levels: Array[PackedScene] = [
	LEVEL_1,
	LEVEL_2,
	LEVEL_3,
	LEVEL_4,
	LEVEL_5,
	LEVEL_6,
	LEVEL_7,
	LEVEL_8,
	LEVEL_9,
	LEVEL_10,
	LEVEL_11,
	LEVEL_12,
	LEVEL_13,
	LEVEL_14,
	LEVEL_15,
	LEVEL_16,
	LEVEL_17,
	LEVEL_18,
	LEVEL_19,
	LEVEL_20,
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
