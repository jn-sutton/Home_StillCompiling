# tutorial level / level_0
# level shows how to utilize movements and sets up story of leaving campground
# in search of home

extends LevelBase

@onready var dirt_mound = $dirt_mound
@onready var gate = $Environment/gate
@onready var squirrel: StaticBody2D = $Environment/squirrel
@export var tutorial_dialogue: DialogueResource


var acorn = null
var has_acorn = false

func _ready():
	super._ready()
	await get_tree().process_frame
	#connects dirt mounds signal
	if dirt_mound:
		dirt_mound.object_revealed.connect(_on_object_revealed)
	
func _on_object_revealed(object):
	acorn = object
	acorn.picked_up.connect(_on_acorn_picked_up)
	
func _on_acorn_picked_up():
	has_acorn = true
	
	#later add hud to display this in inventory

func _on_player_sniffed():
	print("Player sniffed!")
	print("Dirt mound exists: ", dirt_mound != null)
	print("Is player near: ", is_player_near(dirt_mound))
	
	if is_player_near(dirt_mound, 150):
		print("Revealing mound!")
		dirt_mound.reveal_mound()

func _on_player_dug():
	if is_player_near(dirt_mound):
		dirt_mound.dig_up()
		

func _on_player_interacted():
	#pick up acorn
	if acorn and is_player_near(acorn):
		has_acorn = true
		acorn.queue_free()
		show_dialogue(tutorial_dialogue, "picked_up_acorn")
		
	#talk to squirrel
	elif is_player_near(squirrel, 80):
		if has_acorn:
			show_dialogue(tutorial_dialogue, "tutorial_dialogue")
			#check players choice
			DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
		else:
			show_dialogue(tutorial_dialogue, "no_acorn")
			
func _on_dialogue_ended(resource):
	#check option chosen
	if DialogueManager.get_variable("gave_acorn") == true:
		open_gate()
		
	DialogueManager.dialogue_ended.disconnect(_on_dialogue_ended)
	
func open_gate():
	gate.queue_free()
		
	#gives acorn to squirrel to make gate disappear
	

func transition_to_next_level():
	get_tree().change_scene_to_file("res://scenes/levels/level_01.tscn")
