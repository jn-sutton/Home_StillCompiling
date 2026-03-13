# script for level 1
# level 1 is walking through more woodsy areas

extends LevelBase

@onready var timer: Timer = $Timer
@onready var bush = $bush
var is_visible: bool = true

func _ready():
	super._ready()

func _on_player_dug():
	if is_player_near(bush):
		player.set_collision_mask_value(11, false)
		bush.visible = false
		timer.start()
	else:
		player.set_collision_mask_value(11, true)
	
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
		
func transition_to_next_level():
	get_tree().change_scene_to_file("res://scenes/levels/level_02.tscn")
