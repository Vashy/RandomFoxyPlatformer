extends CanvasLayer
class_name Menu

signal on_resume_pressed

func _on_resume_button_pressed():
	on_resume_pressed.emit()

func _on_toggle_music_button_pressed():
	BackgroundMusicPlayer.toggle_music()

func _on_quit_button_pressed():
	Game.quit()
