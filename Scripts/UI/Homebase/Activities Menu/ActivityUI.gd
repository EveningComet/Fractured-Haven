## UI representation of an [Activity] object.
class_name ActivityUI extends PanelContainer

## The [Activity] this UI represents.
var activity: Activity = null

@export var _roster_ref_prefab: PackedScene

@export_category("UI Components")
@export var display_icon: TextureRect
@export var name_label: Label
@export var _stats_changed_label: Label

@export var _participants_sub_menu:  Container
@export var _participants_container: Container

func _ready() -> void:
	_clear_displayed_participants()
	_participants_sub_menu.hide()

func add_character(cd: CharacterData) -> void:
	activity.add_character(cd)
	
func set_activity(new_a: Activity) -> void:
	activity = new_a
	name_label.set_text(activity.localization_name)
	
	var stats_changed_string: String = ""
	for stat_changed in new_a.changed_stats:
		if new_a.changed_stats.size() > 1:
			stats_changed_string += " "
		print(StatHelper.StatTypes.keys()[stat_changed.stat_changing])
		var stat_name = StatHelper.StatTypes.keys()[stat_changed.stat_changing]
		stats_changed_string += stat_name + "↑"
		# TODO: Check if the stat is positive or negative.
	_stats_changed_label.set_text(stats_changed_string)
	
	_participants_sub_menu.show()

func _clear_displayed_participants() -> void:
	for c in _participants_container.get_children():
		c.queue_free()

func _update_displayed_participants() -> void:
	pass
