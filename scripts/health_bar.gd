extends Node2D

const HEART_FULL = preload("res://assets/0x72_DungeonTilesetII_v1.7/0x72_DungeonTilesetII_v1.7/frames/ui_heart_full.png")
const HEART_HALF = preload("res://assets/0x72_DungeonTilesetII_v1.7/0x72_DungeonTilesetII_v1.7/frames/ui_heart_half.png")
const HEART_EMPTY = preload("res://assets/0x72_DungeonTilesetII_v1.7/0x72_DungeonTilesetII_v1.7/frames/ui_heart_empty.png")

const HEART_SPACING = 12

var hearts: Array = []

func setup(max_hp: int) -> void:
	for child in get_children():
		child.queue_free()
	hearts.clear()

	var num_hearts = ceili(max_hp / 2.0)
	var total_width = (num_hearts - 1) * HEART_SPACING
	for i in num_hearts:
		var sprite = Sprite2D.new()
		sprite.texture = HEART_FULL
		sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		sprite.position = Vector2(i * HEART_SPACING - total_width / 2.0, 0)
		add_child(sprite)
		hearts.append(sprite)

func update_hp(hp: int) -> void:
	for i in hearts.size():
		var heart_hp = hp - i * 2
		if heart_hp >= 2:
			hearts[i].texture = HEART_FULL
		elif heart_hp == 1:
			hearts[i].texture = HEART_HALF
		else:
			hearts[i].texture = HEART_EMPTY
