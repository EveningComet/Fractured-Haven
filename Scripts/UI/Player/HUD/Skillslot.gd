@tool
## Displays a usable skill to the player.
class_name Skillslot extends Button

signal skill_button_pressed(user: Actor, skill: SkillData)

@export var skill: SkillData = null:
	get: return skill
	set(value):
		skill = value
		if skill != null:
			display_icon.set_texture(skill.icon)

@export var display_icon: TextureRect

## The character this skill is tied to.
var _user: Actor = null

#func _ready() -> void:
	#pressed.connect(_on_pressed)

func setup(user: Actor = null, sd: SkillData = null) -> void:
	_user = user
	skill = sd

#func _on_pressed() -> void:
	#pass
