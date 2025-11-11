extends Control


@export var status_effect : StatusEffect :
	set(value):
		status_effect = value
		$Sprite2D.texture = status_effect.icon
		$Text.text = status_effect.text
