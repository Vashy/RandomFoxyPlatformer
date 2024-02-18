extends Node
class_name StateMachine

@export var initial_state: State

var current_state: State
var states: Dictionary = {}

func _ready():
	for state in get_children():
		if state is State:
			states[state.name] = state
			state.transitioned.connect(_on_state_transition)
	if initial_state:
		initial_state.enter()
	current_state = initial_state

func force_change_state(new_state_name: String):
	var new_state: State = states[new_state_name]
	if not new_state_name:
		print("new_state %s not found!" % [new_state_name])
		return
	if current_state:
		current_state.exit()
	current_state = new_state
	new_state.enter()

func _process(_delta: float):
	if current_state:
		current_state.update(_delta)

func _physics_process(_delta: float):
	if current_state:
		current_state.physics_update(_delta)

func _on_state_transition(from_state: State, new_state_name: String):
	if from_state != current_state:
		print("[warn] wrong from state: %s, current_state is: %s" % [from_state.name, current_state.name])
		return

	var new_state = states[new_state_name]
	if not new_state:
		print("new_state is nil")
		return

	if current_state:
		current_state.exit()
	current_state = new_state
	new_state.enter()
