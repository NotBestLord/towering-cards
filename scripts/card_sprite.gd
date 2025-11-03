@tool
class_name CardSprite
extends Node2D


@export var card : Card :
	set(value):
		card = value
		_update()


func _update() -> void:
	if not is_instance_valid(card):
		return
	$Bg.self_modulate = card.bg_color
