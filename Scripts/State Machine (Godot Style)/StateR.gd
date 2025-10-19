@abstract
## A version of a state in a state machine that uses the Godot Resource class.
class_name StateR extends Resource

## What to do when entering this state
func enter(msgs: Dictionary = {}) -> void:
	pass
	
## What to do when exiting this state
func exit() -> void:
	pass

## Gets called through our state machine's _input method
func check_for_handle_input(event: InputEvent) -> void:
	pass
	
## Some states will need to modify special inputs.
func check_for_unhandled_input(event: InputEvent) -> void:
	pass
	
## When you need to update every frame.
func process_update(delta: float) -> void:
	pass
	
## When we need to update every physics frame.
func physics_update(delta: float) -> void:
	pass
