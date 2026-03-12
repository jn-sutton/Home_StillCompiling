# tutorial level / level_0
# level shows how to utilize movements and sets up story of leaving campground
# in search of home

extends LevelBase

@onready var dirt_mound = $dirt_mound
@onready var gate = $gate
@onready var squirrel = $Environment/squirrel
@export var tutorial_dialogue: DialogueResource


var acorn = null
var has_acorn = false

func _ready():
	super._ready()
	await get_tree().process_frame
	#connects dirt mounds signal
	if dirt_mound:
		dirt_mound.object_revealed.connect(_on_object_revealed)
	#listen for dialogue
	DialogueManager.passed_title.connect(_on_dialogue_signal)
	
func _on_object_revealed(object):
	acorn = object
	acorn.picked_up.connect(_on_acorn_picked_up)
	
func _on_acorn_picked_up():
	has_acorn = true
	
	#later add hud to display this in inventory

func _on_player_sniffed():
	if is_player_near(dirt_mound, 150):
		dirt_mound.reveal_mound()

func _on_player_dug():
	if is_player_near(dirt_mound):
		dirt_mound.dig_up()
		

func _on_dialogue_signal(arg):
	if arg == "open gate":
		open_gate()

func open_gate():
	gate.queue_free()
		
	#gives acorn to squirrel to make gate disappear
	

func transition_to_next_level():
	get_tree().change_scene_to_file("res://scenes/levels/level_01.tscn")
