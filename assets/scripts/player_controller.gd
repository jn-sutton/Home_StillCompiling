extends CharacterBody2D
class_name PlayerController

#Exports so that we are able to change in the side bar to play with while
#the game is open
@export var speed = 200.0
@export var jump_power = 10.0

var speed_multiplier = 60.0
var jump_multiplier = -30.0
var direction = 0
var sniff_range = 40
var key_ = false

# This creates a "dirt_mound" variable that represents the dirt mound terrain item
@onready var dirt_mound: Sprite2D = $"../../StaticBody2D3/DigMoundSmells2"
# Need to add new "key_item" variable here
# Need to add new "house_door" variable here

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
		
	# This if statement checks to see if the player has sniffed next to the dirt mound and
	# reveals the mound to the player if so. Can re-use this code later on for similar interactions.
	if Input.is_action_just_pressed("sniff"):
		var distance = global_position.distance_to(dirt_mound.global_position)
		if distance <= sniff_range:
			dirt_mound.visible = true
			
	"""
	if dirt_mound.visible == true:
		var distance = global_position.distance_to(dirt_mound.global_position)
		if distance <= sniff_range:
			if Input.is_action_just_pressed("dig"):
				key_item.visible = true
				# add animation to floating key item
				dirt_mound.visible = false
				
	if key_item.visible ==  true:
		var distance = global_position.distance_to(key_item.global_position)
		if distance <= sniff_range:
			if Input.is_action_just_pressed("pick_up"):
				key_ = true
				key_item.visible = false
				
	if key_ == true:
		var distance = global_position.distance_to(house_door.global_position)
		if distance <= sniff_range:
			if Input.is_action_just_pressed("use_item"):
				# Plays cutscene/Ends level
	"""
	move_and_slide()
