extends AudioStreamPlayer

func _ready():
	Game.player_prefs.music_preference_changed.connect(_music_preference_changed)
	if Game.player_prefs.music_enabled:
		play()

func toggle_music():
	Game.player_prefs.toggle_music()

func _music_preference_changed(music_enabled: bool):
	if music_enabled:
		play()
	else:
		stop()
