# base for all levels that they inherit from

extends Node2D
class_name LevelBase

@onready var level_exit = $level_exit
@onready var player: PlayerController = $German_Shephard
var sniff_range = 40


func _ready():
	
		#connects player signals
	if player:
		player.sniffed.connect(_on_player_sniffed)
		player.dug.connect(_on_player_dug)
		player.interacted.connect(_on_player_interacted)
	
	#setup for any level
	setup_level()

func setup_level():
	#override in child levels
	pass


# Helper function for dialogues
func show_dialogue(dialogue_file: DialogueResource, dialogue_start: String = "start"):
	DialogueManager.show_example_dialogue_balloon(dialogue_file, dialogue_start)

# Helper function for distance checks
func is_player_near(target: Node2D, range: float = 40) -> bool:
	if not player or not target:
		return false
	return player.global_position.distance_to(target.global_position) <= range

# Override these in child levels for specific interactions
func _on_player_sniffed():
	pass

func _on_player_dug():
	pass

func _on_player_interacted():
	pass
