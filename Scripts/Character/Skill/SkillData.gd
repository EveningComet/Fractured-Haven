class_name SkillData extends Resource

@export_category("Base Info")
@export           var localization_name:        String = "New Skill"
@export_multiline var localization_description: String = "New description."

@export var icon: Texture2D

@export_category("Definitions")
@export_range(0.0, 100.0) var success_rate: float = 90.0

@export var sp_cost: int = 5
# TODO: What if the skill should cost health?

## Defines the "reach" of a skill.
@export var range: TargetingRange = null

## Defines what around the target may be additionally targeted.
@export var aoe:   TargetingAOE   = null

## How far away, in meters, the character has to be perform this skill. Mainly
## for skills that target a specific character.`
@export var action_range: float = 5.0

## Objects that describe what this does.
@export var effects: Array[SkillEffect] = []

## Perform the skill, with the passed data.
func execute(targeting_data: TargetingData) -> void:
	for e: SkillEffect in effects:
		e.execute(targeting_data)
