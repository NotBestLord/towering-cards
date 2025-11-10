class_name TowerNode
extends Node2D


@export var card : Card
@onready var sprite_container := $SpriteCont
@onready var sprite := $SpriteCont/Sprite
@onready var outline := $SpriteCont/Sprite/Outline
@onready var shape := $Area2D/CollisionShape2D
@onready var animator := $AnimationPlayer

var flip_h := false :
	set(value):
		flip_h = value
		sprite_container.scale.x = -1 if flip_h else 1


func _ready() -> void:
	assert(card != null)
	Global.placed_towers.append(self)
	card.create_components(self)
	_update()
	outline.hide()
	for comp in _get_components():
		comp._tower_ready()
		comp.hide()


func _process(delta: float) -> void:
	for comp in _get_components():
		comp._tower_process(delta)


func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		Global.placed_towers.erase(self)
		for comp in _get_components():
			comp._tower_predelete()


func start_round() -> void:
	for comp in _get_components():
		comp._round_begin()


func end_round() -> void:
	for comp in _get_components():
		comp._round_end()


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
	if not is_visible_in_tree():
		return
	outline.hide()
	for comp in _get_components():
		comp.hide()


func _on_mouse_entered() -> void:
	if not is_visible_in_tree():
		return
	outline.show()
	for comp in _get_components():
		comp.show()
