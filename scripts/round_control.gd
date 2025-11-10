class_name RoundController
extends Control


var start_round_icon := preload("res://assets/textures/icons/start_icon.png")
var pause_round_icon := preload("res://assets/textures/icons/pause_icon.png")


func _process(_delta: float) -> void:
	visible = Global.game_ongoing
	$Panel/TextureRect/RichTextLabel.text = "%d" % Global.health
	$Panel/RoundButton/ButtonIcon.texture = (
		pause_round_icon
		if Global.round_ongoing else
		start_round_icon
	)


func _on_round_button_pressed() -> void:
	if Global.round_ongoing:
		return
	LevelContainer.current.begin_round()
