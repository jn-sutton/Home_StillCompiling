# script for level 2

extends LevelBase
@onready var spike_1: RigidBody2D = $Spikes/Spike1
@onready var spike_2: RigidBody2D = $Spikes/Spike2
@onready var spike_3: RigidBody2D = $Spikes/Spike3
@onready var spike_4: RigidBody2D = $Spikes/Spike4
@onready var spike_5: RigidBody2D = $Spikes/Spike5
@onready var spike_6: RigidBody2D = $Spikes/Spike6
@onready var spike_7: RigidBody2D = $Spikes/Spike7
@onready var spike_8: RigidBody2D = $Spikes/Spike8

@onready var label: Label = $Label
@onready var boulder: RigidBody2D = $boulder
@onready var rock_wall: Area2D = $rock_wall
@onready var rock_wall_barrier: StaticBody2D = $rock_wall_barrier
var check = false

func _ready():
	super._ready()
	
func _on_player_interacted():
	if boulder.freeze == false:
		boulder.linear_velocity = Vector2(100, -50)

func _on_player_dug():
	if check == true:
		player.die()

func _on_rock_wall_body_entered(body: Node2D) -> void:
	if body.name == "German_Shephard":
		label.visible = true
		check = true
	else:
		rock_wall.visible = false
		player.set_collision_mask_value(12, false)
		boulder.visible = false
		player.set_collision_mask_value(3, false)

func _on_rock_wall_body_exited(body: Node2D) -> void:
	if body.name == "German_Shephard":
		check = false
		
func _on_spike_zone_1_body_entered(body: Node2D) -> void:
	if body.name == "German_Shephard":
		spike_1.set_deferred("freeze", false)
		
func _on_spike_zone_2_body_entered(body: Node2D) -> void:
	if body.name == "German_Shephard":
		spike_2.set_deferred("freeze", false)

func _on_spike_zone_3_body_entered(body: Node2D) -> void:
	if body.name == "German_Shephard":
		spike_3.set_deferred("freeze", false)

func _on_spike_zone_4_body_entered(body: Node2D) -> void:
	if body.name == "German_Shephard":
		spike_4.set_deferred("freeze", false)

func _on_spike_zone_5_body_entered(body: Node2D) -> void:
	if body.name == "German_Shephard":
		spike_5.set_deferred("freeze", false)

func _on_spike_zone_6_body_entered(body: Node2D) -> void:
	if body.name == "German_Shephard":
		spike_6.set_deferred("freeze", false)

func _on_spike_zone_7_body_entered(body: Node2D) -> void:
	if body.name == "German_Shephard":
		spike_7.set_deferred("freeze", false)

func _on_spike_zone_8_body_entered(body: Node2D) -> void:
	if body.name == "German_Shephard":
		spike_8.set_deferred("freeze", false)


func _on_spike_1_body_entered(body: Node) -> void:
	if body.name == "German_Shephard":
		player.die()

func _on_spike_2_body_entered(body: Node) -> void:
	if body.name == "German_Shephard":
		player.die()

func _on_spike_3_body_entered(body: Node) -> void:
	if body.name == "German_Shephard":
		player.die()

func _on_spike_4_body_entered(body: Node) -> void:
	if body.name == "German_Shephard":
		player.die()

func _on_spike_5_body_entered(body: Node) -> void:
	if body.name == "German_Shephard":
		player.die()

func _on_spike_6_body_entered(body: Node) -> void:
	if body.name == "German_Shephard":
		player.die()

func _on_spike_7_body_entered(body: Node) -> void:
	if body.name == "German_Shephard":
		player.die()

func _on_spike_8_body_entered(body: Node) -> void:
	if body.name == "German_Shephard":
		player.die()


func _on_kill_zone_2_body_entered(body: Node2D) -> void:
	if body.name == "German_Shephard":
		player.die()
