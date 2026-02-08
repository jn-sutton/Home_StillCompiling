extends CharacterBody2D
class_name PlayerController

#Exports so that we are able to change in the side bar to play with while
#the game is open
@export var speed = 200.0
@export var jump_power = 10.0

var speed_multiplier = 60.0
var jump_multiplier = -30.0
var direction = 0

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power * jump_multiplier

	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed_multiplier)

	move_and_slide()
