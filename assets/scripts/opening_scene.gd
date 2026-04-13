extends Node2D

@export var dialogue_resource: DialogueResource
var dialogue_active = false

@onready var animation_player: AnimationPlayer = $FadeToBlack/AnimationPlayer



func _ready():
	dialogue_active = true
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, "opening_scene")
	await DialogueManager.dialogue_ended
	dialogue_active = false

	await transition_to_next_level()

func transition_to_next_level():
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://assets/scenes/levels/level_0.tscn")
