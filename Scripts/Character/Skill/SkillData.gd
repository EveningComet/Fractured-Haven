class_name SkillData extends Resource

@export_category("Base Info")
@export           var localization_name:        String = "New Skill"
@export_multiline var localization_description: String = "New description."

@export_category("Definitions")
@export var sp_cost: int = 5

@export var targeting_logic: TargetingLogic = null

## Objects that describe what this does.
@export var effects: Array[SkillEffect] = []

## Perform the skill, with the passed data.
func execute(targeting_data: TargetingData) -> void:
	for e: SkillEffect in effects:
		e.execute(targeting_data)
