extends Area2D

@export var dialogue_resource: DialogueResource
var player_nearby = false
var dialogue_active = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body is PlayerController:
		player_nearby = true

func _on_body_exited(body):
	if body is PlayerController:
		player_nearby = false

func _input(event):
	if event.is_action_pressed("interact"):
		
		if player_nearby and not dialogue_active:
			dialogue_active = true
			DialogueManager.show_example_dialogue_balloon(dialogue_resource, "tutorial_dialogue")
			
			# Wait for the dialogue manager signal instead
			await DialogueManager.dialogue_ended
			
			dialogue_active = false
