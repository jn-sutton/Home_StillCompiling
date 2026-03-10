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
	
	# Check walls BEFORE moving
	if wall_detector_right.is_colliding() and direction == 1:
		flip_direction()
	elif wall_detector_left.is_colliding() and direction == -1:
		flip_direction()
	
	move_and_slide()
	
	
func flip_direction():
	direction *= -1
	sprite.flip_h = (direction == -1)
