class_name Card
extends Resource


@export_category("Visual")
@export var name : String
@export_multiline var description : String
@export var sprite : Texture
@export_color_no_alpha var bg_color : Color

@export_category("Mechanics")
@export var cost := 1
@export var components : Array[TowerComponent]


func create_components(tower : TowerNode) -> void:
	for comp in components:
		var node := TowerComponentNode.new()
		node.component = comp.duplicate()
		tower.add_child(node)
