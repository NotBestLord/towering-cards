class_name TowerNode
extends Node2D


@export var card : Card


func _ready() -> void:
	assert(card != null)
	card.create_components(self)
	_update()
	for comp in _get_components():
		comp._tower_ready()


func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		for comp in _get_components():
			comp._tower_predelete()


func _get_components() -> Array[TowerComponentNode]:
	var arr : Array[TowerComponentNode] = []
	for node in get_children():
		if node is TowerComponentNode:
			arr.append(node)
	return arr


func _update() -> void:
	if not is_instance_valid(card):
		return
	$Sprite2D.texture = card.sprite
	$Sprite2D.offset.y = -card.sprite.get_height() / 2.
