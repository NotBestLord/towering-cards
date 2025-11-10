class_name CardPile
extends Node2D


var card_sprite_scene := preload('res://resources/nodes/card_in_hand.tscn')

static var current : CardPile


func _ready() -> void:
	current = self


func load_deck() -> void:
	var deck := Global.deck.duplicate()
	deck.shuffle()
	for card in deck:
		add_card(card)


func add_card(card : Card) -> void:
	var sprite := card_sprite_scene.instantiate()
	sprite.card = card
	sprite.flipped = true
	add_child(sprite)
	move_child(sprite, 0)
	sprite.scale = Vector2.ONE * 0.75


func pull_card() -> void:
	if get_child_count() == 0:
		return
	var sprite := get_child(get_child_count() - 1)
	sprite.hand = Global.hand
	sprite.flipped = false
	sprite.reparent(Global.hand)
	sprite.scale = Vector2.ONE
	Global.hand._update()
