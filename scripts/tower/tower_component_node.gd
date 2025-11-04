class_name TowerComponentNode
extends Node2D


@export var component : TowerComponent


func _tower_ready() -> void:
	assert(is_instance_valid(component), "Component Invalid")
	component.tower = get_tower()
	component._tower_ready()


func _tower_predelete() -> void:
	assert(is_instance_valid(component), "Component Invalid")
	component._tower_predelete()


func get_tower() -> TowerNode:
	return get_parent() as TowerNode
