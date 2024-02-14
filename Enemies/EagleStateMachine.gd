extends Node2D

@export var initial_state: State

var current_state: State
var states: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transitioned.connect(on_child_transition)

	if initial_state:
		initial_state.enter()
		current_state = initial_state

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float):
	if current_state:
		current_state.physics_update(delta)

func on_child_transition(state: State, new_state_name: String):
	if state != current_state:
		return

	var new_state: State = states.get(new_state_name)
	if !new_state:
		return

	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
