extends Node2D

@export var player_controller : PlayerController
@export var animation_player : AnimationPlayer
@export var sprite : Sprite2D

func _process(_delta):
	# Handle Sprite Flipping
	if player_controller.direction != 0:
		sprite.flip_h = (player_controller.direction == -1)
	
	# Handle Animation Switching
	var target_anim = "idle" # Default
	
	# Check if player is jumping 
	if player_controller.velocity.y < 0:  # Moving upward = jumping
		target_anim = "jumping"
	elif player_controller.velocity.y > 0:  # Falling
		target_anim = "falling" 
	elif player_controller.direction != 0:  # Moving left or right
		target_anim = "move"
	elif Input.is_action_pressed("sniff"): # While idle, checks if user is pressing "Q" for sniff action
		target_anim = "sniff"
	elif Input.is_action_pressed("dig"): # While idle, checks if user is pressing "S" for dig action
		target_anim = "dig"
	
	# ONLY call play if the current animation is different
	if animation_player.current_animation != target_anim:
		animation_player.play(target_anim)
