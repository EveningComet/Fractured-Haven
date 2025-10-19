@abstract
## The states that will belong to a [SkillHandler].
class_name SHState extends StateR

var _my_state_machine: SkillHandler
var _queued_skill: SkillInstance:
	get: return _my_state_machine.queued_skill
var _queued_td: TargetingData:
	get: return _my_state_machine.queued_td
var _stats: CharacterStats:
	get: return _my_state_machine.combatant.character_data.stats

func _init(new_sm: SkillHandler = null) -> void:
	_my_state_machine = new_sm
