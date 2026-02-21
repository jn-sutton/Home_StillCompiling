extends Path2D
class_name MovingPlatform

@export var path_follow_2D : PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready():
	move_tween()

# Function that infintely loops to move the platform
func move_tween():
	var tween = get_tree().create_tween().set_loops()
	tween.tween_property(path_follow_2D, "progress_ratio", 1.0, 2.0)
	tween.tween_property(path_follow_2D, "progress_ratio", 0.0, 2.0)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
