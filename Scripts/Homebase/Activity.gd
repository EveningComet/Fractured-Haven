## A thing that can change a character's stats permanently.
class_name Activity extends Resource

@export var localization_name: String = "New Activity"

@export var participants: Array[CharacterData] = []

@export var changed_stats: Array[StatModifier] = []

func perform_stat_changes() -> void:
	for p: CharacterData in participants:
		for mod: StatModifier in changed_stats:
			# TODO: Raising by percentage?
			p.stats.raise_base_value(mod.stat_changing, mod.value)
