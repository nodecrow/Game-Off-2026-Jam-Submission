extends CanvasLayer

var player_moves: int
var optimal_moves: int

@onready var background: ColorRect = %Background
@onready var next_level_button: Button = %NextLevelButton
@onready var level_select_button: Button = %LevelSelectButton
@onready var control: Control = %Control
@onready var level_complete: RichTextLabel = %LevelComplete

@onready var player_move_label: RichTextLabel = %PlayerMoves
@onready var optimal_moves_label: RichTextLabel = %OptimalMoves
@onready var grade_label: RichTextLabel = %Grade

@onready var letter_grade: RichTextLabel = %LetterGrade

func _ready() -> void:

	var grade: float = (float(optimal_moves) / player_moves) * 100
	var current_level = get_tree().current_scene as GameLevel
	level_complete.text = current_level.name + " complete!"
	
	var letter = get_letter(grade)
	
	# Set text
	player_move_label.text = "You used " + str(player_moves) + " moves"
	optimal_moves_label.text = "Optimal moves: " + str(optimal_moves)
	grade_label.text = str(optimal_moves) + " ÷ " + str(player_moves) + " × 100 " + " = " + str(roundi(grade)) +"%"
	letter_grade.text = letter
	
	var tween := create_tween()
	add_stamp(tween, player_move_label, 1.6)
	add_stamp(tween, optimal_moves_label, 1.6)
	add_stamp(tween, grade_label, 1.6)
	
	tween.tween_interval(1.0)
	tween.tween_callback(AudioPlayer.play_sparkle)
	add_stamp(tween, letter_grade, 3.0, 0.5)
	
	next_level_button.pressed.connect(_on_next_level_button_pressed)
	level_select_button.pressed.connect(_on_level_select_pressed)
	fade_in()

func add_stamp(tween: Tween, label: Control, start_scale: float, start_rotation: float = 0.0) -> void:
	label.offset_transform_rotation = start_rotation
	label.modulate.a = 0
	label.offset_transform_scale = Vector2(start_scale, start_scale)
	
	tween.tween_callback(AudioPlayer.play_stamp)
	tween.tween_property(label, "modulate:a", 1.0, 0.08)
	tween.parallel()
	tween.tween_property(label, "offset_transform_scale", Vector2.ONE, 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.parallel()
	if start_rotation != 0:
		tween.tween_property(label, "offset_transform_rotation", -0.2, 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_interval(0.8)

func fade_in() -> void:
	var tween := create_tween()
	
	tween.tween_property(control, "modulate:a", 1.0, 2.0)
	tween.tween_property(background, "modulate:a", 0.5, 2.0)

func _on_next_level_button_pressed() -> void:
	GameManager.start_level(GameManager.current_level + 1)
	self.queue_free()

func _on_level_select_pressed() -> void:
	GameManager.go_to_level_select()
	self.queue_free()
	
func get_letter(grade: float) -> String:
	if grade >= 100: return "S"
	elif grade >= 85: return "A"
	elif grade >= 70: return "B"
	elif grade >= 50: return "C"
	else: return "D"
