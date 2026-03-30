# tutorial level / level_0
# level shows how to utilize movements and sets up story of leaving campground
# in search of home

extends LevelBase

@onready var dirt_mound = $dirt_mound
@onready var gate = $gate
@onready var squirrel = $Environment/squirrel
@export var tutorial_dialogue: DialogueResource
@onready var pigeons = $pigeons

#ensures only one use mound
var mound_used = false
var acorn = null
var has_acorn = false

func _ready():
	super._ready()
	await get_tree().process_frame
	#connects dirt mounds signal
	if dirt_mound:
		dirt_mound.object_revealed.connect(_on_object_revealed)
	# Connect player bark to check distance
	player.barked.connect(_on_player_barked)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
func _on_player_barked():
	if pigeons and is_player_near(pigeons, 200):
		pigeons.bark_at()
	
func _on_object_revealed(object):
	mound_used = true
	acorn = object
	acorn.picked_up.connect(_on_acorn_picked_up)
	
func _on_acorn_picked_up():
	State.has_acorn = true
	
	#later add hud to display this in inventory

func _on_player_sniffed():
	if not mound_used and is_player_near(dirt_mound, 150):
		dirt_mound.reveal_mound()

func _on_player_dug():
	if not mound_used and is_player_near(dirt_mound):
		dirt_mound.dig_up()
		

var gate_opened = false

func _on_dialogue_ended(resource):
	# Only open if acorn was just given
	if State.gave_acorn and not gate_opened:
		gate_opened = true
		open_gate()

func open_gate():
	if gate:
		gate.queue_free()
	#gives acorn to squirrel to make gate disappear
	

func transition_to_next_level():
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
