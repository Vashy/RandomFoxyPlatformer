extends State

@export var player: Player

func enter():
	%AnimationPlayer.play("Jump")
	%Sounds/JumpSfx.play()
	jump()

func physics_update(_delta: float):
	player._move_based_on_direction()

	if player.velocity.y < 0:
		%AnimationPlayer.play("Jump")
	elif player.velocity.y == 0:
		transitioned.emit(self, "Idle")

func jump():
	player.velocity.y = player.JUMP_VELOCITY
