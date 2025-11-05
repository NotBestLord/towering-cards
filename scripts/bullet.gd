class_name Bullet
extends Area2D
## A node used for [Gun]
##
## This node is used for [Gun], acts like a bullet with configurable speed and angle( for gun )


signal on_hit(target : Node2D)
signal on_delete()

@export_category("Bullet")

## The time in seconds where this bullet is deleted
@export var delete_after : float = 30 

@export_enum("None", "Physics", "Visual") var rotation_mode := 0

## speed of the bullet in pixels per second
var speed : float

## angle of the bullet when fired
var angle : float

var pierce := 0

## used to track time for [delete_after], best not to change it to avoid errors
var time := 0.

var size := 1. :
	set(value):
		scale /= size
		size = value
		scale *= size


func _ready() -> void:
	if rotation_mode == 2:
		for child in get_children():
			if child is Node2D:
				child.rotation_degrees = angle
	if delete_after == 0:
		var screen_checker = VisibleOnScreenNotifier2D.new()
		add_child(screen_checker)
		screen_checker.connect("screen_exited()",on_screen_exited)
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)
	

func _physics_process(delta):
	if rotation_mode == 1:
		rotation_degrees = angle
		position += (Vector2.from_angle(rotation) * speed) * delta
	else:
		position += (Vector2.from_angle(deg_to_rad(angle)) * speed) * delta
	if delete_after > 0:
		time += delta
		if time >= delete_after:
			queue_free()


func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		on_delete.emit()


func hit_check() -> void:
	pierce -= 1
	if pierce < 0:
		queue_free()


func on_screen_exited():
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	on_hit.emit(body)
	hit_check()


func _on_area_entered(area: Area2D) -> void:
	on_hit.emit(area)
	hit_check()
