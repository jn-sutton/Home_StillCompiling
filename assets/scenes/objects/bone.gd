extends Area2D

signal picked_up

@onready var anim = $AnimationPlayer
@onready var collision = $CollisionShape2D

func _ready():
	body_entered.connect(_on_body_entered)
	
	#disables collision during bounce
	collision.set_deferred("disabled", true)
	
	anim.play("bounce")
	anim.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished(anim_name):
	if anim_name == "fly":
		collision.disabled = false
		anim.play("bounce")
	
func _on_body_entered(body):
	if body is PlayerController:
		picked_up.emit()
		queue_free()
