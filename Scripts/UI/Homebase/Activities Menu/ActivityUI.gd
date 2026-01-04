## UI representation of an [Activity] object.
class_name ActivityUI extends PanelContainer

## The [Activity] this UI represents.
var activity: Activity = null

@export_category("UI Components")
@export var display_icon: TextureRect
@export var name_label: Label
# TODO: Label for showing what stats will be changed.
# TODO: Container for showing the characters in the activity.

func add_character(cd: CharacterData) -> void:
	activity.add_character(cd)
	
func set_activity(new_a: Activity) -> void:
	activity = new_a
	name_label.set_text(activity.localization_name)
