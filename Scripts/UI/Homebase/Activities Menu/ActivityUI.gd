## UI representation of an [Activity] object.
class_name ActivityUI extends PanelContainer

signal roster_ref_spawned(rr: RosterReference)

@export var _roster_ref_prefab: PackedScene

@export_category("UI Components")
@export var display_icon: TextureRect
@export var name_label: Label
@export var _stats_changed_label: Label

@export var _participants_sub_menu:  Container
@export var _participants_container: Container

## The [Activity] this UI represents.
var activity: Activity = null
var participants: Array[CharacterData]:
	get: return activity.participants

func add_character(cd: CharacterData) -> void:
	activity.add_character(cd)
	_update_displayed_participants()
	
func set_activity(new_a: Activity) -> void:
	activity = new_a
	name_label.set_text(activity.localization_name)
	
	var stats_changed_string: String = ""
	for stat_changed in new_a.changed_stats:
		if new_a.changed_stats.size() > 1:
			stats_changed_string += " "
		var stat_name = StatHelper.StatTypes.keys()[stat_changed.stat_changing]
		stats_changed_string += stat_name + "↑"
		# TODO: Check if the stat is positive or negative.
	_stats_changed_label.set_text(stats_changed_string)
	
	_update_displayed_participants()

func _clear_displayed_participants() -> void:
	for c in _participants_container.get_children():
		c.queue_free()

func _update_displayed_participants() -> void:
	_clear_displayed_participants()
	_participants_sub_menu.hide()
	if activity.participants.size() > 0:
		for cd: CharacterData in participants:
			var rr: RosterReference = _roster_ref_prefab.instantiate()
			rr.character_ref = cd
			_participants_container.add_child(rr)
			_participants_sub_menu.show()
			# TODO: Probable oversight. What if the player wants to edit the equipement/skills
			# of someone in an activity?
			rr.pressed.connect( _on_roster_ref_selected.bind(rr) )
			
			# Tell anything that cares about the spawning
			roster_ref_spawned.emit(rr)

## Used as a quick way to clean things up.
func _on_roster_ref_selected(rr: RosterReference) -> void:
	participants.erase(rr.character_ref)
	_update_displayed_participants()
