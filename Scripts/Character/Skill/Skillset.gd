## Stores a collection of skills/powers.
class_name Skillset extends Resource

@export_category("Base Info")
@export           var localization_name:        String = "New Set"
@export_multiline var localization_description: String = "New description."

@export_category("Skills/Powers")
## The things associated with this set.
@export var skills: Array[SkillData] = []
