@tool
## Displays a usable skill to the player.
class_name Skillslot extends Button

signal skill_button_pressed(user: Actor, skill: SkillData)

@export var skill: SkillInstance = null:
	get: return skill
	set(value):
		skill = value
		if skill != null:
			display_icon.set_texture(skill.skill.icon)

@export var display_icon: TextureRect

## Displays the cooldown.
@export var cooldown_bar: ProgressBar

@export var cooldown_label: Label

## Used as a quick way to keep track of the cooldown.
@onready var timer: Timer = $Timer # TODO: Cooldown float instead?

## The character this skill is tied to.
var _user: Actor = null

func setup(user: Actor = null, si: SkillInstance = null) -> void:
	_user = user
	skill = si

func _physics_process(delta: float) -> void:
	var time_left = timer.time_left
	cooldown_bar.value = time_left
	cooldown_label.set_text("%3.1f" % time_left)
	if time_left <= 0.0:
		cooldown_label.hide()
	else:
		cooldown_label.show()
