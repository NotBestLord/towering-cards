class_name Hand
extends Node2D


var card_sprite_scene := preload('res://resources/nodes/card_in_hand.tscn')
var tower_scene := preload('res://resources/nodes/tower.tscn')


## Seperate additional to half of card width
@export var add_seperate := 4
@export var place_block : Node2D
@export var place_block_area : Area2D
@export var place_block_tower : Sprite2D

var focused : CardInHand
var selected : CardInHand


func _ready() -> void:
	Global.hand = self
	add_card(load("res://resources/cards/fire_spirit.tres"))
	add_card(load("res://resources/cards/pyromancer.tres"))
	add_card(load("res://resources/cards/weak_child.tres"))
	add_card(load("res://resources/cards/strong_child.tres"))


func _process(_delta: float) -> void:
	place_block.visible = is_instance_valid(selected)
	if place_block.visible:
		var pos := place_block.get_global_mouse_position()
		pos = 16 * floor(pos / 16.)
		pos += Vector2(8, 8)
		place_block.global_position = pos
		if place_block_area.has_overlapping_areas() or place_block_area.has_overlapping_bodies():
			place_block.modulate = Color.RED
		elif Global.energy < selected.card.cost:
			place_block.modulate = Color.RED
		else:
			place_block.modulate = Color.WHITE


func add_card(card : Card, pos := Vector2.ZERO) -> void:
	var sprite := card_sprite_scene.instantiate()
	sprite.hand = self
	sprite.card = card
	add_child(sprite)
	sprite.position = pos
	_update()


func add_card_global(card : Card, global_pos := Vector2.ZERO) -> void:
	add_card(card, global_pos - global_position)


func grab_focus(card : CardInHand) -> void:
	focused = card
	_update()


func click_card(card : CardInHand) -> void:
	if card == selected:
		try_place_selected()
		return
	if card != focused:
		return
	selected = card
	place_block_tower.texture = card.card.sprite
	place_block_tower.offset.y = -card.card.sprite.get_height() / 2. + 2
	_update()


func release_focus(card : CardInHand) -> void:
	if focused == card:
		focused = null
		_update()


func try_place_selected() -> void:
	if not is_instance_valid(selected) or is_instance_valid(focused):
		return
	if place_block_area.has_overlapping_areas() or place_block_area.has_overlapping_bodies():
		return
	if Global.energy < selected.card.cost:
		return
	var pos := place_block.get_global_mouse_position()
	pos = 16 * floor(pos / 16.)
	pos += Vector2(8, 8)
	
	Global.energy -= selected.card.cost
	
	var tower := tower_scene.instantiate()
	tower.card = selected.card
	get_tree().root.add_child(tower)
	tower.global_position = pos
	selected.queue_free()
	if focused == selected:
		focused = null
	selected = null
	await get_tree().process_frame
	_update()


func _update() -> void:
	var t_width := 0.
	var c_count := 0
	var cards : Array[CardInHand] = []
	for node in get_children():
		if node is CardInHand:
			cards.append(node)
			c_count += 1
			if c_count > 1:
				t_width += add_seperate + 100
	
	if cards.is_empty():
		return
	
	cards.sort_custom(
		func(a,b):
			if a.position.x < b.position.x:
				return true
			return false
	)
	while not cards.is_empty():
		move_child(cards.pop_back(), 0)
	
	var begin := -t_width / 2.
	var dx := t_width / (c_count - 1)
	
	var tween := get_tree().create_tween()
	for node in get_children():
		if node is CardInHand:
			var y := 0
			if node == selected:
				y = -128
				begin += add_seperate
			if node == focused and not is_instance_valid(selected):
				y = -128
				begin += add_seperate
			tween.parallel().tween_property(
				node, "position", Vector2(begin, y), 0.5
			).from_current()
			
			if node == focused or node == selected:
				begin += 100 - add_seperate * 2
			begin += dx
	
