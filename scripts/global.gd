extends Node


var energy := 10.
var max_energy := 10.
var living_enemies : Array[EnemyNode] = []


var enemies : Dictionary[String, Enemy] = {}


func _ready() -> void:
	_load_enemies()


func get_enemy_target(tower : TowerNode, px_range : float) -> EnemyNode:
	return null


func _load_enemies() -> void:
	var dir := DirAccess.open("res://resources/enemies")
	for file in dir.get_files():
		var enemy : Enemy = load("res://resources/enemies/%s" % file)
		if is_instance_valid(enemy):
			enemies[file.replace(".tres", "")] = enemy
