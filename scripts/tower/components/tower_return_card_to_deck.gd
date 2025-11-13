class_name TowerCardReturnComponent
extends TowerComponent


func _tower_predelete() -> void:
	if not is_instance_valid(tower.get_tree()):
		return
	Global.hand.add_card_global(tower.card, tower.get_global_transform_with_canvas().origin)
