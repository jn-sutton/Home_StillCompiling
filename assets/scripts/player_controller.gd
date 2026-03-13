extends CharacterBody2D
class_name PlayerController

@export var speed = 300.0
@export var jump_power = 10.0
var speed_multiplier = 110.0
var jump_multiplier = -30.0
var direction = 0
var can_interact = true

#for dialogue
@onready var actionable_finder: Area2D = $ActionableFinder

# Signals for levels to listen to
signal sniffed
signal dug
signal barked
signal interacted

func _input(event):
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_power * jump_multiplier
	
	if event.is_action_pressed("sniff") and is_on_floor():
		sniffed.emit()
	
	if event.is_action_pressed("dig") and is_on_floor():
		dug.emit()
		set_collision_mask_value(10, false)
	else:
		set_collision_mask_value(10, true)
		
	#talking to npc's
	if event.is_action_pressed("interact") and can_interact:
		#can_interact = false
		#var actionables = actionable_finder.get_overlapping_areas()
		#if actionables.size() > 0:
			#actionables[0].action() 
			#await get_tree().create_timer(0.5).timeout
			#can_interact = true
			#return
		interacted.emit()
		#can_interact = true

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
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
