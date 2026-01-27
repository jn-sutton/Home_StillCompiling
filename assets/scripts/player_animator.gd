extends Node2D

@export var player_controller : PlayerController
@export var animation_player : AnimationPlayer
@export var sprite : Sprite2D

func _process(_delta):
	# 1. Handle Sprite Flipping (as discussed before)
	if player_controller.direction != 0:
		sprite.flip_h = (player_controller.direction == -1)

	# 2. Handle Animation Switching
	var target_anim = "idle" # Default
	if player_controller.direction != 0:
		target_anim = "move"

	# ONLY call play if the current animation is different
	# This prevents the animation from restarting every frame
	if animation_player.current_animation != target_anim:
		animation_player.play(target_anim)
