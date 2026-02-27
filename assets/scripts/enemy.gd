extends CharacterBody2D

@export var speed: float = 60
@export var patrol_distance: float = 200
@export var damage: int = 1

var direction: int = -1
var start_position: Vector2

func _ready() -> void:
	start_position = global_position
	$AnimatedSprite2D.play("walk")  

func _physics_process(delta: float) -> void:
	velocity.x = direction * speed
	move_and_slide()

	# Turn around if hitting wall
	if is_on_wall():
		direction *= -1
		$AnimatedSprite2D.flip_h = direction < 0

	# Turn around if reaching patrol distance
	if abs(global_position.x - start_position.x) > patrol_distance:
		direction *= -1
		$AnimatedSprite2D.flip_h = direction < 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
