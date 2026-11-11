## My goat kidscancode.org (https://kidscancode.org/godot_recipes/4.x/ui/radial_menu/index.html)

extends Control
class_name ColorWheel

const UI_HOVER_BUBBLE_BLIP_V_04 = preload("uid://c76s52o084lgi")
const UI_HOVER_FABRIC_SLIDE_V_01 = preload("uid://bwh6wu2yuo01d")
const UI_HOVER_FABRIC_SLIDE_V_02 = preload("uid://k1n85sil1n4o")

@export var radius = 20
@export var speed = 0.25

@onready var buttons: Control = %Buttons
@onready var ui_fx: AudioStreamPlayer2D = %"UI FX"

var num
var active = false
var selected_hue: Palette.Hue = Palette.Hue.WHITE
var current_hue: Palette.Hue

func _ready() -> void:
	buttons.hide()
	num = buttons.get_child_count()
	for b in buttons.get_children():
		b.mouse_entered.connect(func() -> void:
			selected_hue = b.hue
			for slice in buttons.get_children():
				if slice == b:
					slice.set_highlight(true)
					ui_fx.stream = UI_HOVER_BUBBLE_BLIP_V_04
					ui_fx.play()
				else:
					slice.set_highlight(false)
					)
		b.position = position
		

func _process(_delta: float) -> void:
	global_position = Level.player.get_global_transform_with_canvas().origin

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("colorwheel"):
		ui_fx.stream = UI_HOVER_FABRIC_SLIDE_V_01 
		ui_fx.play()
		show_menu()
	elif event.is_action_released("colorwheel"):
		Level.shift_color(selected_hue)
		ui_fx.stream = UI_HOVER_FABRIC_SLIDE_V_02
		ui_fx.play()
		hide_menu()

func _on_tween_finished() -> void:
	if not active:
		buttons.hide()
		
func show_menu() -> void:
	for b: TextureRect in buttons.get_children():
		if b.hue == Level.level_hue:
			b.hide()
		else:
			b.show()
	buttons.show()
	var spacing = TAU / num
	active = true
	var tween := create_tween().set_parallel()
	tween.finished.connect(_on_tween_finished)
	for b in buttons.get_children():
		var a = spacing * b.get_index() - PI / 2
		var dest = Vector2(radius, 0).rotated(a)
		tween.tween_property(b, "position", dest, speed).from(Vector2.ZERO).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		tween.tween_property(b, "scale", Vector2.ONE, speed).from(Vector2(0.5, 0.5)).set_trans(Tween.TRANS_LINEAR)

func hide_menu() -> void:
	active = false
	var tween := create_tween().set_parallel()
	tween.finished.connect(_on_tween_finished)
	for b in buttons.get_children():
		tween.tween_property(b, "position", Vector2.ZERO, speed).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
		tween.tween_property(b, "scale", Vector2(0.5, 0.5), speed).set_trans(Tween.TRANS_LINEAR)
