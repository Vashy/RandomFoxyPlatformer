extends Node2D

@export var disablable_node: Node2D
@export var proximity_area: Area2D

func _ready():
	if proximity_area:
		proximity_area.body_entered.connect(enable_node_on_player)
		proximity_area.body_exited.connect(disable_node_on_player)
	if disablable_node:
		call_deferred("disable")

func enable_node_on_player(body: Node2D):
	if disablable_node and body.name == "Player":
		print("enabling node " + disablable_node.name)
		disablable_node.process_mode = Node.PROCESS_MODE_PAUSABLE

func disable_node_on_player(body: Node2D):
	if disablable_node and body.name == "Player":
		call_deferred("disable")

func disable():
	print("disabling node " + disablable_node.name)
	disablable_node.process_mode = Node.PROCESS_MODE_DISABLED
	proximity_area.process_mode = Node.PROCESS_MODE_PAUSABLE
