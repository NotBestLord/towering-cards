class_name TowerTimerComponent
extends TowerComponent


var skull := preload("res://assets/textures/icons/skull_icon.tres")


@export var rounds := 1
@export var return_to_deck := true

var status_effect : StatusEffect


func _tower_ready() -> void:
	status_effect = StatusEffect.new()
	status_effect.icon = skull
	status_effect.text = "%d" % rounds
	tower.status_effects.append(status_effect)


func _round_end() -> void:
	rounds -= 1
	if rounds <= 0:
		if return_to_deck:
			CardPile.current.add_card(tower.card)
		tower.queue_free()
	else:
		status_effect.text = "%d" % rounds
		tower.refresh_hover()
