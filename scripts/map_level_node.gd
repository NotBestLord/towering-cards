class_name MapLevelNode
extends Node2D


@export var level : Level
@export var connected_levels : Array[MapLevelNode]
@export var wireless_connected_levels : Array[MapLevelNode]
@export var visible_by_def := false

var lines : Dictionary[MapLevelNode, Line2D] = {}
var is_mouse_inside := false


func _ready() -> void:
	_update()
	
	for conn in connected_levels:
		if not conn.connected_levels.has(self):
			conn.connected_levels.append(self)
	for conn in wireless_connected_levels:
		if not conn.wireless_connected_levels.has(self):
			conn.wireless_connected_levels.append(self)
	
	await get_tree().process_frame
	
	_create_lines()


func _process(_delta: float) -> void:
	_update()
	for conn in connected_levels:
		lines[conn].visible = conn.visible


func _input(event: InputEvent) -> void:
	if not is_mouse_inside:
		return
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			Map.current.pressed_node(self)


func _create_lines() -> void:
	for conn in connected_levels:
		var line := Line2D.new()
		line.add_point(Vector2.ZERO)
		line.add_point(conn.global_position - global_position)
		add_child(line)
		lines[conn] = line


func _update() -> void:
	visible = Global.completed_levels.has(name) or visible_by_def
	if not visible:
		for conn in connected_levels:
			visible = visible or Global.completed_levels.has(conn.name)
		for conn in wireless_connected_levels:
			visible = visible or Global.completed_levels.has(conn.name)


func _on_area_2d_mouse_entered() -> void:
	is_mouse_inside = true


func _on_area_2d_mouse_exited() -> void:
	is_mouse_inside = false
