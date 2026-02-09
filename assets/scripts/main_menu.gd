class_name MainMenu
extends Control

@onready var start_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Start_Button

@onready var exit_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button

@onready var start_level = preload("res://assets/scenes/main/main_menu.tscn") as PackedScene

#when either button is pushed down it routes to its own function
func _ready():
	start_button.button_down.connect(on_start_pressed)
	exit_button.button_down.connect(on_exit_pressed)

#needs a const since it won't take the location in the change scene
const Level_0 = preload("res://assets/scenes/levels/level_0.tscn")

#right now goes straight to tutorial level, but will change to intro scene
#when it is created
func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(Level_0)

func on_exit_pressed() -> void:
	get_tree().quit()
