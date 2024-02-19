extends CanvasLayer

func _on_restart_button_pressed():
	if Game.saved_game.level_reached == 2:
		get_tree().change_scene_to_file("res://Scenes/LevelTwo.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/LevelOne.tscn")

func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
