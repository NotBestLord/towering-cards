class_name TowerTimerComponent
extends TowerComponent


@export var rounds := 1


func _round_end() -> void:
	rounds -= 1
	if rounds <= 0:
		tower.queue_free()
