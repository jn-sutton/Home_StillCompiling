# script for level 1
# level 1 is walking through more woodsy areas

extends LevelBase

@onready var dirt_mound = $dirt_mound
@onready var timer: Timer = $Timer
@onready var bush = $bush
var is_visible: bool = true
var bone = null
var has_bone = false
var mound_used = false

func _ready():
	super._ready()
	if dirt_mound:
		dirt_mound.object_revealed.connect(_on_object_revealed)

func _on_player_dug():
	if is_player_near(bush):
		player.set_collision_mask_value(11, false)
		bush.visible = false
		timer.start()
	else: 
		if not mound_used and is_player_near(dirt_mound):
			dirt_mound.dig_up()
	
func _on_timer_timeout():
	is_visible = !is_visible
	if is_visible:
		get_tree().call_group("invis_platforms", "show")
		get_tree().call_group("invis_platforms", "set_deferred", "collision_layer", 10)
	else:
		get_tree().call_group("invis_platforms", "hide")
		get_tree().call_group("invis_platforms", "set_deferred", "collision_layer", 0)

func _on_kill_zone_body_entered(body: Node2D) -> void:
	if body.name == "German_Shephard":
		player.die()

#dirt mound functions
func _on_player_sniffed():
	if not mound_used and is_player_near(dirt_mound, 150):
		dirt_mound.reveal_mound()
		
		
func _on_object_revealed(object):
	mound_used = true
	bone = object
	bone.picked_up.connect(_on_bone_picked_up)

func _on_bone_picked_up():
	State.has_acorn = true
	
	#later add hud to display this in inventory
		
func transition_to_next_level():
	get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")
