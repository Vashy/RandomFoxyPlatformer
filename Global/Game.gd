extends Node

const _SAVED_GAME_PATH = "user://saved_game.tres"
const _PLAYER_PREFS_PATH = "user://player_prefs.tres"

var player_stats: PlayerStats = preload("res://Global/player_stats.tres")
var game_state: GameState = preload("res://Global/GameState.tres")
var player_prefs: PlayerPrefs
var saved_game: SavedGame

signal enemy_defeated(String, int)

func _ready():
	player_stats.on_player_death.connect(_trigger_player_death)
	enemy_defeated.connect(_on_enemy_defeated)
	_load_player_prefs()
	_load_saved_game()

func reset():
	player_stats.reset()
	game_state.reset()

func _trigger_player_death():
	#game_state.level_state.last_level_reached = load("res://Scenes/%s.tscn" % [get_tree().current_scene.name])
	await get_tree().create_timer(1.0).timeout
	reset()
	call_deferred("load_game_over_scene")

func add_gold(amount: int) -> int:
	return game_state.add_gold(amount)

func notify_enemy_defeated(enemy_name: String, difficulty: int):
	print("enemy defeated: " + enemy_name)
	enemy_defeated.emit(difficulty)

func load_game_over_scene():
	get_tree().change_scene_to_file("res://Scenes/GameOverScene.tscn")

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("Saving player_prefs")
		ResourceSaver.save(player_prefs, _PLAYER_PREFS_PATH)
		print("Quitting")

func level_reached(level: int):
	saved_game = SavedGame.new()
	saved_game.level_reached = level
	ResourceSaver.save(saved_game, _SAVED_GAME_PATH)

func _load_player_prefs():
	if not FileAccess.file_exists(_PLAYER_PREFS_PATH):
		player_prefs = PlayerPrefs.new()
	else:
		player_prefs = ResourceLoader.load(_PLAYER_PREFS_PATH) as PlayerPrefs

func _load_saved_game():
	if not FileAccess.file_exists(_SAVED_GAME_PATH):
		saved_game = SavedGame.new()
	else:
		saved_game = ResourceLoader.load(_SAVED_GAME_PATH) as SavedGame

func quit():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()

func _on_enemy_defeated(difficulty: int):
	add_gold(difficulty)
