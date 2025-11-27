@abstract
## Defines how a [Trait] will effect a character.
class_name TraitEffect extends Resource

## Lots of traits will modify a stat.
@export var stat_modifier: StatModifier = null

func apply(cd: CharacterData) -> void:
	if stat_modifier != null:
		cd.stats.add_modifier(
			stat_modifier.stat_changing, stat_modifier
		)

func remove(cd: CharacterData) -> void:
	if stat_modifier != null:
		cd.stats.remove_modifier(
			stat_modifier.stat_changing, stat_modifier
		)
