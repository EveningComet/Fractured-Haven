## For status effects that do things when being applied to a character.
class_name ApplySED extends StatusEffectDefinition

func trigger(target: CharacterData) -> void:
	_apply(target)
