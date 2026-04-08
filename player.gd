extends Node2D

var speed := 200.0
var radius := 30.0

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, Color(0.2, 0.5, 1.0))

func _process(delta: float) -> void:
	var dir := Vector2.ZERO
	if Input.is_key_pressed(KEY_W):
		dir.y -= 1
	if Input.is_key_pressed(KEY_S):
		dir.y += 1
	if Input.is_key_pressed(KEY_A):
		dir.x -= 1
	if Input.is_key_pressed(KEY_D):
		dir.x += 1

	if dir != Vector2.ZERO:
		position += dir.normalized() * speed * delta
