## Handles selecting a player's [Pawn]s.
## Manages selecting characters for the player.
class_name SelectionController extends Node

signal pawns_selected(selected_pawns: Array[Actor])

## The component used to display the selection to the player.
@export var selection_box: SelectionBox = null

## The currently selected characters.
var curr_pawns: Array[Actor] = []
var _stats_to_pawn: Dictionary[CharacterStats, Actor] = {}

var _dragging:   bool    = false
var _drag_start: Vector2 = Vector2.ZERO
var _ray_length: float = 1000.0
var _min_drag_dist: float = 16.0

func _unhandled_input(event: InputEvent) -> void:
	var m_pos: Vector2 = get_viewport().get_mouse_position()
	if event.is_action_pressed("left_click") and _dragging == false:
		clear_selection()
		_drag_start = m_pos
		_dragging = true
		selection_box.draw_selection(_drag_start, m_pos, _dragging)
	
	if event is InputEventMouseMotion and _dragging == true:
		m_pos = event.position
		selection_box.draw_selection(_drag_start, m_pos, _dragging)
	
	if event.is_action_released("left_click") and _dragging == true:
		select_units_from_projection(m_pos)
		_dragging = false
		selection_box.draw_selection(_drag_start, m_pos, _dragging)

func clear_selection() -> void:
	for p: Actor in curr_pawns:
		pass
		#p.combatant.stats.hp_depleted.disconnect(_on_hp_depleted)
	curr_pawns.clear()
	_stats_to_pawn.clear()
	pawns_selected.emit(curr_pawns)

## Attempt to select units within the created box.
func select_units_from_projection(m_pos: Vector2) -> void:
	if m_pos.distance_squared_to(_drag_start) < _min_drag_dist:
		var u: Actor = _get_unit_under_mouse(m_pos)
		if u != null:
			curr_pawns.append(u)
	else:
		var x_min = min(_drag_start.x, m_pos.x)
		var y_min = min(_drag_start.y, m_pos.y)
		var rect = Rect2(
			x_min, y_min,
			max(_drag_start.x, m_pos.x) - x_min,
			max(_drag_start.y, m_pos.y) - y_min
		)
		var cam = get_viewport().get_camera_3d()
		for u: Actor in PlayerPartyController.active_party:
			if rect.has_point(cam.unproject_position(u.global_position)):
				_stats_to_pawn[u.combatant.character_data.stats] = u
				curr_pawns.append(u)
	pawns_selected.emit(curr_pawns)

func _get_unit_under_mouse(m_pos: Vector2):
	var result = Utils.raycast_mouse(m_pos, get_viewport().get_camera_3d(), _ray_length)
	if result and result.collider is Actor and PlayerPartyController.active_party.has(result.collider):
		return result.collider

## Deselect characters that have ran out of health.
func _on_hp_depleted(stats: CharacterStats) -> void:
	if _stats_to_pawn.has(stats) == true:
		curr_pawns.erase( _stats_to_pawn[stats] )
		_stats_to_pawn.erase(stats)
	pawns_selected.emit(curr_pawns)
