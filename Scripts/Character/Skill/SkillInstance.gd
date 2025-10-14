class_name SkillInstance extends Resource

## The attached skill.
var skill: SkillData

var curr_cooldown: float = 0.0

func _init(sd: SkillData) -> void:
	skill = sd

func tick(delta: float) -> void:
	curr_cooldown += delta
	
func execute(targeting_data: TargetingData) -> void:
	skill.execute(targeting_data)
	curr_cooldown = 0.0
