## The state where the character will actually perform the skill they queued.
class_name SHExecuting extends SHState

# TODO: Find a better way to handle the skill execution.
# For now, we'll just have a set amount of time that this state can be in.
var _execution_time: float = 0.0
var _curr_time:      float = 0.0

func enter(msgs: Dictionary ={}) -> void:
	if OS.is_debug_build() == true:
		print("SHExecuting :: Entered.")
	_execution_time = 3.0
	_curr_time = 0.0
	_execute()

func exit() -> void:
	_curr_time      = 0.0
	_execution_time = 0.0

func physics_update(delta: float) -> void:
	_curr_time += delta
	if _curr_time >= _execution_time:
		_my_state_machine.change_to_state(SHIdle) 

## Make the character perform the skill.
func _execute() -> void:
	_queued_skill.execute(_queued_td)
