## For when the player is actively looking for a target for a skill.
class_name FindingSkillTarget extends PlayerInputControlState

var _unit:  Actor         = null ## The character that is performing the skill.
var _skill: SkillData     = null ## The skill being performed.
var _td:    TargetingData = null

# TODO: Account for the user losing all their hp.
# TODO: Account for the user ending up in another partition.

func enter(msgs: Dictionary = {}) -> void:
	match msgs:
		{"user": var user, "skill": var skill}:
			_unit  = user
			_skill = skill
			_td = TargetingData.new()
			_td.user = _unit
			
			# TODO: Testing. Find a better way. Need to account for self targeting, etc.
			# Get the starting area
			_td.partitions = Board.depth_search([], _td.user.partition, _skill.range.range_in_partitions)
			_td.targets.append(_unit)
			
func exit() -> void:
	_unit  = null
	_skill = null
	_td    = null
	if OS.is_debug_build() == true:
		print("FindingSkillTarget :: Exited.")

func check_for_unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		my_state_machine.change_to_state("DirectingUnits")
	_handle_target_validation(event)
	_handle_skill_execution(event)

func _handle_target_validation(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var camera = _camera_controller.camera
		var m_pos: Vector2 = camera.get_viewport().get_mouse_position()
		var ray_start = camera.project_ray_origin(m_pos)
		var ray_end   = ray_start + camera.project_ray_normal(m_pos) * 1000
		var space_state = camera.get_world_3d().direct_space_state
		# TODO: Separate queries for partitions and characters?
		var query = PhysicsRayQueryParameters3D.create(ray_start, ray_end)
		query.collide_with_areas = true
		var result = space_state.intersect_ray(query)
		if result:
			if result.collider is Partition:
				_td.partitions.clear()
				_td.partitions.append(result.collider)

## Checks if the player has done the input to execute the skill.
func _handle_skill_execution(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		_skill.execute(_td)
		_find_what_state_to_return_to()
		
func _find_what_state_to_return_to() -> void:
	if _selection_controller.curr_pawns.size() > 0:
		my_state_machine.change_to_state("DirectingUnits")
	else:
		my_state_machine.change_to_state("WaitingForUnitSelection")
