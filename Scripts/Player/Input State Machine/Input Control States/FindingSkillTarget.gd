## For when the player is actively looking for a target for a skill.
class_name FindingSkillTarget extends PlayerInputControlState

var _unit:  Actor     = null ## The character that is performing the skill.
var _skill: SkillData = null ## The skill being performed.

func enter(msgs: Dictionary = {}) -> void:
	match msgs:
		{"user": var user, "skill": var skill}:
			_unit  = user
			_skill = skill

func exit() -> void:
	_unit  = null
	_skill = null
