class_name TowerTimerComponent
extends TowerComponent


var font := preload("res://assets/fonts/PixelOperator8.ttf")
var hourglass := preload("res://assets/textures/icons/hourglass_icon.png")


@export var rounds := 1
@export var return_to_deck := true


func _round_end() -> void:
	rounds -= 1
	if rounds <= 0:
		if return_to_deck:
			CardPile.current.add_card(tower.card)
		tower.queue_free()


func _draw(dt : Node2D) -> void:
	pass
	#var h := -hourglass.get_height()
	#var pos := Vector2(-hourglass.get_width() / 2., -h - hourglass.get_height())
	#dt.draw_texture(hourglass, pos)
	#dt.draw_char_outline(font, Vector2(0, -h), "%d" % rounds, 8, 4, Color.BLACK)
	#dt.draw_char(font, Vector2(0, -h), "%d" % rounds, 8)
	#comp_node.draw_style_box()
