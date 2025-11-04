class_name CardInHand
extends Node2D


var hand : Hand
var card : Card :
	set(value):
		card = value
		$CardSprite.card = card


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			hand.click_card(self)


func _on_mouse_entered() -> void:
	hand.grab_focus(self)


func _on_mouse_exited() -> void:
	hand.release_focus(self)
