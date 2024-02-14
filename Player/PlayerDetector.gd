extends Node2D
class_name PlayerDetector

@export var body: CharacterBody2D
@export var proximity_distance := 200
var player: CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("Player")

func distance_from_player() -> Vector2:
	return player.global_position - body.global_position

func is_in_proximity() -> bool:
	return abs(distance_from_player().length()) <= proximity_distance
