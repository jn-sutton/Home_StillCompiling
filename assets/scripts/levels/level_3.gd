#script for level 3

extends LevelBase

@export var dialogue_resource: DialogueResource
@onready var pigeons = $pigeons
@onready var animation_player: AnimationPlayer = $FadeToBlack/AnimationPlayer

func _ready():
	super._ready()
	await get_tree().process_frame
	player.barked.connect(_on_player_barked)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_player_barked():
	if pigeons and is_player_near(pigeons, 200):
		pigeons.bark_at()

func _on_end_dialogue_body_entered(body: Node2D) -> void:
	if body.name == "German_Shephard":
		body.can_move = false
		body.get_node("PlayerAnimator").idle()
		DialogueManager.show_dialogue_balloon(dialogue_resource, "ending_scene")

func _on_dialogue_ended(resource):
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://assets/scenes/main/credits.tscn")
