## Stores the base data for a creature that can be captured.
class_name CreatureBlueprint extends Resource

@export_category("Base Info")
@export           var localization_name:        String = "New Creature"
@export_multiline var localization_description: String = "Deepest lore."

@export_category("Visuals/Models/Etc.")
@export var model: PackedScene ## TODO: What if some creatures had variants/skins/costumes?

@export_category("Stats")
## The default stats for this character.
@export var base_stats: CharacterStats = CharacterStats.new()

## Stores the [Trait]s that this character can spawn with.
@export var traits: Array[Trait] = []

@export_category("Skills")
## The skills this character could spawn with.
@export var skills: Array[SkillData] = []

@export_category("Drops")
@export var exp_on_death: int = 10
