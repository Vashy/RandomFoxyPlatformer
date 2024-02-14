extends Node2D

@export var vanishing_node: Node2D

func vanish():
	var tween = get_tree().create_tween()
	var tween1 = get_tree().create_tween()
	tween.tween_property(vanishing_node, "position", vanishing_node.position - Vector2(0, 25), 0.3)
	tween1.tween_property(vanishing_node, "modulate:a", 0, 0.3)
	tween.tween_callback(func (): vanishing_node.queue_free())
