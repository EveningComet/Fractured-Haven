## A permanent, special modifier to a character.
class_name Trait extends Resource

@export_category("Base Info")
@export           var localization_name:        String = "New Trait"
@export_multiline var localization_description: String = "New description."

@export_category("Definitions")
## The objects that define this trait.
@export var effects: Array[TraitEffect] = []

func apply(character: CharacterData) -> void:
	character.traits.append(self)

func remove(character: CharacterData) -> void:
	character.traits.erase(self)
