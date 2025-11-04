class_name TowerShootComponent
extends TowerComponent


@export var tile_range := 2.
@export var damage := 1.
@export var attack_rate := 1.

@export_category("Bullet")
@export var bullet : PackedScene
@export var bullet_count := 1
@export_range(0,180) var bullet_angle_variance : int = 0
@export var bullet_delete_after : float = 30
@export var bullet_scale := 1.
@export var bullet_speed := 64.
@export var bullet_pierce := 0
@export var bullet_multishot_spread := 15.


var target : EnemyNode
var timer := 0.


func _tower_process(delta : float) -> void:
	var attack_delay := 1 / attack_rate
	timer += delta
	if timer >= attack_delay:
		target = Global.get_enemy_target(tower, tile_range * 16.)
		if is_instance_valid(target):
			shoot()
			var a := get_angle()
			while a < 0:
				a += 90
			tower.flip_h = a > 90 and a < 270
		timer = 0


func _draw(comp_node : TowerComponentNode) -> void:
	var r := tile_range * 16
	comp_node.draw_circle(Vector2.ZERO, r - 1, Color(0.4,0.4,0.4,0.6), false, 2)


func get_angle() -> float:
	if not is_instance_valid(target):
		return 0.
	return rad_to_deg(tower.global_position.angle_to_point(target.global_position))


func shoot() -> void:
	if bullet_count == 1:
		shoot_single()
	else:
		shoot_multi(bullet_count)


func shoot_single(angle := -1.) -> void:
	assert(is_instance_valid(bullet), "Missing Bullet Scene")
	if angle == -1:
		angle = get_angle()
	
	var new_bullet = bullet.instantiate()
	new_bullet.on_hit.connect(
		func(node):
			if node.get_parent() is EnemyNode:
				node.get_parent().hit(damage)
	)
	new_bullet.speed = bullet_speed
	new_bullet.size = bullet_scale
	new_bullet.delete_after = bullet_delete_after
	new_bullet.pierce = bullet_pierce
	new_bullet.angle = angle
	
	tower.add_child(new_bullet)
	new_bullet.global_position = tower.global_position


func shoot_multi(amount := 1, angle := -1.) -> void:
	assert(is_instance_valid(bullet), "Missing Bullet Scene")
	assert(amount > 0, "Bullet amount must be > 0")
	
	if angle == -1:
		angle = get_angle()
	
	var angle_increment := bullet_multishot_spread / amount
	var start_angle := angle - (bullet_multishot_spread / 2.)
	
	for i in amount:
		shoot_single(start_angle + (angle_increment * i))
