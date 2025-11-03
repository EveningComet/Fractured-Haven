## Stores an instance of a character.
class_name CharacterData extends Resource

@export var char_name: String = "Name"

## Mainly used for level ups.
@export var base_blueprint: CreatureBlueprint

## Stores data related to the character's level.
@export var char_level: CharLevel = CharLevel.new()

## The character's current stats.
@export var stats: CharacterStats = CharacterStats.new()

@export var equipment: EquipmentInventory = EquipmentInventory.new(self)

## The character's current skills.
@export var skills: Array[SkillData] = []

@export var traits: Array[Trait]     = []

@export var status_effect_holder: StatusEffectHolder = StatusEffectHolder.new(self)

## Called to initialize a character.
func init() -> void:
	if char_level != null:
		char_level.leveled_up.connect(_on_leveled_up)

func initialize_new_character(blueprint: CreatureBlueprint) -> void:
	base_blueprint = blueprint
	if char_level != null:
		char_level.leveled_up.connect(_on_leveled_up)
	stats = base_blueprint.base_stats.duplicate_deep()

func _on_leveled_up() -> void:
	# TODO: Implement a more proper way of raising stats on a level up.
	_test_level_up_stats_boost()
	if OS.is_debug_build() == true:
		print("CharacterData :: Noticed that the character has leveled up.")
	
func _test_level_up_stats_boost() -> void:
	stats.raise_base_value(StatHelper.StatTypes.MaxHP, 5.0)
	stats.raise_base_value(StatHelper.StatTypes.MaxSP, 5.0)
