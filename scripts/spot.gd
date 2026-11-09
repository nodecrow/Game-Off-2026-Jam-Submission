extends Node2D
class_name Spot

func _enter_tree() -> void:
	Level.spots.append(self)

func _exit_tree() -> void:
	Level.spots.erase(self)
