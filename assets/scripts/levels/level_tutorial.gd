# tutorial level / level_0
# level shows how to utilize movenemnts and sets up story of leaving campground
# in search of home

extends LevelBase

@onready var dirt_mound = $Environment/DirtMound
@onready var key_item = $Environment/KeyItem
@onready var gate = $Environment/gate

var has_key = false

func _on_player_sniffed():
	if is_player_near(dirt_mound):
		dirt_mound.visible = true

func _on_player_dug():
	if dirt_mound.visible and is_player_near(dirt_mound):
		key_item.visible = true
		dirt_mound.visible = false

func _on_player_interacted():
	# Pick up key
	if key_item.visible and is_player_near(key_item):
		has_key = true
		key_item.visible = false
	
	# Use key on door
	if has_key and is_player_near(gate):
		transition_to_next_level()

func transition_to_next_level():
	get_tree().change_scene_to_file("res://scenes/levels/level_01.tscn")
