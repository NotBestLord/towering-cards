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
	$Bg.self_modulate = Card.TYPE_COLORS[card.type]
	$Border.self_modulate = Card.TYPE_COLORS[card.type]
	$TopPanel/Name.text = card.name.capitalize()
	$BottomPanel/Description.text = card.description
	$Energy/EnergyLabel.text = "%d" % card.cost
	$TowerSprite.texture = card.sprite
	$TowerSprite.offset.y = -card.sprite.get_height() / 2. + 2
	$Recycle.visible = not card.consumable
