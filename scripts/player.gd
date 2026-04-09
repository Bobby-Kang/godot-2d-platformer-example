extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -550.0
const AXE_SWING_SPEED_IDLE = 0.0
const AXE_SWING_SPEED_ATTACK = 20.0
const AXE_OFFSET_X = 18.0
const AXE_SWING_RANGE = 8.0

const MAX_HP = 10

var axe_angle: float = 0.0
var axe_attacking: bool = false
var axe_hit_bodies: Array = []
var hp: int = MAX_HP

func _ready() -> void:
	$HealthBar.setup(MAX_HP)
	$HealthBar.update_hp(hp)

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump (Space, W)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle movement (Arrow keys + A/D)
	var direction: float = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		$Sprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Axe swing on right side
	if Input.is_action_just_pressed("attack"):
		axe_attacking = true
		axe_hit_bodies.clear()
	if axe_attacking:
		axe_angle += AXE_SWING_SPEED_ATTACK * delta
		if axe_angle >= TAU:
			axe_angle = fmod(axe_angle, TAU)
			axe_attacking = false
	var facing: float = -1.0 if $Sprite2D.flip_h else 1.0
	var axe_pos = Vector2(AXE_OFFSET_X * facing, sin(axe_angle) * AXE_SWING_RANGE)
	$Axe.flip_h = $Sprite2D.flip_h
	$Axe.position = axe_pos
	$Axe.rotation = (0.785398 + sin(axe_angle) * 0.3) * facing
	$AxeHitbox.position = axe_pos

	# Hit detection (only during attack, once per swing per body)
	if axe_attacking:
		for body in $AxeHitbox.get_overlapping_bodies():
			if body.has_method("take_hit") and body not in axe_hit_bodies:
				axe_hit_bodies.append(body)
				body.take_hit()

	move_and_slide()
