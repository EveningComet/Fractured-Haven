## The bare minimum for an AI in this game. It will simply stand in a [Partition],
## and loop through the skills.
class_name SimpleAI extends Node

@onready var _skill_handler: SkillHandler = Utils.get_node_of_type(get_parent(), SkillHandler)

@onready var _actor: Actor = get_parent() as Actor

@export_category("AI")
## How long before this AI will do anything.
@export var decision_rate: float = 0.5
var _curr_wait_time: float = 0.0

func _physics_process(delta: float) -> void:
	_tick(delta)

func perform_skill() -> void:
	# Don't interrupt any skill currently being executed
	if _skill_handler.curr_state is not SHIdle:
		return
		
	# TODO: Testing. Implement better system.
	var targeting_data: TargetingData = TargetingData.new(_actor, [_actor.partition])
	for a: Actor in _actor.partition.monitored:
		if a.faction_owner.is_on_same_team(_actor.faction_owner) == false:
			targeting_data.units.append(a)
			break
	if targeting_data.units.size() > 0:
		_skill_handler.queue(_skill_handler.skills[0], targeting_data)
	
	_curr_wait_time = 0.0

func _tick(delta: float) -> void:
	_curr_wait_time += delta
	if _curr_wait_time >= decision_rate:
		perform_skill()
