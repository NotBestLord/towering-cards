class_name LevelContainer
extends Node2D


static var current : LevelContainer


var enemy_node_scene := preload("res://resources/nodes/enemy.tscn")


var loaded_level : Level
var loaded_map : Node2D
var round_commands : Array[String] = []
var executing_commands : Dictionary[String, Vector2] = {}


func _ready() -> void:
	current = self
	await get_tree().process_frame
	load_level(load("res://resources/levels/tutorial.tres"))


func _process(delta: float) -> void:
	if executing_commands.is_empty() and round_commands.is_empty() and Global.living_enemies.is_empty():
		Global.round_ongoing = false
		return
	
	if executing_commands.is_empty():
		while not round_commands.is_empty():
			var command : String = round_commands.front()
			if executing_commands.is_empty() or command.ends_with("parallel"):
				executing_commands[command] = Vector2.ZERO
				round_commands.pop_front()
			else:
				break
	
	for command in executing_commands:
		executing_commands[command].y += delta
		var t := executing_commands[command].x + delta
		var comm_args := command.split(" ")
		if comm_args[0] == "enemy":
			assert(comm_args.size() >= 4, "Invalid Enemy Command")
			var amount := comm_args[2].to_int()
			var duration := comm_args[3].to_float()
			var rate := duration / amount
			if t >= rate:
				t = 0
				var enemy : Enemy = Global.enemies.get(comm_args[1], null)
				assert(is_instance_valid(enemy), "Invalid Enemy")
				spawn_enemy(enemy)
			if executing_commands[command].y >= duration:
				executing_commands.erase(command)
				continue
		executing_commands[command].x = t


func begin_round() -> void:
	Global.round += 1
	Global.round_ongoing = true
	round_commands.clear()
	for line in loaded_level.get_round_data(Global.round).split("\n"):
		if line.strip_edges().is_empty():
			continue
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


func spawn_enemy(enemy : Enemy, global_pos := Vector2(0, -3000)) -> void:
	var enemy_node := enemy_node_scene.instantiate()
	enemy_node.enemy = enemy
	add_child(enemy_node)
	enemy_node.global_position = global_pos
