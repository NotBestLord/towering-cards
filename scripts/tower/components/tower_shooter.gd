class_name TowerShootComponent
extends TowerComponent


@export var range := 2.
@export var damage := 1.
@export var attack_rate := 1.
@export var bullet_speed := 32.
@export var bullet : PackedScene


var timer := 0.


func _tower_ready() -> void:
	pass


func _tower_process(delta : float) -> void:
	var attack_delay := 1 / attack_rate
	timer += delta
	if timer >= attack_delay:
		## TBD ATTACK
		timer = 0


func _tower_predelete() -> void:
	pass


func _draw(comp_node : TowerComponentNode) -> void:
	var r := range * 16
	comp_node.draw_circle(Vector2.ZERO, r - 1, Color(0.4,0.4,0.4,0.6), false, 2)
