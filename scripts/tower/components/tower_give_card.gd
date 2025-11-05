class_name TowerCardGeneratorComponent
extends TowerComponent


enum Type {
	GIVE_ALL,
	GIVE_ONE,
}


## Number of rounds of delay
@export var delay := 1
@export var generation_type := Type.GIVE_ALL
@export var cards_generated : Array[Card] = []
@export var oneshot := false

var timer := 0


func _round_end() -> void:
	if timer == -1:
		return
	timer += 1
	if timer == delay:
		if generation_type == Type.GIVE_ALL:
			for card in cards_generated:
				Global.hand.add_card_global(card, tower.global_position)
		elif generation_type == Type.GIVE_ONE:
			Global.hand.add_card_global(cards_generated.pick_random(), tower.global_position)
		
		if oneshot:
			timer = -1


func _draw() -> void:
	pass
