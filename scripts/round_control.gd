class_name RoundController
extends Control


func _process(_delta: float) -> void:
	$Panel/Health/RichTextLabel.text = "%d" % Global.health


func _on_round_button_pressed() -> void:
	if Global.round_ongoing:
		return
	LevelContainer.current.begin_round()
