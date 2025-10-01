@tool
## A class that is used for things such as hp bars, sound volume, etc.
class_name BarDisplayer extends ProgressBar

@export var uses_label: bool = false:
	get: return uses_label
	set(value):
		uses_label = value
		if uses_label == true and value_label != null:
			value_label.show()
		elif uses_label == false and value_label != null:
			value_label.hide()

@export var value_label: Label

## Update the display with the passed values.
func update_display(new_value: int, max_v: int = 100) -> void:
	max_value = max_v
	value     = new_value
	
	if uses_label == true:
		value_label.set_text( str(new_value) )
