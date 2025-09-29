class_name SkillData extends Resource

@export_category("Base Info")
@export           var localization_name:        String = "New Skill"
@export_multiline var localization_description: String = "New description."

@export_category("Definitions")
## Objects that describe what this does.
@export var effects: Array[SkillEffect] = []

func execute(targeting_data: TargetingData) -> void:
	for e: SkillEffect in effects:
		e.execute(targeting_data)
