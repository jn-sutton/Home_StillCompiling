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

#for sfx
@onready var sniff_sfx: AudioStreamPlayer2D = $SFX/sniff_sfx
@onready var bark_sfx: AudioStreamPlayer2D = $SFX/bark_sfx
@onready var dig_sfx: AudioStreamPlayer2D = $SFX/dig_sfx
@onready var jump_sfx: AudioStreamPlayer2D = $SFX/jump_sfx



# Signals for levels to listen to
signal sniffed
signal dug
signal barked
signal interacted

func _input(event):
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_power * jump_multiplier
		jump_sfx.play()
	elif event.is_action_released("jump"):
		jump_sfx.stop()
	
	if event.is_action_pressed("sniff"):
		sniffed.emit()
		sniff_sfx.play()
	# When the button is let go
	elif event.is_action_released("sniff"):
		sniff_sfx.stop()
	
	if event.is_action_pressed("dig"):
		dug.emit()
		dig_sfx.play()
	elif event.is_action_released("dig"):
		dig_sfx.stop()
		
	
	if event.is_action_pressed("bark"):
		barked.emit()
		bark_sfx.play()
	elif event.is_action_released("bark"):
		bark_sfx.stop()
		
	#talking to npc's
	if event.is_action_pressed("interact") and can_interact:
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
	
func take_damage(amount):
	die()

func die():
	print("Dog died")
	get_tree().reload_current_scene()
