extends CharacterBody2D

const SPEED = 60.0
const PATROL_LEFT = 576.0
const PATROL_RIGHT = 921.0

var direction: float = -1.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = direction * SPEED

	if position.x <= PATROL_LEFT:
		direction = 1.0
	elif position.x >= PATROL_RIGHT:
		direction = -1.0

	$Sprite2D.flip_h = direction > 0

	move_and_slide()
