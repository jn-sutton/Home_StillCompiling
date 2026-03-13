extends Area2D

@export var hidden_object_scene: PackedScene  # Leave empty = no drop

@onready var sprite = $Sprite2D
@export var anim: AnimationPlayer
@onready var collision = $CollisionShape2D

var already_flew = false

signal object_revealed(object)

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is PlayerController and not already_flew:
		fly_away(false)  # Ran into = no item

func bark_at():
	if already_flew:
		return
	fly_away(true)  # Barked at = drop item if exists

func fly_away(should_drop_item: bool):
	already_flew = true
	anim.play("flying")
	collision.set_deferred("disabled", true)
	
	# Only drop if barked at AND item assigned
	if should_drop_item and hidden_object_scene:
		spawn_object()
	
	await anim.animation_finished
	queue_free()

func spawn_object():
	var obj = hidden_object_scene.instantiate()
	get_parent().add_child(obj)
	obj.global_position = global_position
	object_revealed.emit(obj)
