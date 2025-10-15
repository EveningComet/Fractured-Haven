class_name SkillInstance extends Resource

signal instance_executed(si: SkillInstance)

## The attached skill.
var skill: SkillData

var curr_cooldown: float = 0.0

func _init(sd: SkillData) -> void:
	skill = sd

func tick(delta: float) -> void:
	curr_cooldown -= delta
	curr_cooldown = clamp(curr_cooldown, 0.0, skill.base_cooldown)
	
func execute(targeting_data: TargetingData) -> void:
	skill.execute(targeting_data)
	curr_cooldown = skill.base_cooldown
	instance_executed.emit(self)

func is_cooldown_finished() -> bool:
	return curr_cooldown <= 0.0
