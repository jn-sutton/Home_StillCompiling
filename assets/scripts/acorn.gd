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
	if anim_name == "bounce":
		collision.disabled = false
		anim.play("spin")
	
func _on_body_entered(body):
	if body is PlayerController:
		picked_up.emit()
		queue_free()
		
#for dialogue with squirrel
func action():
	DialogueManager.set_variable("has_acorn", get_parent().has_acorn)
	DialogueManager.show_dialogue_balloon(get_parent().tutorial_dialogue, "tutorial_dialogue")
