class_name CardInHand
extends Node2D


var hand : Hand
var card : Card :
	set(value):
		card = value
		$CardSprite.card = card
		$CardBack.self_modulate = Card.TYPE_COLORS[card.type]
		$CardBack/Border.self_modulate = Card.TYPE_COLORS[card.type]
var flipped := false :
	set(value):
		flipped = value
		$CardSprite.visible = not flipped
		$CardBack.visible = flipped


func _on_mouse_entered() -> void:
	if not is_visible_in_tree() or not is_instance_valid(hand):
		return
	hand.grab_focus(self)


func _on_mouse_exited() -> void:
	if not is_visible_in_tree() or not is_instance_valid(hand):
		return
	hand.release_focus(self)


func _on_area_2d_gui_input(event: InputEvent) -> void:
	if not is_instance_valid(hand):
		return
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			hand.click_card(self)
			get_viewport().set_input_as_handled()
