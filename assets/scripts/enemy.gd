extends CharacterBody2D

@export var speed = 60
@export var patrol_distance = 200
@export var damage = 1

var direction = -1
var start_position

func _ready():
	start_position = position

func _physics_process(delta):
	velocity.x = direction * speed
	move_and_slide()

	if abs(position.x - start_position.x) > patrol_distance:
		direction = direction * -1
		scale.x = scale.x * -1

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
