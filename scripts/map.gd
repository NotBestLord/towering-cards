class_name Map
extends Node2D


static var current : Map

var current_level_node : MapLevelNode


func _ready() -> void:
	current = self
	visibility_changed.connect(
		func():
			$CanvasLayer/MapNodeMenu.hide()
	)


func _process(_delta: float) -> void:
	$Camera2D.enabled = visible


func pressed_node(node : MapLevelNode) -> void:
	current_level_node = node
	$CanvasLayer/MapNodeMenu.show()


func _on_start_pressed() -> void:
	if not is_instance_valid(current_level_node):
		return
	Global.enter_level(current_level_node)
