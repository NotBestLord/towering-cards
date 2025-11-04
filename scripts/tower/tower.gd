class_name TowerNode
extends Node2D


@export var card : Card
@onready var sprite := $Sprite
@onready var outline := $Outline
@onready var shape := $Area2D/CollisionShape2D

var flip_h := false :
	set(value):
		flip_h = value
		sprite.flip_h = flip_h


func _ready() -> void:
	assert(card != null)
	card.create_components(self)
	_update()
	outline.hide()
	for comp in _get_components():
		comp._tower_ready()
		comp.hide()


func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		for comp in _get_components():
			comp._tower_predelete()


func start_round() -> void:
	for comp in _get_components():
		comp._round_begin()


func end_round() -> void:
	for comp in _get_components():
		comp._round_over()


func _get_components() -> Array[TowerComponentNode]:
	var arr : Array[TowerComponentNode] = []
	for node in get_children():
		if node is TowerComponentNode:
			arr.append(node)
	return arr


func _update() -> void:
	if not is_instance_valid(card):
		return
	sprite.texture = card.sprite
	sprite.offset.y = -card.sprite.get_height() / 2. + 2
	outline.texture = card.sprite
	outline.offset.y = -card.sprite.get_height() / 2. + 2
	shape.position.y = sprite.offset.y
	shape.shape.size = card.sprite.get_size()


func _on_mouse_exited() -> void:
	outline.hide()
	for comp in _get_components():
		comp.hide()


func _on_mouse_entered() -> void:
	outline.show()
	for comp in _get_components():
		comp.show()
