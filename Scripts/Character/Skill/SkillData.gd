class_name SkillData extends Resource

@export_category("Base Info")
@export           var localization_name:        String = "New Skill"
@export_multiline var localization_description: String = "New description."

@export var icon: Texture2D

@export_category("Definitions")
@export var sp_cost: int = 5
# TODO: What if the skill should cost health?

@export var targeting_logic: TargetingLogic = null

## How far away, in [Partition]s, does this skill "reach?"
@export var range_in_partitions: int = 0

## Range in meters. This is mainly for targeting characters within the same
## [Partition].
@export var range: float = 5.0

## Objects that describe what this does.
@export var effects: Array[SkillEffect] = []

## Perform the skill, with the passed data.
func execute(targeting_data: TargetingData) -> void:
	for e: SkillEffect in effects:
		e.execute(targeting_data)
