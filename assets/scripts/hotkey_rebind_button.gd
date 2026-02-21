class_name HotkeyRebindButton
extends Control

@onready var label: Label = $HBoxContainer/Label

@onready var button: Button = $HBoxContainer/Button

@export var action_name : String = "move_left"


func _ready():
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_key()

func set_action_name() -> void:
	label.text = "Unassigned"

	match action_name:
		#exact names from input name changed to look more user friendly
		"move_left":
			label.text = "Move Left"
		"move_right":
			label.text = "Move Right"
		"jump":
			label.text = "Jump"

func set_text_for_key() -> void:
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	
	
