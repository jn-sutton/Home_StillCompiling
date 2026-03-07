extends Node2D
class_name LevelBase

@onready var level_exit = $level_exit
@onready var player = $German_Shephard
var sniff_range = 40

func _ready():
	# Connect level exit signal
	if level_exit:
		level_exit.body_entered.connect(_on_level_exit)
	
		# Connect player signals (with safety check)
	if player:
		player.sniffed.connect(_on_player_sniffed)
		player.dug.connect(_on_player_dug)
		player.interacted.connect(_on_player_interacted)
	
	# Any setup all levels need
	setup_level()

func setup_level():
	# Override in child levels if needed
	pass

func _on_level_exit(body):
	if body == player:
		transition_to_next_level()

func transition_to_next_level():
	# Override in each level to specify next scene
	pass

# Helper function for dialogues
func show_dialogue(dialogue_file: DialogueResource, dialogue_start: String = "start"):
	DialogueManager.show_example_dialogue_balloon(dialogue_file, dialogue_start)

# Helper function for distance checks
func is_player_near(target: Node2D, range: float = 40) -> bool:
	return player.global_position.distance_to(target.global_position) <= range

# Override these in child levels for specific interactions
func _on_player_sniffed():
	pass

func _on_player_dug():
	pass

func _on_player_interacted():
	pass
