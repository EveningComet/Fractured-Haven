## A simple component that displays a name and a value.
class_name ValueDisplayer extends MarginContainer

@export var name_label:  Label
@export var value_label: Label

func update_display(display_name: String, value_to_display: String) -> void:
	name_label.set_text(  display_name     )
	value_label.set_text( value_to_display )
