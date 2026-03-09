extends Node

var current_level = 0
var level_path = "res://assets/scenes/levels/"

func next_level():
	current_level += 1
	var full_path = level_path + "level_" + str(current_level) + ".tscn"
	get_tree().change_scene_to_file(full_path)
	print("The player has moved to level " + str(current_level))
