## Displays a usable skill to the player.
class_name Skillslot extends Button

signal skill_button_pressed(user: Actor, skill: SkillData)

@export var skill: SkillInstance = null:
	get: return skill
	set(value):
		if skill != null:
			skill.instance_executed.disconnect(_on_executed)
		skill = value
		if skill != null:
			skill.instance_executed.connect(_on_executed)
			cooldown_bar.max_value = skill.skill.base_cooldown
			if skill.is_cooldown_finished() == false:
				_time_left = skill.curr_cooldown
				cooldown_bar.show()
				cooldown_label.show()
			display_icon.set_texture(skill.skill.icon)

@export var display_icon: TextureRect

## Displays the cooldown.
@export var cooldown_bar: ProgressBar

@export var cooldown_label: Label

## Represents how much time is left on the cooldown.
var _time_left: float = 0.0

## The character this skill is tied to.
var _user: Actor = null

func setup(user: Actor = null, si: SkillInstance = null) -> void:
	skill = si
	_user = user

func _physics_process(delta: float) -> void:
	_time_left = skill.curr_cooldown
	cooldown_bar.value = _time_left
	cooldown_label.set_text("%3.1f" % _time_left)
	if _time_left <= 0.0:
		cooldown_label.hide()
		cooldown_bar.hide()
	else:
		cooldown_label.show()
		cooldown_bar.show()
	
	if _time_left > 0.0 or \
	_user.combatant.character_data.stats.curr_sp < skill.skill.sp_cost:
		disabled = true
	else:
		disabled = false

## Called when the attached skill is doing something.
func _on_executed(si: SkillInstance) -> void:
	_time_left = si.skill.base_cooldown
