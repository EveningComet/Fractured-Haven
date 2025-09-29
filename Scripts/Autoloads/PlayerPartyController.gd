extends Node

signal party_changed(party: Array[Actor])

## The maximum number of party members the player can have in their party, not
## including summons.
const MAX_PMS_IN_ACTIVE_PARTY: int = 6

## The player's current party.
var active_party: Array[Actor] = []

## Go through the [active_party] and return characters that have hp > 0.
func get_valid_party_members():
	var valid_pms: Array[Actor] = []
	for pm: Actor in active_party:
		if pm.combatant.stats.curr_hp > 0:
			valid_pms.append(pm)
	return valid_pms
	
func add_to_party(new_pm: Actor) -> void:
	active_party.append( new_pm )
	party_changed.emit(active_party)
