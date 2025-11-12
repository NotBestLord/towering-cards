extends Node


var deck : Array[Card] = [
	load("res://resources/cards/mage_merman.tres"),
	load("res://resources/cards/spear_merman.tres"),
	load('res://resources/cards/fire_spirit.tres'),
	load('res://resources/cards/fire_spirit.tres')
]

var game_ongoing := false
var hand : Hand
var round_index := 0
var max_round := 0
var round_ongoing := false
var health := 10.
var energy := 10.
var max_energy := 10.
var living_enemies : Array[EnemyNode] = []
var placed_towers : Array[TowerNode] = []
var level_name := ""

var completed_levels : Array[String] = []

var enemies : Dictionary[String, Enemy] = {}


func _ready() -> void:
	_load_enemies()


func enter_level(map_node : MapLevelNode) -> void:
	LevelContainer.current.load_level(map_node.level)
	Map.current.hide()
	level_name = map_node.name


func exit_level(was_cleared := false) -> void:
	LevelContainer.current.unload_level()
	for node in living_enemies:
		node.queue_free()
	for node in placed_towers:
		node.queue_free()
	Global.round_ongoing = false
	Global.game_ongoing = false
	
	Global.hand.clear()
	
	if was_cleared:
		if not completed_levels.has(level_name):
			completed_levels.append(level_name)
	Map.current.show()


func _load_enemies() -> void:
	var dir := DirAccess.open("res://resources/enemies")
	for file in dir.get_files():
		var enemy : Enemy = load("res://resources/enemies/%s" % file)
		if is_instance_valid(enemy):
			enemies[file.replace(".tres", "")] = enemy
