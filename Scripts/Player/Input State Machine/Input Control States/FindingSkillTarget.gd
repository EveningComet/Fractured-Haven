## For when the player is actively looking for a target for a skill.
class_name FindingSkillTarget extends PlayerInputControlState

var _unit:  Actor         = null ## The character that is performing the skill.
var _skill: SkillInstance = null ## The skill being performed.
var _td:    TargetingData = null
var _result               = null ## Stores the raycast info.
var _targetables: Array[Node]

func enter(msgs: Dictionary = {}) -> void:
	match msgs:
		{"user": var user, "skill": var skill}:
			_unit  = user
			_skill = skill
			_unit.combatant.character_data.stats.hp_depleted.connect(_on_hp_depleted)
			_unit.partition_changed.connect(_on_partition_changed)
			_td = TargetingData.new()
			_td.user = _unit
			
			_update_targetables()
			
func exit() -> void:
	if _unit != null:
		_unit.combatant.character_data.stats.hp_depleted.disconnect(_on_hp_depleted)
		_unit.partition_changed.disconnect(_on_partition_changed)
	_unit   = null
	_skill  = null
	_td     = null
	_result = null
	_targetables.clear()

func check_for_unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_find_what_state_to_return_to()
		return
	_handle_target_validation(event)
	_handle_skill_execution(event)

# TODO: Rename this method?
func _handle_target_validation(event: InputEvent) -> void:
	var camera = _camera_controller.camera
	var m_pos: Vector2 = camera.get_viewport().get_mouse_position()
	_result = _skill.skill.validator.get_raycast_info( m_pos, camera )
	if _result:
		var targetable: Node = _result.collider
		if _targetables.has(targetable) == true and _skill.skill.validator.is_valid(targetable) == true:
			# TODO: AOE needs to get the final target(s).
			if targetable is Partition:
				_td.partitions.clear()
				_td.partitions.append(targetable as Partition)
			elif targetable is Actor:
				_td.units.clear()
				_td.units.append(targetable as Actor)

## Checks if the player has done the input to execute the skill.
func _handle_skill_execution(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		_unit.skill_handler.queue(_skill, _td)
		_find_what_state_to_return_to()
		
func _find_what_state_to_return_to() -> void:
	if _selection_controller.curr_pawns.size() > 0:
		my_state_machine.change_to_state("DirectingUnits")
	else:
		my_state_machine.change_to_state("WaitingForUnitSelection")

## Bail when the character is defeated.
func _on_hp_depleted(stats: CharacterStats) -> void:
	_find_what_state_to_return_to()

## Refresh the targets if the character changed where they were, somehow.
func _on_partition_changed(character: Actor) -> void:
	_update_targetables()

func _update_targetables() -> void:
	_targetables.clear()
	var ts: Array[Node] = _skill.skill.range.get_targetables_in_range(_unit.partition)
	_targetables.append_array( ts )
