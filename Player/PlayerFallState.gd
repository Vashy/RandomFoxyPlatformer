extends State

@export var player: Player

func enter():
	%AnimationPlayer.play("Fall")

func physics_update(_delta: float):
	player._move_based_on_direction()
	if player.velocity.y == 0:
		transitioned.emit(self, "Idle")
