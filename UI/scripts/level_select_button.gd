extends Button

var level: int = 0
var is_unlocked: bool = false

func _ready() -> void:
	level = get_index()
	text = str(level + 1)
	disabled = GameManager.is_level_unlocked(level)

func _pressed() -> void:
		GameManager.start_level(level)
