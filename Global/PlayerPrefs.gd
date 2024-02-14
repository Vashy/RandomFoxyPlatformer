extends Resource
class_name PlayerPrefs

@export var music_enabled := false

signal music_preference_changed(bool)

func toggle_music():
	music_enabled = not music_enabled
	music_preference_changed.emit(music_enabled)
