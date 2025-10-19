## Handles the execution of skills for a character.
class_name SkillHandler extends StateMachineR

@onready var combatant: Combatant = Utils.get_node_of_type(get_parent(), Combatant)

## The attached skills.
var skills: Array[SkillInstance] = []

var queued_skill: SkillInstance = null
var queued_td:    TargetingData = null

func _ready() -> void:
	setup()

func _physics_process(delta: float) -> void:
	_tick(delta)

func setup() -> void:
	super()
	_states.clear()
	_states[SHIdle]    = SHIdle.new(self)
	_states[SHCasting] = SHCasting.new(self)
	change_to_state(get_initial_state())
	skills.clear()
	for sd: SkillData in combatant.character_data.skills:
		var si: SkillInstance = SkillInstance.new(sd)
		skills.append(si)

func _tick(delta: float) -> void:
	# Update the current state
	_curr_state.physics_update(delta)
	
	# Creating a copy in case the skills get altered in anyway.
	var copy: Array[SkillInstance] = skills.duplicate()
	for si: SkillInstance in copy:
		if si.is_cooldown_finished() == false:
			si.tick(delta)

## Make this character enter the casting/activating state.
func execute(skill_to_execute: SkillInstance, targeting_data: TargetingData) -> void:
	queued_skill   = skill_to_execute
	queued_td      = targeting_data
	change_to_state(SHCasting)

func interrupt() -> void:
	change_to_state(get_initial_state())

func get_initial_state():
	return SHIdle
