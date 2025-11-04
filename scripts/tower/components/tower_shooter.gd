class_name TowerShootComponent
extends TowerComponent


@export var range := 2.
@export var damage := 1.
@export var bullet_speed := 32.
@export var bullet : PackedScene


func _tower_ready() -> void:
	pass


func _tower_predelete() -> void:
	pass
