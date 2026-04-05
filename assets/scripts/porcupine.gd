extends CharacterBody2D

@export var speed: float
@export var direction = 1 #1 right, -1 left


@onready var sprite: Sprite2D = $EnemyAnimator/Sprite2D
@onready var animation_player: AnimationPlayer = $EnemyAnimator/AnimationPlayer
@onready var wall_detector_right: RayCast2D = $WallDetectorRight
@onready var wall_detector_left: RayCast2D = $WallDetectorLeft

func _ready():
	animation_player.play("walk")


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	
	velocity.x = direction * speed
	
	#uses ray cast to check walls then flips if hit
	if wall_detector_right.is_colliding() and direction == 1:
		flip_direction()
	elif wall_detector_left.is_colliding() and direction == -1:
		flip_direction()
	
	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var body = collision.get_collider()

		if body.has_method("die"):
			body.die()
	
func flip_direction():
	direction *= -1
	sprite.flip_h = (direction == -1)
	

func _on_player_detector_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		body.take_damage(1)
