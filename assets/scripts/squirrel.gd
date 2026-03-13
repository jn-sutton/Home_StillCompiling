extends Area2D

@export var dialogue_resource: DialogueResource
var player_nearby = false
var dialogue_active = false

func _ready():
	print("Squirrel ready!")
	print("Dialogue resource: ", dialogue_resource)
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	print("Body entered: ", body.name)
	if body is PlayerController:
		player_nearby = true
		print("Player is nearby!")

func _on_body_exited(body):
	if body is PlayerController:
		player_nearby = false
		print("Player left")

func _input(event):
	if event.is_action_pressed("interact"):
		print("Interact pressed! Nearby: ", player_nearby, " Active: ", dialogue_active)
		
		if player_nearby and not dialogue_active:
			print("Starting dialogue...")
			dialogue_active = true
			DialogueManager.show_example_dialogue_balloon(dialogue_resource, "tutorial_dialogue")
			
			# Wait for the dialogue manager signal instead
			await DialogueManager.dialogue_ended
			
			dialogue_active = false
			print("Dialogue ended")
