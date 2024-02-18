extends Node2D

@export var player_stats: PlayerStats

func _ready():
	player_stats.on_player_hit.connect(on_player_health_changed)
	player_stats.on_player_healed.connect(on_player_health_changed)
	player_stats.on_player_death.connect(clear_hearts)
	generate_hearts()

func on_player_health_changed():
	var children = get_children()
	var first = true
	for child in children:
		if first:
			first = false
			continue
		child.queue_free()
	generate_hearts()

func generate_hearts():
	for i in range(1, player_stats.current_HP):
		var heart_node = $"Health Icon".duplicate()
		heart_node.position += Vector2(40 * i, 0)
		$"Health Icon".add_sibling(heart_node)

func clear_hearts():
	for node in get_children():
		node.queue_free()
