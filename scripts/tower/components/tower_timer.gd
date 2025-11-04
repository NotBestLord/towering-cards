class_name TowerTimerComponent
extends TowerComponent


@export var rounds := 1
@export var return_to_deck := true


func _round_end() -> void:
	rounds -= 1
	if rounds <= 0:
		if return_to_deck:
			pass ## TBD add to deck
		tower.queue_free()
