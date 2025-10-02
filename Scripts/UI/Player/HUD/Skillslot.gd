@tool
## Displays a usable skill to the player.
class_name Skillslot extends Button

@export var skill: SkillData = null:
	get: return skill
	set(value):
		skill = value
		if skill != null:
			display_icon.set_texture(skill.icon)

@export var display_icon: TextureRect

## The character this skill is tied to.
var _user: Actor = null

func setup(user: Actor = null, sd: SkillData = null) -> void:
	_user = user
	skill = sd
