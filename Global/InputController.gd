extends Node2D

@onready var menu_scene: Menu = preload("res://Scenes/PauseMenu.tscn").instantiate()

var is_menu_open := false

func _ready():
	menu_scene.on_resume_pressed.connect(toggle_menu)

func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		call_deferred("toggle_menu")

func toggle_menu():
	if not is_menu_open:
		get_tree().paused = true
		add_child(menu_scene)
	else:
		get_tree().paused = false
		remove_child(menu_scene)
	is_menu_open = not is_menu_open
