class_name MainMenu
extends Control

@onready var start_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Start_Button

@onready var options_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Options_Button

@onready var exit_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button

@onready var options_menu: Control = $Options_Menu

@onready var margin_container: MarginContainer = $MarginContainer

@onready var start_level = preload("res://assets/scenes/main/main_menu.tscn") as PackedScene

#when either button is pushed down it routes to its own function
func _ready():
	handle_connecting_signals()
	
	#hide options menu on start
	on_exit_options_menu()

#needs a const since it won't take the location in the change scene
const level_tutorial = preload("res://assets/scenes/levels/level_tutorial.tscn")

#right now goes straight to tutorial level, but will change to intro scene
#when it is created
func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(level_tutorial)

func on_options_pressed() -> void:
	margin_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true

func on_exit_pressed() -> void:
	get_tree().quit()

func on_exit_options_menu() -> void:
	margin_container.visible = true
	options_menu.visible = false
	
	#shutdown processing when hidden
	options_menu.set_process(false)

func handle_connecting_signals() -> void:
	start_button.button_down.connect(on_start_pressed)
	options_button.button_down.connect(on_options_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	options_menu.exit_options_menu.connect(on_exit_options_menu)
