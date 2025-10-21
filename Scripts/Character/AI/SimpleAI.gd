## The bare minimum for an AI in this game. It will simply stand in a [Partition],
## and loop through the skills.
class_name SimpleAI extends Node

@onready var skill_handler: SkillHandler = Utils.get_node_of_type(get_parent(), SkillHandler)

@export_category("AI")
## How long before this AI will do anything.
@export var decision_rate: float = 0.5

func perform_skill() -> void:
	# Don't interrupt any skill currently being executed
	if skill_handler.curr_state is not SHIdle:
		return
