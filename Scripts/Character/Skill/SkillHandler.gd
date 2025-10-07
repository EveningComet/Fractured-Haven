## Handles the execution of skills for a character.
class_name SkillHandler extends Node

@onready var combatant: Combatant = Utils.get_node_of_type(get_parent(), Combatant)
var _skills: Array[SkillData] = []

func _ready() -> void:
	_skills = combatant.character_data.skills
