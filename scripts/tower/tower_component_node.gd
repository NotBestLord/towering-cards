class_name TowerComponentNode
extends Node2D


@export var component : TowerComponent


func _tower_ready() -> void:
	assert(is_instance_valid(component), "Component Invalid")
	component.tower = get_tower()
	component._tower_ready()


func _tower_process(delta : float) -> void:
	assert(is_instance_valid(component), "Component Invalid")
	component._tower_process(delta)


func _tower_predelete() -> void:
	assert(is_instance_valid(component), "Component Invalid")
	component._tower_predelete()


func _round_begin() -> void:
	assert(is_instance_valid(component), "Component Invalid")
	component._round_begin()


func _round_end() -> void:
	assert(is_instance_valid(component), "Component Invalid")
	component._round_end()

func get_tower() -> TowerNode:
	return get_parent() as TowerNode
