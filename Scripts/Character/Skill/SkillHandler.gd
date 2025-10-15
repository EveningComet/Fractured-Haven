## Handles the execution of skills for a character.
class_name SkillHandler extends Node

@onready var combatant: Combatant = Utils.get_node_of_type(get_parent(), Combatant)

## The attached skills.
var skills: Array[SkillInstance] = []

func _ready() -> void:
	initialize()

func _physics_process(delta: float) -> void:
	_tick(delta)

func initialize() -> void:
	skills.clear()
	for sd: SkillData in combatant.character_data.skills:
		var si: SkillInstance = SkillInstance.new(sd)
		skills.append(si)

func _tick(delta: float) -> void:
	# Creating a copy in case the skills get altered in anyway.
	var copy: Array[SkillInstance] = skills.duplicate()
	for si: SkillInstance in copy:
		if si.is_cooldown_finished() == false:
			si.tick(delta)

# TODO: Prepare the skill execution if there is a cast/activation time.
## Make this character perform the passed skill of the [SkillInstance] object,
## with the passed [TargetingData].
func execute(skill_to_execute: SkillInstance, targeting_data: TargetingData) -> void:
	var sd: SkillData = skill_to_execute.skill
	skill_to_execute.execute(targeting_data)
	combatant.character_data.stats.remove_sp(sd.sp_cost)
