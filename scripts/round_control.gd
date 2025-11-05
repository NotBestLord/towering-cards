class_name RoundController
extends Control


func _on_round_button_pressed() -> void:
	LevelContainer.current.begin_round()
