## When the character is activating/casting the skill.
class_name SHCasting extends SHState

var _activation_time: float = 0.0
var _curr_time:       float = 0.0

func enter(msgs: Dictionary = {}) -> void:
	if OS.is_debug_build() == true:
		print("SHCasting :: Entered.")
	_activation_time = Formulas.get_activation_time(
		_my_state_machine.queued_skill.skill,
		_stats
	)
	_curr_time = 0.0
	_stats.remove_sp(_queued_skill.skill.sp_cost)

func exit() -> void:
	_activation_time = 0.0
	_curr_time       = 0.0

func physics_update(delta: float) -> void:
	if _curr_time >= _activation_time:
		_queued_skill.execute(_queued_td)
		_my_state_machine.change_to_state(SHIdle)
		return
	_curr_time += delta
