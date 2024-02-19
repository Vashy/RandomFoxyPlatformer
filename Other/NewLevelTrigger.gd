extends Area2D

@export var new_level_scene: PackedScene

func _ready():
	assert(new_level_scene != null, "Must provide a next level scene!")

func _on_body_entered(body):
	if body is Player:
		call_deferred("load_next_level")

func load_next_level():
	Game.level_reached(2)
	get_tree().change_scene_to_packed(new_level_scene)
