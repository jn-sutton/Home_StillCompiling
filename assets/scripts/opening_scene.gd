extends Node2D

@export var dialogue_resource: DialogueResource
var dialogue_active = false

func _ready():
	dialogue_active = true
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, "opening_scene")
	await DialogueManager.dialogue_ended
	dialogue_active = false
	
	transition_to_next_level()

func transition_to_next_level():
	get_tree().change_scene_to_file("res://assets/scenes/levels/level_0.tscn")
