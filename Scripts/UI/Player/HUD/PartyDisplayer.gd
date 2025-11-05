## Handles displaying the party to the player.
class_name PartyDisplayer extends PanelContainer

@export var pm_button_prefab: PackedScene

## The node storing the displayable party.
@export var _party_container: Container

var _selection_controller: SelectionController

func _ready() -> void:
	_clear_contents()
	PlayerPartyController.party_changed.connect(_on_party_changed)
	_on_party_changed(PlayerPartyController.party_as_actors)

func setup(sc: SelectionController) -> void:
	_selection_controller = sc

func _clear_contents() -> void:
	for c in _party_container.get_children():
		c.queue_free()

func _on_party_changed(party: Array[Actor]) -> void:
	_clear_contents()
	for pm: Actor in party:
		var pm_button: PartyMemberClickableButton = pm_button_prefab.instantiate()
		pm_button.set_party_member(pm)
		pm_button.pressed.connect( _on_pm_button_pressed.bind(pm) )
		_party_container.add_child(pm_button)

## When the player presses one of the party member buttons, select that character.
func _on_pm_button_pressed(pm: Actor) -> void:
	_selection_controller.select_unit_through_button(pm)
