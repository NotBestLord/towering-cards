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


func _process(delta: float) -> void:
	if executing_commands.is_empty() and round_commands.is_empty() and Global.living_enemies.is_empty():
		if Global.round_ongoing:
			if Global.round_index >= Global.max_round:
				Global.exit_level(true)
			else:
				Global.round_ongoing = false
				Global.energy = clamp(Global.energy + 1, 0, Global.max_energy)
				for tower in Global.placed_towers:
					tower.end_round()
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
			while t >= rate:
				t -= rate
				var enemy : Enemy = Global.enemies.get(comm_args[1], null)
				assert(is_instance_valid(enemy), "Invalid Enemy")
				spawn_enemy(enemy)
			if executing_commands[command].y >= duration:
				executing_commands.erase(command)
				continue
		executing_commands[command].x = t


func begin_round() -> void:
	Global.round_index += 1
	Global.round_ongoing = true
	round_commands.clear()
	for tower in Global.placed_towers:
		tower.start_round()
	for line in loaded_level.get_round_data(Global.round_index).split("\n"):
		if line.strip_edges().is_empty():
			continue
		round_commands.append(line.strip_edges())


func load_level(level : Level) -> void:
	unload_level()
	loaded_level = level
	Global.round_index = 0
	Global.max_round = loaded_level.get_round_count()
	Global.energy = 10 ## TBD
	Global.hand.clear()
	Global.hand.add_cards(Global.deck)
	loaded_map = level.map.instantiate()
	add_child(loaded_map)
	move_child(loaded_map, 0)


func unload_level() -> void:
	loaded_level = null
	if is_instance_valid(loaded_map):
		loaded_map.queue_free()


func spawn_enemy(enemy : Enemy, progress := 0.) -> void:
	var enemy_node := enemy_node_scene.instantiate()
	enemy_node.enemy = enemy
	enemy_node.progress = progress
	call_deferred("add_child", enemy_node)
	enemy_node.global_position = Vector2(0, -10000)
