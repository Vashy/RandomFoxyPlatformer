extends Label

@export var game_state: GameState

func _process(_delta):
	text = str(game_state.gold)
