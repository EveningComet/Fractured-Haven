## Handles displaying the roster to the player. It also is used to display the
## player's active party.
class_name RosterDisplayer extends PanelContainer

## Fired when the player interacts with 
signal roster_ref_selected(rr: RosterReference)

signal roster_ref_spawned(rr: RosterReference)

## Container that holds the displayed characters.
@export var _roster_container: Container
@export var _roster_reference_prefab: PackedScene

## Does this use the player's party instead of the roster?
@export var _is_for_active_party: bool = false

func _ready() -> void:
	await get_parent().ready
	if _is_for_active_party == false:
		PlayerPartyController.roster_changed.connect( _on_roster_changed )
		_on_roster_changed(PlayerPartyController.roster)
	else:
		PlayerPartyController.party_changed.connect( _on_roster_changed )
		_on_roster_changed(PlayerPartyController.active_party)

func _clear_display() -> void:
	for c in _roster_container.get_children():
		c.queue_free()

func add_to_roster(cd: CharacterData) -> void:
	if _is_for_active_party == false:
		PlayerPartyController.add_to_roster(cd)
	else:
		PlayerPartyController.add_to_party(cd)

func _on_roster_changed(new_roster: Array[CharacterData]) -> void:
	_clear_display()
	for cd: CharacterData in new_roster:
		var rr: RosterReference = _roster_reference_prefab.instantiate()
		rr.character_ref = cd
		_roster_container.add_child(rr)
		rr.pressed.connect(_on_roster_ref_selected.bind(rr))
		
		# Tell anything that cares about the spawned item
		roster_ref_spawned.emit(rr)

func _on_roster_ref_selected(rr: RosterReference) -> void:
	roster_ref_selected.emit(rr)
