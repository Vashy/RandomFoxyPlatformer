extends CharacterBody2D
class_name Eagle

@export var difficulty := 5
var dying = false

func _physics_process(_delta: float):
	move_and_slide()

func _on_player_collision_body_entered(body):
	if body is Player and not body.is_invincible():
		body.hit()

func _on_damage_collision_body_entered(body):
	if body is Player and not body.is_invincible():
		body.enemy_defeated()
		$StateMachine.force_change_state("Dead")
