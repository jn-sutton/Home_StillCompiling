extends CharacterBody2D
class_name PlayerController

@export var speed = 300.0
@export var jump_power = 10.0
var speed_multiplier = 110.0
var jump_multiplier = -30.0
var direction = 0

# Signals for levels to listen to
signal sniffed
signal dug
signal barked
signal interacted

func _input(event):
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_power * jump_multiplier
	
	if event.is_action_pressed("sniff"):
		sniffed.emit()
	
	if event.is_action_pressed("dig"):
		dug.emit()
		
	if event.is_action_pressed("interact"):
		interacted.emit()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed_multiplier)
	
	move_and_slide()
