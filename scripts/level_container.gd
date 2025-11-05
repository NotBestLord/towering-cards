class_name LevelContainer
extends Node2D


static var current : LevelContainer


var enemy_node_scene := preload("res://resources/nodes/enemy.tscn")


var loaded_level : Level
var loaded_map : Node2D
var round_commands : Array[String] = []
var executing_commands : Dictionary[String, float] = {}


func _ready() -> void:
	current = self


func _process(delta: float) -> void:
	if executing_commands.is_empty():
		while not round_commands.is_empty():
			var command : String = round_commands.front()
			if executing_commands.is_empty() or command.ends_with("parallel"):
				executing_commands[command] = 0.
				round_commands.pop_front()
	
	for command in executing_commands:
		var t := executing_commands[command] + delta
		var comm_args := command.split(" ")
		if comm_args[0] == "enemy":
			assert(comm_args.size() == 5)


func begin_round() -> void:
	Global.round += 1
	round_commands.clear()
	for line in loaded_level.get_round_data(Global.round).split("\n"):
		round_commands.append(line.strip_edges())


func load_level(level : Level) -> void:
	unload_level()
	loaded_level = level
	Global.round = 0
	Global.energy = 4
	Global.hand.clear()
	loaded_map = level.map.instantiate()
	add_child(loaded_map)
	move_child(loaded_map, 0)


func unload_level() -> void:
	loaded_level = null
	if is_instance_valid(loaded_map):
		loaded_map.queue_free()


func spawn_enemy(enemy : Enemy) -> void:
	var enemy_node := enemy_node_scene.instantiate()
	enemy_node.enemy = enemy
	add_child(enemy_node)
