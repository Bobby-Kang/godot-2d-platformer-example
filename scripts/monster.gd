extends CharacterBody2D

const SPEED = 60.0
const PATROL_LEFT = 576.0
const PATROL_RIGHT = 921.0

const MAX_HP = 4

var direction: float = -1.0
var is_hit: bool = false
var hp: int = MAX_HP

func _ready() -> void:
	$HealthBar.setup(MAX_HP)
	$HealthBar.update_hp(hp)

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

func take_hit() -> void:
	if is_hit:
		return
	is_hit = true
	hp = max(hp - 1, 0)
	$HealthBar.update_hp(hp)
	if hp == 0:
		queue_free()
		return
	var tween = create_tween()
	tween.tween_property($Sprite2D, "modulate", Color(1, 0.2, 0.2), 0.05)
	tween.tween_property($Sprite2D, "modulate", Color(1, 1, 1), 0.15)
	tween.tween_callback(func(): is_hit = false)
