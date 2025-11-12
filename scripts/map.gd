extends Node2D


func _process(_delta: float) -> void:
	$Camera2D.enabled = visible
