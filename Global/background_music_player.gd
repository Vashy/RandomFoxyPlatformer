extends AudioStreamPlayer

var game_state: GameState = preload("res://Global/GameState.tres")

func _ready():
	game_state.player_prefs.music_preference_changed.connect(_music_preference_changed)
	if game_state.player_prefs.music_enabled:
		play()

func toggle_music():
	game_state.player_prefs.toggle_music()

func _music_preference_changed(music_enabled: bool):
	if music_enabled:
		play()
	else:
		stop()
