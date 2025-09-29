## Handles displaying the party to the player.
class_name PartyDisplayer extends PanelContainer

@export var pm_button_prefab: PackedScene

## The node storing the displayable party.
@export var _party_container: Container

func _ready() -> void:
	PlayerPartyController.party_changed.connect(_on_party_changed)
	_on_party_changed(PlayerPartyController.active_party)

func _clear_contents() -> void:
	for c in _party_container.get_children():
		c.queue_free()

func _on_party_changed(party: Array[Actor]) -> void:
	_clear_contents()
	for pm: Actor in party:
		var pm_button: PartyMemberClickableButton = pm_button_prefab.instantiate()
		pm_button.set_party_member(pm)
		_party_container.add_child(pm_button)
