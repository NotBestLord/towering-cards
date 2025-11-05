class_name EnemyNode
extends Node2D


@export var enemy : Enemy
@export var flip_h := false :
	set(value):
		flip_h = value
		scale.x = -1 if flip_h else 1
@onready var sprite := $Sprite
@onready var shape := $Area2D/CollisionShape2D


var progress := 0.
var health := 0.
var speed := 0.


func _ready() -> void:
	Global.living_enemies.append(self)
	health = enemy.health
	speed = enemy.speed
	_update()


func _process(delta: float) -> void:
	position = EnemyPath.current.curve.sample_baked(progress)
	progress += delta * speed * 16
	var next := EnemyPath.current.curve.sample_baked(progress)
	flip_h = next.x < position.x


func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		Global.living_enemies.erase(self)


func _update() -> void:
	if not is_instance_valid(enemy):
		return
	sprite.texture = enemy.sprite
	sprite.offset.y = -enemy.sprite.get_height() / 2. + 2
	shape.position.y = sprite.offset.y
	shape.shape.size = enemy.sprite.get_size()


func hit(damage : float) -> void:
	health -= damage
	if health <= 0:
		queue_free()
		return
	sprite.material.set_shader_parameter("enabled", true)
	await get_tree().create_timer(.3).timeout
	sprite.material.set_shader_parameter("enabled", false)
