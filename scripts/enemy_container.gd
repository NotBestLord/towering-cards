class_name EnemyContainer
extends Node2D


static var current : EnemyContainer


var enemy_node_scene := preload("res://resources/nodes/enemy.tscn")


func _ready() -> void:
	current = self


func spawn_enemy(enemy : Enemy) -> void:
	var enemy_node := enemy_node_scene.instantiate()
	enemy_node.enemy = enemy
	add_child(enemy_node)
