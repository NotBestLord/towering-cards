extends Sprite2D


var comps : Array[TowerComponent] = []


func _draw() -> void:
	for comp in comps:
		comp._draw(self)
