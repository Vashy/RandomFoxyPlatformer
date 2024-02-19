extends Label

@export var game_state: GameState

func _process(_delta):
	text = str(100 + game_state.gold)
