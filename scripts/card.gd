class_name Card
extends Resource


enum Type {
	HUMAN,
	FIRE,
	WATER,
	EARTH,
	WIND,
	LIGHTNING,
}


enum Tag {
	ATTACK,
	DEFEND,
	SUMMONER,
	TEMPORARY,
	MELEE,
}


const TYPE_COLORS := {
	Type.HUMAN: Color.LIGHT_YELLOW,
	Type.FIRE: Color.ORANGE_RED,
	Type.WATER: Color.DODGER_BLUE,
	Type.EARTH: Color.SADDLE_BROWN,
	Type.WIND: Color.SPRING_GREEN,
	Type.LIGHTNING: Color.GOLD,
	
}


@export_category("Visual")
@export var name : String
@export_multiline var description : String
@export var sprite : Texture2D
@export var type : Type
@export_enum("Tower", "Ability") var function := 0

@export_category("Mechanics")
@export var cost := 1
@export var tags : Array[Tag]
@export var components : Array[TowerComponent]


func create_components(tower : TowerNode) -> void:
	for comp in components:
		var node := TowerComponentNode.new()
		node.component = comp.duplicate()
		tower.add_child(node)
		tower.move_child(node, 0)
