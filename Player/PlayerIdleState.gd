extends State

@export var player: Player

func enter():
	%AnimationPlayer.play("Idle")

func update(_delta: float):
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		transitioned.emit(self, "Jump")

	var direction = player.calculate_direction_from_input()
	if direction != 0:
		transitioned.emit(self, "Run")
