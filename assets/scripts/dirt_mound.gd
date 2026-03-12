extends Area2D

@onready var dirt_mound: Sprite2D = $Mound
#can drag whatever needed into this spot for reuse with different hidden items
@export var hidden_object_scene: PackedScene
var hidden_object_instance = null

signal object_revealed(object)

func _ready():
	dirt_mound.visible = false

func reveal_mound():
	dirt_mound.visible = true
	
func dig_up():
	if dirt_mound.visible and hidden_object_scene:
		#spawns object
		hidden_object_instance = hidden_object_scene.instantiate()
		get_parent().add_child(hidden_object_instance)
		hidden_object_instance.global_position = global_position
		
		dirt_mound.visible = false
		object_revealed.emit(hidden_object_instance)
