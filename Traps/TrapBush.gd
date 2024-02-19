extends Sprite2D

class_name TrapBush

@export var spawn_object: Resource
@onready var timer: Timer = get_node("RespawnReset")
var spawned := false

func _on_area_2d_body_entered(body):
	if body is Player and not spawned:
		call_deferred("spawn_frog")

func spawn_frog():
	if spawn_object:
		var spawned_object = spawn_object.instantiate()
		spawned_object.global_position = global_position
		add_sibling(spawned_object)
		spawned = true
		print("spawned")
		timer.start()

func _on_respawn_reset_timeout():
	spawned = false
