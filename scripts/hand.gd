class_name Hand
extends Node2D


var card_sprite_scene := preload('res://resources/nodes/card_in_hand.tscn')


## Seperate additional to half of card width
@export var add_seperate := 4

var focused : CardInHand
var selected : CardInHand


func _ready() -> void:
	await get_tree().create_timer(2).timeout
	add_card(load("res://resources/cards/fire_spirit.tres"))
	add_card(load("res://resources/cards/fire_spirit.tres"))
	add_card(load("res://resources/cards/fire_spirit.tres"))
	add_card(load("res://resources/cards/fire_spirit.tres"))


func add_card(card : Card) -> void:
	var sprite := card_sprite_scene.instantiate()
	sprite.hand = self
	sprite.card = card
	add_child(sprite)
	_update()


func grab_focus(card : CardInHand) -> void:
	focused = card
	_update()


func click_card(card : CardInHand) -> void:
	selected = card
	_update()
	


func release_focus(card : CardInHand) -> void:
	if focused == card:
		focused = null
		_update()


func _update() -> void:
	var t_width := 0.
	var c_count := 0
	for node in get_children():
		if node is CardInHand:
			c_count += 1
			if c_count > 1:
				t_width += add_seperate + 100
	
	var begin := -t_width / 2.
	var dx := t_width / (c_count - 1)
	
	var tween := get_tree().create_tween()
	for node in get_children():
		if node is CardInHand:
			var y := 0
			if node == focused or node == selected:
				y = -128
				begin += add_seperate
			tween.parallel().tween_property(
				node, "position", Vector2(begin, y), 0.5
			).from_current()
			
			if node == focused or node == selected:
				begin += 100 - add_seperate * 2
			begin += dx
	
