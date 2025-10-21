## A version of the state machine that uses Godot's resource class for the states.
class_name StateMachineR extends Node

var _states: Dictionary[Variant, Variant] = {}
var curr_state: StateR = null

func _ready() -> void:
	setup()

func setup() -> void:
	pass

func change_to_state(state_to_enter, msgs: Dictionary = {}) -> void:
	if _states.has(state_to_enter) == false:
		return
	if curr_state != null:
		curr_state.exit()
	curr_state = _states[state_to_enter]
	curr_state.enter(msgs)

func _get_initial_state():
	return null
