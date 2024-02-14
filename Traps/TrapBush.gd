extends Sprite2D

class_name TrapBush

@export var spawn_object: Resource
@onready var timer: Timer = get_node("RespawnReset")
var spawned := false

func _on_area_2d_body_entered(body):
	if body.name == "Player" and not spawned:
		call_deferred("spawn_frog")

func spawn_frog():
	add_child(spawn_object.instantiate())
	spawned = true
	timer.start()

func _on_respawn_reset_timeout():
	spawned = false
