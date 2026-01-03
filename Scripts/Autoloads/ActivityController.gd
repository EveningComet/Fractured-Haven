## Responsible for managing the activities.
extends Node

var activities: Array[Activity] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_load_base_activities()

func _load_base_activities() -> void:
	var data_path: String = "res://Game Data/Activity/Base Activities/"
	var dir = DirAccess.open( data_path )
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tres") == true:
				var activity = load(
					data_path + "/" + file_name
				)
				if OS.is_debug_build() == true:
					print("ActivityController :: Loaded activity: %s" % [activity.localization_name])
				activities.append( activity )
			file_name = dir.get_next()
		dir.list_dir_end()
	if OS.is_debug_build() == true:
		print("ActivityController :: Loaded activities: %s" % [activities])

## Go through the held activities and make the objects perform the stat changes.
func perform_stat_changes() -> void:
	for activity: Activity in activities:
		activity.perform_stat_changes()
