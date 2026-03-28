#script for level 3

extends LevelBase

@export var tutorial_dialogue: DialogueResource
@onready var pigeons = $pigeons


func _ready():
	super._ready()
	await get_tree().process_frame
	#connects dirt mounds signal
	#if dirt_mound:
	#	dirt_mound.object_revealed.connect(_on_object_revealed)
	# Connect player bark to check distance
	player.barked.connect(_on_player_barked)
	#DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
func _on_player_barked():
	if pigeons and is_player_near(pigeons, 200):
		pigeons.bark_at()
	
#func _on_object_revealed(object):
#	acorn = object
#	acorn.picked_up.connect(_on_acorn_picked_up)
	
func _on_acorn_picked_up():
	State.has_acorn = true
	
	#later add hud to display this in inventory

#func _on_player_sniffed():
#	if is_player_near(dirt_mound, 150):
#		dirt_mound.reveal_mound()

#func _on_player_dug():
#	if is_player_near(dirt_mound):
#		dirt_mound.dig_up()
		


#func _on_dialogue_ended(resource):
#	# Only open if acorn was just given
#	if State.gave_acorn and not gate_opened:
#		gate_opened = true
#		open_gate()

	

#func transition_to_next_level():
#	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
