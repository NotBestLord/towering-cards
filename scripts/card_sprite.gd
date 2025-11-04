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
	$Border.self_modulate = card.bg_color
	$TopPanel/Name.text = card.name.capitalize()
	$BottomPanel/Description.text = card.description
	$Energy/EnergyLabel.text = "%d" % card.cost
	$TowerSprite.texture = card.sprite
	$TowerSprite.offset.y = -card.sprite.get_height() / 2. + 2
