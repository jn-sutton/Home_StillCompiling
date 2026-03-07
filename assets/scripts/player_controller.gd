extends CharacterBody2D
class_name PlayerController

#Exports so that we are able to change in the side bar to play with while
#the game is open
@export var speed = 300.0
@export var jump_power = 10.0

var speed_multiplier = 110.0
var jump_multiplier = -30.0
var direction = 0
var sniff_range = 40
var key_ = false
var level0 = false
var level1 = false

# This creates a "dirt_mound" variable that represents the dirt mound terrain item
@onready var dirt_mound: Sprite2D = $"../../StaticBody2D3/DigMoundSmells2"
# Need to add new "key_item" variable here
# Need to add new "house_door" variable here
# This creates a "bush1" variable that represents the bush terrain item
@onready var bush1: Sprite2D = $"../../StaticBody2D3/bush1"
# Creates timer variable
@onready var hold_timer = $Timer

# Variable stores the current level
func _ready():
	var current_level_path = get_tree().current_scene.scene_file_path
	if (current_level_path == "res://assets/scenes/levels/level_0.tscn"):
		level0 = true
		level1 = false
	elif (current_level_path == "res://assets/scenes/levels/level_1.tscn"):
		level1 = true
		level0 = false

func _input(event):
	# Checks to see if player is on level 0
	if (level0 == true):
		# Handle jump.
		if event.is_action_pressed("jump") and is_on_floor():
			velocity.y = jump_power * jump_multiplier
			
		# This if statement checks to see if the player has sniffed next to the dirt mound and
		# reveals the mound to the player if so.
		"""
		if event.is_action_pressed("sniff"):
q			var distance = global_position.distance_to(dirt_mound.global_position)
			if distance <= sniff_range:
				dirt_mound.visible = true
		"""
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
	# Checks to see if player is on level 1
	elif (level1 == true):
		var hold_time: float = 0.0
		var required_hold: float = 2.0
		
		# Handle jump.
		if event.is_action_pressed("jump") and is_on_floor():
			velocity.y = jump_power * jump_multiplier
			
		# Handle dropping through platforms
		if event.is_action_pressed("dig"):
			set_collision_mask_value(10, false)
		else:
			set_collision_mask_value(10, true)
			
		if event.is_action_pressed("sniff"):
			var distance = global_position.distance_to(bush1.global_position)
			if distance <= sniff_range:
				bush1.visible = true
		
		if (bush1.visible == true):
			var distance = global_position.distance_to(bush1.global_position)
			if distance <= sniff_range:
				if event.is_action_pressed("dig"):
					set_collision_mask_value(11, false)
				
				# Was trying to get a timer for testing amount of time holding down dig
				"""
				if event.is_action_pressed("dig"):
					hold_timer.start()
				if event.is_action_released("dig"):
					hold_timer.stop()
				"""


# Function is called when timer hits 2 seconds
func _on_timer_timeout():
	if (level1 == true):
		set_collision_mask_value(11, false)
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed_multiplier)
		
	move_and_slide()
	
func take_damage(amount):
	die()

func die():
	print("Dog died")
	get_tree().reload_current_scene()
