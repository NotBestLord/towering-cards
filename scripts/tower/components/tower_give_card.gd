class_name TowerCardGeneratorComponent
extends TowerComponent

## Number of rounds of delay
@export var delay := 1
@export var cards_generated : Array[Card] = []
@export var oneshot := false

var timer := 0


func _round_end() -> void:
	if timer == -1:
		return
	timer += 1
	if timer == delay:
		for card in cards_generated:
			Global.hand.add_card(card)
		if oneshot:
			timer = -1


func _draw(_comp_node : TowerComponentNode) -> void:
	pass
