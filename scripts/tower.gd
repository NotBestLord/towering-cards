class_name TowerNode
extends Node2D


@export var card : Card :
	set(value):
		card = value
		_update()


func _update() -> void:
	if not is_instance_valid(card):
		return
	$Sprite2D.texture = card.sprite
	$Sprite2D.offset.y = -card.sprite.get_height() / 2.
