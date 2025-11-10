extends Node


var deck : Array[Card] = [
	load("res://resources/cards/mage_merman.tres"),
	load("res://resources/cards/spear_merman.tres"),
]

var game_ongoing := true ## TBD, chaneg after map implemtend
var hand : Hand
var round_index := 0
var max_round := 0
var round_ongoing := false
var health := 10.
var energy := 10.
var max_energy := 10.
var living_enemies : Array[EnemyNode] = []
var placed_towers : Array[TowerNode] = []


var enemies : Dictionary[String, Enemy] = {}


func _ready() -> void:
	_load_enemies()


func _load_enemies() -> void:
	var dir := DirAccess.open("res://resources/enemies")
	for file in dir.get_files():
		var enemy : Enemy = load("res://resources/enemies/%s" % file)
		if is_instance_valid(enemy):
			enemies[file.replace(".tres", "")] = enemy
