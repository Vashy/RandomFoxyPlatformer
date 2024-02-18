extends State

@export var player: Player

func enter():
	%AnimationPlayer.play("Run")

func physics_update(_delta: float):
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		transitioned.emit(self, "Jump")

	var direction = player.calculate_direction_from_input()
	if direction:
		player.velocity.x = direction * player.SPEED

	if direction == 0:
		transitioned.emit(self, "Idle")
