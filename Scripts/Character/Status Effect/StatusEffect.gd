## A thing that exists on a character and does something to them.
class_name StatusEffect extends Resource

@export_category("Base Info")
@export var localization_name:                  String = "New Status Effect"
@export_multiline var localization_description: String = "New description."
@export var display_icon: Texture2D

@export_category("Definitions")
## How long, in seconds, this status effect lasts.
@export var base_duration: float = 10.0

## For statuses that do something overtime, how long, in seconds, before it
## does its thing?
@export var tick_rate: float = 1.0

## A quick, and dirty, way for a [StatusEffect] to be considered negative.
@export var is_negative: bool = false

@export var apply_effects:  Array[StatusEffectDefinition] = []
@export var tick_effects:   Array[StatusEffectDefinition] = []
@export var expire_effects: Array[StatusEffectDefinition] = []

## If this status has no lifetime, it is considered infinite.
func is_infinite() -> bool:
	return base_duration == 0.0

func trigger_on_apply(target: CharacterData) -> void:
	for e in apply_effects:
		e.trigger(target)

func trigger_on_tick(target: CharacterData) -> void:
	for e in tick_effects:
		e.trigger(target)

func trigger_on_expire(target: CharacterData) -> void:
	for e in apply_effects:
		e.remove(target)
	for e in expire_effects:
		e.trigger(target)
