## Stores an instance of a character.
class_name CharacterData extends Resource

@export var char_name: String = "Name"

## Stores data related to the character's level.
@export var char_level: CharLevel = CharLevel.new()

## The character's current stats.
@export var stats: CharacterStats = CharacterStats.new()

## The character's current skills.
@export var skills: Array[SkillData] = []

@export var traits: Array[Trait] = []
